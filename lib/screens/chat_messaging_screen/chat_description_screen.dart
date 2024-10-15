import 'package:adoptionapp/constants/colors.dart';
import 'package:flutter/material.dart';

class ChatDescriptionScreen extends StatelessWidget {
  const ChatDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text("Imran B"),
          titleTextStyle: TextStyle(
            fontSize: size.width * 0.050,
            fontFamily: "NunitoSans",
            fontWeight: FontWeight.w800,
            color: AppColors.secondaryColor,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.secondaryColor,
              size: size.width * 0.072,
            ),
          ),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.zero,
            image: DecorationImage(
              image: AssetImage(
                "assets/images/jpg/chat-bg.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
