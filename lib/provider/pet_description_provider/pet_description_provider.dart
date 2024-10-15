import 'package:flutter/material.dart';

class PetDescriptionProvider with ChangeNotifier {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  PageController get pageController => _pageController;

  int get currentPage => _currentPage;

  void goToPage(int page) {
    _currentPage = page;
    _pageController.jumpToPage(page);
    notifyListeners();
  }
}
