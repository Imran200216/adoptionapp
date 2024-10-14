import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/screens/chat_messaging_screen/chat_description_screen.dart';
import 'package:adoptionapp/widgets/custom_chat_list_container.dart';
import 'package:flutter/material.dart';

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
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 30,
              bottom: 30,
            ),
            child: Column(
              children: [
                /// all chats text
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.chat,
                      size: size.width * 0.06,
                      color: AppColors.blackColor,
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Text(
                      "All Chats",
                      style: TextStyle(
                        fontFamily: "NunitoSans",
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),

                CustomChatListContainer(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ChatDescriptionScreen();
                    }));
                  },
                  avatarUrl:
                      "https://images.unsplash.com/photo-1492447166138-50c3889fccb1?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                  personName: "Imran B",
                  recentMessage: "Hi man!",
                  recentMessageIndication: 2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
