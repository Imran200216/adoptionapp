import 'dart:io';
import 'package:adoptionapp/helper/debounce_helper.dart';
import 'package:adoptionapp/modals/pet_modal.dart';
import 'package:adoptionapp/provider/screen_provider/bottom_nav_provider.dart';
import 'package:adoptionapp/widgets/toast_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddPetToFireStoreProvider extends ChangeNotifier {
  /// Debounce helper
  final DebounceHelper debounceHelper = DebounceHelper();

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
  String _vaccinationStatus = 'Vaccinated';
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

  // Firebase Storage and Fire store instances
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Getters for selected values
  String get selectedPetType => _selectedPetType;

  String get selectedGender => _selectedGender;

  String get vaccinationStatus => _vaccinationStatus;

  int get selectedPetAge => _selectedPetAge;

  // Save the complete phone number
  String _completePhoneNumber = '';

  String get completePhoneNumber => _completePhoneNumber;

  void setCompletePhoneNumber(String phoneNumber) {
    _completePhoneNumber = phoneNumber;
    notifyListeners();
  }


  /// Methods for setting values
  void setPetAge(int value) {
    _selectedPetAge = value;
    petAgeController.text = value.toString();
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

  /// for checking whether the vaccination status will be correct
  late bool _isVaccinated;

  void setVaccinationStatus(String value) {
    // Convert the selected option to a boolean
    _vaccinationStatus = value.trim();
    bool isVaccinatedBool =
        _vaccinationStatus == 'Vaccinated'; // Convert to boolean
    print(
        "Vaccination Status: $_vaccinationStatus, isVaccinated: $isVaccinatedBool"); // Debugging information

    // Update the isVaccinated field accordingly
    _isVaccinated = isVaccinatedBool;

    notifyListeners();
  }

  /// Method to pick an image from gallery or camera
  Future<void> pickImage(ImageSource source, BuildContext context) async {
    final ImagePicker _picker = ImagePicker();

    // Check for permission based on the source (Camera or Gallery)
    if (source == ImageSource.camera) {
      var status = await Permission.camera.status;
      if (!status.isGranted) {
        status = await Permission.camera.request();
        if (!status.isGranted) {
          ToastHelper.showErrorToast(
            context: context,
            message: "Camera permission is required to take pictures.",
          );
          return;
        }
      }
    } else if (source == ImageSource.gallery) {
      var status = await Permission.photos.status;
      if (!status.isGranted) {
        status = await Permission.photos.request();
        if (!status.isGranted) {
          ToastHelper.showErrorToast(
            context: context,
            message: "Gallery access is required to pick images.",
          );
          return;
        }
      }
    }

    // Pick the image
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

  /// Method to add the pet to Fire store
  Future<void> addPetToFireStore(BuildContext context) async {
    if (!debounceHelper.isDebounced()) {
      debounceHelper.activateDebounce(duration: const Duration(seconds: 2));

      String petName = petNameController.text;
      String petOwnerName = petOwnerNameController.text;
      String petBreed = petBreedController.text;
      String petDescription = petDescriptionController.text;
      int petAge = _selectedPetAge;
      int petWeight = int.tryParse(petWeightController.text) ?? 0;
      String petLocation = petLocationController.text;
      String petOwnerPhone = completePhoneNumber;

      // Validate form fields
      if (petName.isEmpty ||
          petBreed.isEmpty ||
          petImages.isEmpty ||
          petOwnerPhone.isEmpty ||
          petOwnerName.isEmpty) {
        ToastHelper.showErrorToast(
          context: context,
          message: "Please fill in all fields",
        );
        return;
      }

      // Check for minimum length of pet description
      if (petDescription.length < 15) {
        ToastHelper.showErrorToast(
          context: context,
          message:
              "Please fill detailed description\n(at least 15 characters).",
        );
        return;
      }

      setLoading(true);

      try {
        // Upload images and get URLs
        List<String> imageUrls = await uploadImages(petName, context);

        // Generate a unique pet ID
        String petId = const Uuid().v4();

        // Get the current authenticated user's UID
        final User? user = FirebaseAuth.instance.currentUser;
        final String userUid = user?.uid ?? '';

        if (userUid.isEmpty) {
          ToastHelper.showErrorToast(
            context: context,
            message: "User not authenticated.",
          );
          return;
        }

        // Create PetModels instance with proper isVaccinated boolean
        PetModels pet = PetModels(
          userUid,
          petId: petId,
          petOwnerName: petOwnerName,
          petName: petName,
          petBreed: petBreed,
          petDescription: petDescription,
          petAge: petAge,
          petWeight: petWeight,
          petLocation: petLocation,
          petOwnerPhoneNumber: petOwnerPhone, // Use the complete phone number
          petGender: _selectedGender,
          petCategory: _selectedPetType,
          isVaccinated: _vaccinationStatus.toLowerCase() == 'vaccinated',
          // Adjust as necessary
          // Case-insensitive check
          petImages: imageUrls,
        );

        // Add pet data to Firestore
        await _firestore.collection('pets').doc(petId).set(pet.toJson());

        ToastHelper.showSuccessToast(
          context: context,
          message: "Pet added to adoption successfully!",
        );

        // Navigate to the Home tab
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
        setLoading(false);
      }
    }
  }

  // Clear form data and reset state
  void clearForm() {
    petNameController.clear();
    petBreedController.clear();
    petDescriptionController.clear();
    petAgeController.clear();
    petWeightController.clear();
    petLocationController.clear();
    petOwnerPhoneController.clear();
    petOwnerNameController.clear();
    petImages.clear();
    _selectedPetType = 'Dog';
    _selectedGender = 'male';
    _vaccinationStatus = 'Vaccination Done';
    _selectedPetAge = 1;
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
