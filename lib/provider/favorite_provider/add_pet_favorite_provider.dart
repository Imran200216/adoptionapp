import 'package:adoptionapp/widgets/toast_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddPetFavoriteProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<Map<String, dynamic>> _favoritePets = [];

  List<Map<String, dynamic>> get favoritePets => _favoritePets;

  // Add pet to favorites
  void addPetToFavorites(Map<String, dynamic> petData, BuildContext context) {
    final User? currentUser = _auth.currentUser;

    // Check if user is logged in
    if (currentUser == null) {
      ToastHelper.showErrorToast(
        context: context,
        message: "Please log in to add favorites",
      );
      return;
    }

    // Validate petData and petId
    if (petData['petId'] == null) {
      ToastHelper.showErrorToast(
        context: context,
        message: "Invalid pet data",
      );
      return;
    }

    // Add pet to favorites if it doesn't already exist
    if (!_favoritePets.any((pet) => pet['petId'] == petData['petId'])) {
      _favoritePets.add(petData);
      notifyListeners(); // Notify UI to refresh

      // Show success toast message
      ToastHelper.showSuccessToast(
        context: context,
        message: "Added to favorite",
      );
    } else {
      // Show message if the pet is already in favorites
      ToastHelper.showErrorToast(
        context: context,
        message: "Pet is already in favorites",
      );
    }
  }

  // Remove pet from favorites
  void removePetFromFavorites(String petId, BuildContext context) {
    // Validate petId
    if (petId == null || petId.isEmpty) {
      ToastHelper.showErrorToast(
        context: context,
        message: "Invalid pet ID",
      );
      return;
    }

    // Remove pet from favorites
    _favoritePets.removeWhere((pet) => pet['petId'] == petId);
    notifyListeners(); // Notify UI to refresh

    // Show success toast message
    ToastHelper.showSuccessToast(
      context: context,
      message: "Removed from favorite",
    );
  }

  // Check if a pet is already in favorites
  bool isFavorite(String petId) {
    return _favoritePets.any((pet) => pet['petId'] == petId);
  }
}
