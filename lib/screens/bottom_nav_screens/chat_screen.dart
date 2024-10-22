import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/user_chat_provider/chat_room_provider.dart';
import 'package:adoptionapp/screens/chat_messaging_screen/chat_description_screen.dart';
import 'package:adoptionapp/widgets/custom_chat_list_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// media query
    final size = MediaQuery.of(context).size;

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
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            "assets/lotties/empty-animation.json",
                            height: size.height * 0.35,
                          ),
                          Text('No chats available'),
                        ],
                      );
                    }

                    List<QueryDocumentSnapshot<Map<String, dynamic>>> chatRooms = snapshot.data!.docs;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: chatRooms.length,
                      itemBuilder: (context, index) {
                        final chatRoomData = chatRooms[index].data();
                        final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

                        return CustomChatListContainer(
                          avatarUrl: chatRoomData['userUid2AvatarUrl'] as String? ?? '',
                          personName: chatRoomData['userName'] as String? ?? 'No Name',
                          recentMessage: chatRoomData['recentMessage'] as String? ?? 'No messages yet',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatDescriptionScreen(
                                  roomId: chatRoomData['roomId'],
                                  userUid1: currentUserUid,
                                  userUid2: chatRoomData['users'][1],
                                  userUid1Name: FirebaseAuth.instance.currentUser?.displayName ?? 'Your Name',
                                  petOwnerName: chatRoomData['userName'],
                                  userUid1AvatarUrl:  chatRoomData['userUid1AvatarUrl'],
                                  userUid2AvatarUrl: chatRoomData['userUid2AvatarUrl'],
                                ),
                              ),
                            );
                          }, recentMessageIndication: 1,
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
