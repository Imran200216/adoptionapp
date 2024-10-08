import 'dart:io';
import 'package:adoptionapp/widgets/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddPetToFireStoreProvider extends ChangeNotifier {
  // TextEditingControllers for form fields
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

  // Page controller for the image slider
  PageController pageController = PageController();

  // Firebase Storage and Firestore instances
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Getters for selected values
  String get selectedPetType => _selectedPetType;
  String get selectedGender => _selectedGender;
  String get vaccinationStatus => _vaccinationStatus;
  int get selectedPetAge => _selectedPetAge;

  // Methods for setting values
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

  // Method to pick an image from gallery or camera
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

  // Method to upload images to Firebase Storage and return the list of URLs
  Future<List<String>> uploadImages(String petName, BuildContext context) async {
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

  // Method to add pet data to Firestore
  Future<void> addPetToFireStore(BuildContext context) async {
    String petName = petNameController.text;
    String petBreed = petBreedController.text;
    String petDescription = petDescriptionController.text;
    int petAge = int.tryParse(petAgeController.text) ?? 0;
    int petWeight = int.tryParse(petWeightController.text) ?? 0;
    String petLocation = petLocationController.text;
    String petOwnerPhone = petOwnerPhoneController.text;
    String petOwnerName = petOwnerNameController.text;

    // Validate the form fields
    if (petName.isEmpty ||
        petBreed.isEmpty ||
        petDescription.isEmpty ||
        petAge <= 0 ||
        petWeight <= 0 ||
        petImages.isEmpty ||
        petOwnerName.isEmpty) {
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
        'petOwnerName': petOwnerName,
        'petImages': imageUrls,
        'petType': _selectedPetType,
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
    notifyListeners();
  }
}
