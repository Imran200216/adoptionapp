import 'package:adoptionapp/helper/debounce_helper.dart';
import 'package:adoptionapp/helper/toast_helper.dart';
import 'package:adoptionapp/modals/pet_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddPetFavoriteProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<String> _favoritePetIds = [];

  // debounce helper
  final DebounceHelper _debounceHelper = DebounceHelper();

  List<String> get favoritePetIds => _favoritePetIds;

  AddPetFavoriteProvider() {
    _loadFavoritePets();
  }

  Future<void> _loadFavoritePets() async {
    User? user = _auth.currentUser;
    if (user != null) {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection("favorites")
          .where("userUid", isEqualTo: user.uid)
          .get();

      _favoritePetIds.clear();
      for (var doc in snapshot.docs) {
        _favoritePetIds.add(doc["petId"] as String);
      }

      notifyListeners();
    }
  }

  /// Add a pet to favorites and persist it in Firestore with debounce
  Future<void> addFavoritePet(String petId, BuildContext context) async {
    if (_debounceHelper.isDebounced()) return; // Return if debounce is active

    _debounceHelper.activateDebounce(
        duration:
            const Duration(seconds: 2)); // Activate debounce for 2 seconds

    User? user = _auth.currentUser;
    if (user != null && !_favoritePetIds.contains(petId)) {
      _favoritePetIds.add(petId);

      // Persist the favorite in Firestore
      await FirebaseFirestore.instance.collection('favorites').add({
        "userUid": user.uid,
        "petId": petId,
      });

      // Show success toast
      ToastHelper.showSuccessToast(
        context: context,
        message: "Pet added to Favorite",
      );

      notifyListeners();
    }
  }

  /// Remove a pet from favorites and update Firestore with debounce
  Future<void> removeFavoritePet(String petId, BuildContext context) async {
    if (_debounceHelper.isDebounced()) return; // Return if debounce is active

    _debounceHelper.activateDebounce(
        duration:
            const Duration(seconds: 2)); // Activate debounce for 2 seconds

    User? user = _auth.currentUser;
    if (user != null && _favoritePetIds.contains(petId)) {
      _favoritePetIds.remove(petId);

      // Remove from Firestore
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('favorites')
          .where('userUid', isEqualTo: user.uid)
          .where('petId', isEqualTo: petId)
          .get();

      for (var doc in snapshot.docs) {
        await FirebaseFirestore.instance
            .collection('favorites')
            .doc(doc.id)
            .delete();
      }

      // Show remove toast
      ToastHelper.showSuccessToast(
        context: context,
        message: "Pet removed from Favorite",
      );

      notifyListeners();
    }
  }

  bool isFavorite(String petId) {
    return _favoritePetIds.contains(petId);
  }

  /// Fetch all favorite pet cards for the current user
  Future<List<PetModels>> fetchFavoritePetCards() async {
    User? user = _auth.currentUser;
    if (user == null) return [];

    try {
      // Fetch the favorite pet IDs
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('favorites')
          .where('userUid', isEqualTo: user.uid)
          .get();

      List<String> favoritePetIds = [];
      for (var doc in snapshot.docs) {
        favoritePetIds.add(doc['petId'] as String);
      }

      // Fetch the pet details for each favorite pet ID
      List<PetModels> favoritePets = [];
      for (String petId in favoritePetIds) {
        DocumentSnapshot<Map<String, dynamic>> petDoc = await FirebaseFirestore
            .instance
            .collection('pets')
            .doc(petId)
            .get();
        if (petDoc.exists) {
          favoritePets.add(PetModels.fromFirestore(petDoc.data()!));
        }
      }

      return favoritePets;
    } catch (e) {
      debugPrint("Error fetching favorite pets: $e");
      return [];
    }
  }
}
