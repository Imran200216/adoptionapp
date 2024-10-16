import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatRequestProvider with ChangeNotifier {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String? _token;
  String? get token => _token;

  ChatRequestProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    _token = await _firebaseMessaging.getToken();
    print("FCM Token: $_token");

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle incoming message
      _showMessage(message);
    });
  }

  void _showMessage(RemoteMessage message) {
    // Show your custom dialog or notification based on the message
    print("Message received: ${message.notification?.title}");
    notifyListeners(); // Notify listeners if needed
  }

  Future<void> sendNotification(String recipientToken, String message) async {
    // Your backend should handle sending the notification to the recipient's token
    // You can implement this logic using HTTP requests to your server
  }
}
