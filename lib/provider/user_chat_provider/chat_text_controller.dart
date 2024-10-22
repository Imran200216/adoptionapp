import 'package:flutter/material.dart';

class ChatTextControllerProvider with ChangeNotifier {
  final TextEditingController messageController = TextEditingController();

  String get message => messageController.text;

  void clearMessage() {
    messageController.clear();
    notifyListeners(); // Notify listeners when the message is cleared
  }

  @override
  void dispose() {
    messageController.dispose(); // Don't forget to dispose of the controller
    super.dispose();
  }
}
