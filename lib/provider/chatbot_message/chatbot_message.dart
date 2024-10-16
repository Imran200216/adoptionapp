import 'package:adoptionapp/constants/colors.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  final bool isSent; // Add a new parameter to track if the message is sent

  const Messages({
    super.key,
    required this.isUser,
    required this.message,
    required this.date,
    this.isSent = false, // Default to not sent, can be passed as true if sent
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: BubbleSpecialOne(
          text: '$message\n$date',
          color: isUser
              ? (isSent
                  ? AppColors.primaryColor
                  : Colors.grey[400]!) // Sent: primary color, Not sent: grey
              : const Color(0xFFD6E7FE),
          isSender: isUser,
          textStyle: TextStyle(
            fontFamily: "NunitoSans",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isUser
                ? (isSent ? AppColors.secondaryColor : Colors.black54)
                : Colors.black,
          ),
          sent:
              isUser, // Use this to customize the sent status icon, if necessary
        ),
      ),
    );
  }
}
