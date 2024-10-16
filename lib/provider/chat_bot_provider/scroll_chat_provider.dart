import 'package:flutter/material.dart';

class ScrollChatProvider extends ChangeNotifier {
  late ScrollController _scrollController;

  ScrollChatProvider() {
    _scrollController = ScrollController();
  }

  ScrollController get scrollController => _scrollController;

  void scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      notifyListeners();
    }
  }
}