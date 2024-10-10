import 'package:adoptionapp/widgets/toast_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddPetFavoriteProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<Map<String, dynamic>> _favoritePets = [];

  List<Map<String, dynamic>> get favoritePets => _favoritePets;

  void addPetToFavorites(Map<String, dynamic> petData, BuildContext context) {
    if (!_favoritePets.any((pet) => pet['petId'] == petData['petId'])) {
      _favoritePets.add(petData);
      notifyListeners(); // Notify UI to refresh

      // Show success toast message
      ToastHelper.showSuccessToast(
        context: context,
        message: "Added to favorite",
      );
    }
  }

  void removePetFromFavorites(String petId, BuildContext context) {
    _favoritePets.removeWhere((pet) => pet['petId'] == petId);
    notifyListeners(); // Notify UI to refresh

    // Show success toast message
    ToastHelper.showSuccessToast(
      context: context,
      message: "Removed from favorite",
    );
  }

  bool isFavorite(String petId) {
    return _favoritePets.any((pet) => pet['petId'] == petId);
  }
}
