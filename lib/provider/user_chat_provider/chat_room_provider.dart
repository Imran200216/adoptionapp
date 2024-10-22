import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adoptionapp/widgets/toast_helper.dart';

class ChatRoomProvider with ChangeNotifier {
  String? _roomId;

  // Getter for the roomId
  String? get roomId => _roomId;

  // Create or get a chat room between two users
  Future<void> createChatRoom(
      String userUid1, String userUid2, BuildContext context) async {
    try {
      // Check if user UIDs are equal
      if (userUid1 == userUid2) {
        // Show a toast message
        ToastHelper.showErrorToast(
          context: context,
          message: "You cannot chat with yourself.",
        );
        return; // Exit the function
      }

      // Generate a unique chat room ID
      List<String> users = [userUid1, userUid2];
      users.sort(); // Ensure roomId is always the same for the same pair
      String chatRoomId = users.join('_');

      // Check if the room exists in Fire store
      DocumentSnapshot roomSnapshot = await FirebaseFirestore.instance
          .collection('chatRooms')
          .doc(chatRoomId)
          .get();

      if (!roomSnapshot.exists) {
        // If room does not exist, fetch user avatar URLs
        String? userUid1AvatarUrl = await getUserAvatarUrl(userUid1);
        String? userUid2AvatarUrl = await getUserAvatarUrl(userUid2);

        // If needed, you can set default URLs if the avatar URLs are null
        // Set a default if null
        userUid1AvatarUrl ??=
            "https://imgs.search.brave.com/G7EAKN2_tgpXRvp6SG9UP-WdSrIotMa3XzzGAZ29UCo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAwLzIzLzcyLzU5/LzM2MF9GXzIzNzI1/OTQ0X1cyYVNyZzNL/cXczbE9tVTRJQW43/aVhWODhSbm5mY2gx/LmpwZw";
        // Set a default if null
        userUid2AvatarUrl ??=
            "https://imgs.search.brave.com/G7EAKN2_tgpXRvp6SG9UP-WdSrIotMa3XzzGAZ29UCo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAwLzIzLzcyLzU5/LzM2MF9GXzIzNzI1/OTQ0X1cyYVNyZzNL/cXczbE9tVTRJQW43/aVhWODhSbm5mY2gx/LmpwZw";

        // Create a new chat room with user avatar URLs
        await FirebaseFirestore.instance
            .collection('chatRooms')
            .doc(chatRoomId)
            .set({
          'roomId': chatRoomId,
          'users': users,
          'userUid1AvatarUrl': userUid1AvatarUrl,
          'userUid2AvatarUrl': userUid2AvatarUrl,
          'createdAt': Timestamp.now(),
        });

        // Show a success toast message for creation of chat rooms
        ToastHelper.showSuccessToast(
          context: context,
          message: "Chat Room is created successfully!",
        );
      }

      // Store the roomId
      _roomId = chatRoomId;

      notifyListeners();
    } catch (e) {
      print("Error creating chat room: $e");
    }
  }

  // Function to get the chat room ID
  String getRoomId(String userUid1, String userUid2) {
    List<String> users = [userUid1, userUid2];
    users.sort();
    return users.join('_'); // Always return a valid string
  }

  /// Chat functionalities
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Map<String, dynamic>> _messages = [];

  List<Map<String, dynamic>> get messages => _messages;

  // Fetch messages from Fire store
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String roomId) {
    return _firestore
        .collection('chatRooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Send a message
  Future<void> sendMessage(String roomId, String message) async {
    if (message.isNotEmpty) {
      final currentUserUid = _auth.currentUser!.uid;
      await _firestore
          .collection('chatRooms')
          .doc(roomId)
          .collection('messages')
          .add({
        'senderUid': currentUserUid,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  // Update messages from snapshot
  void updateMessages(QuerySnapshot<Map<String, dynamic>> snapshot) {
    _messages = snapshot.docs
        .map((doc) =>
            doc.data()) // No need for Map<String, dynamic> as type is inferred
        .toList();
    notifyListeners();
  }

  /// Fetching the user avatars from guest and email
  Future<String?> getUserAvatarUrl(String uid) async {
    try {
      // Check in the 'userByEmail' collection first
      DocumentSnapshot userDoc =
          await _firestore.collection('userByEmailAuth').doc(uid).get();

      if (userDoc.exists) {
        return userDoc['avatarPhotoURL']; // Return avatar URL if found
      } else {
        // If not found in 'userByEmail', check in 'userByGuest'
        userDoc = await _firestore.collection('userByGuestAuth').doc(uid).get();

        if (userDoc.exists) {
          return userDoc['avatarPhotoURL']; // Return avatar URL if found
        }
      }
    } catch (e) {
      print("Error fetching avatar URL: $e");
    }
    return null; // Return null if not found
  }

  // Define a getter for chatRooms that returns a stream of chat rooms from Fire store
  // Fetch chat rooms from Fires tore
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatRooms() {
    return _firestore.collection('chatRooms').snapshots();
  }
}
