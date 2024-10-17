import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/user_chat_provider/chat_room_provider.dart';
import 'package:adoptionapp/screens/chat_messaging_screen/chat_description_screen.dart';
import 'package:adoptionapp/widgets/custom_chat_list_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                // Header for "All Chats"
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.chat,
                      size: 24,
                      color: AppColors.blackColor,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "All Chats",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // List of Chat Rooms
                Consumer<ChatRoomProvider>(
                  builder: (context, chatRoomProvider, child) {
                    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: chatRoomProvider.getChatRooms(),
                      // Stream from Firestore
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child:
                                  CircularProgressIndicator()); // Show loader
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text('No chat rooms available'));
                        }

                        // Access the chat rooms data
                        List<QueryDocumentSnapshot<Map<String, dynamic>>>
                            chatRooms = snapshot.data!.docs;

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: chatRooms.length,
                          itemBuilder: (context, index) {
                            final chatRoomData = chatRooms[index].data();
                            final currentUserUid =
                                FirebaseAuth.instance.currentUser!.uid;

                            return CustomChatListContainer(
                              onTap: () {
                                // Navigate to ChatDescriptionScreen when tapped
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatDescriptionScreen(
                                      roomId: chatRoomData['roomId'] as String,
                                      // Ensure correct type
                                      userUid1: currentUserUid,
                                      userUid2:
                                          chatRoomData['userUid2'] as String,
                                      // Ensure correct type
                                      userUid1Name: FirebaseAuth.instance
                                              .currentUser!.displayName ??
                                          'Your Name',
                                      petOwnerName:
                                          chatRoomData['userName'] as String,
                                      // Ensure correct type
                                      userUid1AvatarUrl: (chatRoomProvider
                                              .getUserAvatarUrl(currentUserUid))
                                          as String,

                                      userUid2AvatarUrl:
                                          chatRoomData['userAvatarUrl']
                                              as String, // Ensure correct type
                                    ),
                                  ),
                                );
                              },
                              avatarUrl:
                                  chatRoomData['userAvatarUrl'] as String? ??
                                      "No avatar",
                              // Correct casting
                              personName: chatRoomData['userName'] as String? ??
                                  "No username",
                              // Correct casting
                              recentMessage:
                                  chatRoomData['recentMessage'] as String? ??
                                      'No messages yet',
                              recentMessageIndication:
                                  0, // Add custom logic if needed
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
