import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatBotProvider with ChangeNotifier {
  final TextEditingController userInputController = TextEditingController();
  final List<Message> _messages = [];

  /// api key for the Gemini ai
  static const apiKey = "AIzaSyDjEeJYEoKoImi5-Wf5M2xM0AX26SmoqDo";

  /// gemini ai model
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  List<Message> get messages => _messages;

  // Key for storing the last prompt
  static const String lastPromptKey = "lastPrompt";

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ChatBotProvider() {
    _loadMessages();
    _deleteOldMessages();
  }

  Future<void> _loadMessages() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);

    final snapshot = await FirebaseFirestore.instance
        .collection('chatBotMessages')
        .where('date', isGreaterThanOrEqualTo: startOfDay)
        .orderBy('date')
        .get();

    _messages.clear();
    for (var doc in snapshot.docs) {
      _messages.add(Message.fromFirestore(doc));
    }
    notifyListeners();
  }

  Future<void> _saveMessage(Message message) async {
    await FirebaseFirestore.instance
        .collection('chatBotMessages')
        .add(message.toMap());
  }

  Future<void> _deleteOldMessages() async {
    final now = DateTime.now();
    final startOfYesterday = DateTime(now.year, now.month, now.day)
        .subtract(const Duration(days: 1));

    final snapshot = await FirebaseFirestore.instance
        .collection('chatBotMessages')
        .where('date', isLessThan: startOfYesterday)
        .get();

    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> sendMessage() async {
    final message = userInputController.text;

    final userMessage =
        Message(isUser: true, message: message, date: DateTime.now());
    _messages.add(userMessage);
    userInputController.clear();
    notifyListeners();
    await _saveMessage(userMessage);

    // Save the prompt so that it can be checked the next day
    await _saveLastPrompt(message);

    // Set loading state to true while generating response
    _isLoading = true;
    notifyListeners();

    final content = [Content.text(message)];
    final response = await model.generateContent(content);

    final botMessage = Message(
        isUser: false, message: response.text ?? "", date: DateTime.now());
    _messages.add(botMessage);
    _isLoading = false;
    notifyListeners();
    await _saveMessage(botMessage);
  }

  Future<void> _saveLastPrompt(String prompt) async {
    await FirebaseFirestore.instance
        .collection('settings')
        .doc(lastPromptKey)
        .set({'value': prompt});
  }

  Future<String?> _getLastPrompt() async {
    final doc = await FirebaseFirestore.instance
        .collection('settings')
        .doc(lastPromptKey)
        .get();
    return doc.data()?['value'] as String?;
  }

  Future<bool> isPromptToday(String prompt) async {
    final lastPrompt = await _getLastPrompt();
    return lastPrompt == prompt;
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({required this.isUser, required this.message, required this.date});

  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
      isUser: data['isUser'],
      message: data['message'],
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isUser': isUser,
      'message': message,
      'date': Timestamp.fromDate(date),
    };
  }

  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  Future<bool> isPromptToday(String prompt) async {
    // Business logic to check if the prompt was entered today.
    // Placeholder for actual implementation.
    return false;
  }

  void addMessage(Message message) {
    _messages.add(message);
  }
}
