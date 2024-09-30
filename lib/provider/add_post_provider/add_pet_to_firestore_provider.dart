import 'dart:io';
import 'package:adoptionapp/widgets/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddPetToFireStoreProvider extends ChangeNotifier {
  /// TextEditingControllers for form fields
  TextEditingController petNameController = TextEditingController();
  TextEditingController petBreedController = TextEditingController();
  TextEditingController petDescriptionController = TextEditingController();
  TextEditingController petAgeController = TextEditingController();
  TextEditingController petWeightController = TextEditingController();
  TextEditingController petLocationController = TextEditingController();
  TextEditingController petOwnerPhoneController = TextEditingController();
  TextEditingController petOwnerNameController =
      TextEditingController(); // Added for pet owner name

  /// Dropdown values for pet gender
  String? valuePetGender;
  final List<String> listPetGender = ["Male", "Female"];

  void setPetGender(String? newValue) {
    valuePetGender = newValue;
    notifyListeners(); // Notify listeners of the change
  }

  /// Dropdown values for pet vaccinated
  String? valuePetVaccinated;
  final List<String> listPetVaccinated = ["Vaccinated", "Not Vaccinated"];

  void setPetVaccinated(String? newValue) {
    valuePetVaccinated = newValue;
    notifyListeners(); // Notify listeners of the change
  }

  /// Dropdown values for pet category
  String? valuePetCategory;
  final List<String> listPetCategory = ["Dogs", "Cats", "Birds", "Others"];

  void setPetCategory(String? newValue) {
    valuePetCategory = newValue;
    notifyListeners(); // Notify listeners of the change
  }

  /// Selected pet images
  List<File> petImages = [];

  /// Firebase Storage instance
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  /// Method to add pet data to Firestore
  Future<void> addPetToFireStore(BuildContext context) async {
    String petName = petNameController.text;
    String petBreed = petBreedController.text;
    String petDescription = petDescriptionController.text;
    int petAge = int.tryParse(petAgeController.text) ?? 0;
    int petWeight = int.tryParse(petWeightController.text) ?? 0;
    String petLocation = petLocationController.text;
    String petOwnerPhone = petOwnerPhoneController.text;
    String petOwnerName = petOwnerNameController.text; // Get pet owner name

    if (petName.isEmpty ||
        petBreed.isEmpty ||
        petDescription.isEmpty ||
        petAge <= 0 ||
        petWeight <= 0 ||
        petImages.isEmpty ||
        petOwnerName.isEmpty) {
      // Validate pet owner name
      ToastHelper.showErrorToast(
        context: context,
        message: "Please fill in all fields and add at least one image.",
      );

      return;
    }

    try {
      // Upload images and get URLs
      List<String> imageUrls = await uploadImages(petName, context);

      // Create pet data map
      Map<String, dynamic> petData = {
        'petName': petName,
        'petBreed': petBreed,
        'petDescription': petDescription,
        'petAge': petAge,
        'petWeight': petWeight,
        'petLocation': petLocation,
        'petOwnerPhoneNumber': petOwnerPhone,
        'petOwnerName': petOwnerName, // Include pet owner name
        'petCategory': valuePetCategory,
        'petGender': valuePetGender,
        'isVaccinated': valuePetVaccinated == "Vaccinated",
        'petImages': imageUrls,
      };

      // Add data to Firestore
      await _firestore.collection('pets').add(petData);

      ToastHelper.showSuccessToast(
        context: context,
        message: "Pet added to adoption successfully!",
      );
      // Clear form data after successful upload
      clearForm();
    } catch (e) {
      ToastHelper.showErrorToast(
        context: context,
        message: "Failed to add pet: $e.",
      );
    }
  }

  /// Clear form data and reset state
  void clearForm() {
    petNameController.clear();
    petBreedController.clear();
    petDescriptionController.clear();
    petAgeController.clear();
    petWeightController.clear();
    petLocationController.clear();
    petOwnerPhoneController.clear();
    petOwnerNameController.clear(); // Clear pet owner name
    petImages.clear();
    valuePetCategory = null;
    valuePetGender = null;
    valuePetVaccinated = null;
    notifyListeners();
  }
}
