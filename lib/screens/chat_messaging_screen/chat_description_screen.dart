import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/user_chat_provider/chat_room_provider.dart';
import 'package:adoptionapp/provider/user_chat_provider/chat_text_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatDescriptionScreen extends StatelessWidget {
  final String userUid1AvatarUrl;
  final String userUid2AvatarUrl;
  final String roomId;
  final String userUid1;
  final String userUid2;
  final String userUid1Name;
  final String petOwnerName;

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
    /// media query
    final size = MediaQuery.of(context).size;

    /// chat room provider
    final chatProvider = Provider.of<ChatRoomProvider>(context);

    /// chat text controller provider
    final chatTextControllerProvider =
        Provider.of<ChatTextControllerProvider>(context);

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
            const SizedBox(width: 6),
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
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          image: DecorationImage(
            image: AssetImage(
              "assets/images/jpg/chatbotbg-img.jpeg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: chatProvider.getMessages(roomId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

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

                      // Retrieve timestamp
                      final timestamp = messageData['timestamp'];
                      final messageTime = DateFormat('h:mm a')
                          .format(timestamp.toDate()); // Format time

                      // Check if the message is from the chatbot
                      final isChatbot = messageData['senderUid'] == 'chatbot';

                      return Column(
                        crossAxisAlignment: isSender
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          BubbleSpecialOne(
                            text: messageData['message'],
                            isSender: isSender,
                            color: isChatbot
                                ? Colors.purple.shade100
                                : AppColors.primaryColor,
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: AppColors.secondaryColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: "NunitoSans",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              bottom: 10.0,
                            ),
                            child: Text(
                              messageTime,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
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
                      style: TextStyle(
                        fontFamily: "NunitoSans",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                      ),
                      controller: chatTextControllerProvider.messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(
                          fontFamily: "NunitoSans",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey.shade700,
                        ),
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
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      chatProvider.sendMessage(
                        roomId,
                        chatTextControllerProvider.message,
                      );
                      chatTextControllerProvider.clearMessage(); // Clear input
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
