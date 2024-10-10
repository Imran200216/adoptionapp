import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PetCategoryProvider with ChangeNotifier {
  String _selectedCategory = 'All';
  List<QueryDocumentSnapshot> _pets = [];
  List<QueryDocumentSnapshot> get pets => _pets;

  String get selectedCategory => _selectedCategory;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> fetchPets() async {
    QuerySnapshot snapshot;

    if (_selectedCategory == 'All') {
      snapshot = await FirebaseFirestore.instance.collection('pets').get();
    } else {
      snapshot = await FirebaseFirestore.instance
          .collection('pets')
          .where('petCategory', isEqualTo: _selectedCategory)
          .get();
    }

    _pets = snapshot.docs;
    notifyListeners();
  }
}
