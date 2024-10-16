import 'package:adoptionapp/modals/chat_room_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UserChatProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> startChat(String userUid1, String userUid2) async {
    // Generate a unique chat room ID
    String roomId = Uuid().v4();

    // Create a ChatRoom object
    ChatRoom chatRoom = ChatRoom(
      roomId: roomId,
      userUid1: userUid1,
      userUid2: userUid2,
      createdAt: DateTime.now(),
    );

    // Store the chat room in Firestore
    try {
      await _firestore.collection('chatRooms').doc(roomId).set(chatRoom.toMap());
      print('Chat room created successfully with ID: $roomId');
      notifyListeners(); // Notify listeners if needed
    } catch (e) {
      print('Error creating chat room: $e');
      // Optionally, you can handle error state here
    }
  }
}
