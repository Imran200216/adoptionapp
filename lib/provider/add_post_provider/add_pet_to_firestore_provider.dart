import 'dart:io';
import 'package:adoptionapp/helper/debounce_helper.dart';
import 'package:adoptionapp/modals/pet_modal.dart';
import 'package:adoptionapp/provider/screen_provider/bottom_nav_provider.dart';
import 'package:adoptionapp/widgets/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddPetToFireStoreProvider extends ChangeNotifier {
  /// Debounce helper
  final DebounceHelper _debounceHelper = DebounceHelper();

  /// TextEditingControllers for form fields
  TextEditingController petNameController = TextEditingController();
  TextEditingController petBreedController = TextEditingController();
  TextEditingController petDescriptionController = TextEditingController();
  TextEditingController petAgeController = TextEditingController();
  TextEditingController petWeightController = TextEditingController();
  TextEditingController petLocationController = TextEditingController();
  TextEditingController petOwnerPhoneController = TextEditingController();
  TextEditingController petOwnerNameController = TextEditingController();

  // Properties for pet details
  String _selectedPetType = 'Dog';
  String _selectedGender = 'male';
  String _vaccinationStatus = 'Vaccination Done';
  int _selectedPetAge = 1;
  List<File> petImages = [];

  /// Loading state
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Page controller for the image slider
  PageController pageController = PageController();

  // Firebase Storage and Firestore instances
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Getters for selected values
  String get selectedPetType => _selectedPetType;

  String get selectedGender => _selectedGender;

  String get vaccinationStatus => _vaccinationStatus;

  int get selectedPetAge => _selectedPetAge;

  /// Methods for setting values
  void setPetAge(int value) {
    _selectedPetAge = value;
    notifyListeners();
  }

  void setPetType(String value) {
    _selectedPetType = value;
    notifyListeners();
  }

  void setGender(String value) {
    _selectedGender = value;
    notifyListeners();
  }

  void setVaccinationStatus(String value) {
    _vaccinationStatus = value;
    notifyListeners();
  }

  /// Method to pick an image from gallery or camera
  Future<void> pickImage(ImageSource source, BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      petImages.add(File(pickedFile.path));
      ToastHelper.showSuccessToast(
        context: context,
        message: "Image picked successfully!",
      );
      notifyListeners();
    } else {
      ToastHelper.showErrorToast(
        context: context,
        message: "No image selected!",
      );
    }
  }

  /// Method to upload images to Firebase Storage and return the list of URLs
  Future<List<String>> uploadImages(
      String petName, BuildContext context) async {
    List<String> imageUrls = [];

    for (File image in petImages) {
      try {
        Reference storageRef =
            _storage.ref().child('pets/$petName/${DateTime.now()}.jpg');
        UploadTask uploadTask = storageRef.putFile(image);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      } catch (e) {
        ToastHelper.showErrorToast(
          context: context,
          message: "Failed to upload image: $e",
        );
      }
    }

    return imageUrls;
  }

  Future<void> addPetToFireStore(BuildContext context) async {
    String petName = petNameController.text;
    String petOwnerName = petOwnerNameController.text;
    String petBreed = petBreedController.text;
    String petDescription = petDescriptionController.text;
    int petAge = int.tryParse(petAgeController.text) ?? 0;
    int petWeight = int.tryParse(petWeightController.text) ?? 0;
    String petLocation = petLocationController.text;
    String petOwnerPhone = petOwnerPhoneController.text;

    /// Validate the form fields
    if (petName.isEmpty ||
        petBreed.isEmpty ||
        petDescription.isEmpty ||
        petImages.isEmpty) {
      ToastHelper.showErrorToast(
        context: context,
        message: "Please fill in all fields",
      );
      return;
    }

    // Set loading to true
    setLoading(true);

    try {
      /// Upload images and get URLs
      List<String> imageUrls = await uploadImages(petName, context);

      /// Generate a unique pet ID
      String petId = const Uuid().v4();

      /// Create a PetModels instance
      PetModels pet = PetModels(
        petId: petId,
        petOwnerName: petOwnerName,
        petName: petName,
        petBreed: petBreed,
        petDescription: petDescription,
        petAge: petAge,
        petWeight: petWeight,
        petLocation: petLocation,
        petOwnerPhoneNumber: petOwnerPhone,
        petGender: _selectedGender,
        petCategory: _selectedPetType,
        isVaccinated: _vaccinationStatus == 'Vaccination Done',
        petImages: imageUrls,
      );

      // Add pet data to Firestore
      await _firestore.collection('pets').doc(petId).set(pet.toJson());

      ToastHelper.showSuccessToast(
        context: context,
        message: "Pet added to adoption successfully!",
      );

      // Obtain the BottomNavProvider to navigate to the Home tab
      final bottomNavProvider =
          Provider.of<BottomNavProvider>(context, listen: false);
      bottomNavProvider.navigateToIndex(context, 0);

      // Clear form data after successful upload
      clearForm();
    } catch (e) {
      ToastHelper.showErrorToast(
        context: context,
        message: "Failed to add pet: $e.",
      );
    } finally {
      // Set loading to false
      setLoading(false);
    }
  }

  // Clear form data and reset state
  void clearForm() {
    // Clear the text fields
    petNameController.clear();
    petBreedController.clear();
    petDescriptionController.clear();
    petAgeController.clear();
    petWeightController.clear();
    petLocationController.clear();
    petOwnerPhoneController.clear();

    // Clear the images list
    petImages.clear();

    // Reset dropdowns and radio selections
    _selectedPetType = 'Dog';
    _selectedGender = 'male';
    _vaccinationStatus = 'Vaccination Done';
    _selectedPetAge = 1;

    // Notify listeners to rebuild the UI
    notifyListeners();
  }

  /// For validating partially
  bool isFormPartiallyFilled() {
    return petNameController.text.isNotEmpty ||
        petBreedController.text.isNotEmpty ||
        petWeightController.text.isNotEmpty ||
        petOwnerNameController.text.isNotEmpty ||
        petOwnerPhoneController.text.isNotEmpty ||
        petDescriptionController.text.isNotEmpty ||
        petImages.isNotEmpty ||
        selectedPetType.isNotEmpty ||
        selectedGender.isNotEmpty ||
        vaccinationStatus.isNotEmpty;
  }
}
