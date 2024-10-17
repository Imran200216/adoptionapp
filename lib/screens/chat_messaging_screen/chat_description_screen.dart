import 'package:adoptionapp/provider/user_chat_provider/chat_room_provider.dart';
import 'package:adoptionapp/widgets/custom_chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatDescriptionScreen extends StatelessWidget {
  final String userUid1AvatarUrl;
  final String userUid2AvatarUrl;
  final String roomId;
  final String userUid1;
  final String userUid2;
  final String userUid1Name;
  final String petOwnerName;

  // Constructor with parameters for roomId, user UIDs, and names
  const ChatDescriptionScreen({
    super.key,
    required this.roomId,
    required this.userUid1,
    required this.userUid2,
    required this.userUid1Name,
    required this.petOwnerName,
    required this.userUid1AvatarUrl,
    required this.userUid2AvatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController _messageController = TextEditingController();
    final chatProvider = Provider.of<ChatRoomProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room: $roomId'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: chatProvider.getMessages(roomId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                // Update messages in provider after the build phase is complete
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  chatProvider.updateMessages(snapshot.data!);
                });

                return ListView.builder(
                  reverse: true,
                  itemCount: chatProvider.messages.length,
                  itemBuilder: (context, index) {
                    final messageData = chatProvider.messages[index];
                    final isSender = messageData['senderUid'] ==
                        FirebaseAuth.instance.currentUser!.uid;

                    return ChatBubble(
                      message: messageData['message'],
                      isSender: isSender,
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    chatProvider.sendMessage(roomId, _messageController.text);
                    _messageController.clear(); // Clear the input field
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
