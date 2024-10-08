import 'package:flutter/material.dart';

class ScrollProvider with ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  void scrollToBottom({int durationInMillis = 500}) {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: durationInMillis),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  void scrollToTop({int durationInMillis = 500}) {
    scrollController.animateTo(
      0,
      duration: Duration(milliseconds: durationInMillis),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }
}
