import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/user_chat_provider/chat_room_provider.dart';
import 'package:adoptionapp/widgets/custom_chat_bubbles.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    final size = MediaQuery.of(context).size;

    final TextEditingController _messageController = TextEditingController();
    final chatProvider = Provider.of<ChatRoomProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: size.height * 0.026,
            color: AppColors.secondaryColor,
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          // Use min to take only necessary space
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: userUid2AvatarUrl,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            const SizedBox(width: 6), // Adjust spacing here if needed
            Text(
              petOwnerName,
              style: TextStyle(
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.w700,
                color: AppColors.secondaryColor,
                fontFamily: "NunitoSans",
              ),
            ),
          ],
        ),
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
