import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/app_required_providers/internet_checker_provider.dart';
import 'package:adoptionapp/provider/chat_bot_provider/chat_bot_provider.dart';
import 'package:adoptionapp/provider/chat_bot_provider/scroll_chat_provider.dart';
import 'package:adoptionapp/provider/chatbot_message/chatbot_message.dart';
import 'package:adoptionapp/screens/bottom_nav.dart';
import 'package:adoptionapp/screens/chat_bot/chat_bot_intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  Future<void> handleBackNavigation(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isIntroSeen = prefs.getBool('isIntroSeen') ?? false;

    if (isIntroSeen) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavBar()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ChatBotIntroScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            onPressed: () {
              handleBackNavigation(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.secondaryColor,
            ),
          ),
          title: const Text("Echo AI"),
          titleTextStyle: TextStyle(
            fontFamily: "NunitoSans",
            color: AppColors.secondaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.8), BlendMode.dstATop),
              image: const AssetImage('assets/images/jpg/chatbotbg-img.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Consumer2<ChatBotProvider, InternetCheckerProvider>(
            builder: (context, chatProvider, internetProvider, _) {
              if (!internetProvider.isNetworkConnected) {
                /// internet lottie have to show
              }

              return Column(
                children: [
                  Expanded(
                    child: chatProvider.messages.isEmpty
                        ? Center(
                            child: Container(
                              height: 300,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.secondaryColor,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Lottie.asset(
                                    "assets/lotties/chatbot.json",
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: 200,
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "Start a conversation!",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "NunitoSans",
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Consumer<ScrollChatProvider>(
                            builder: (context, scrollProvider, _) {
                              return ListView.builder(
                                controller: scrollProvider.scrollController,
                                itemCount: chatProvider.messages.length,
                                itemBuilder: (context, index) {
                                  final message = chatProvider.messages[index];
                                  return Messages(
                                    isUser: message.isUser,
                                    message: message.message,
                                    date: DateFormat('HH:mm')
                                        .format(message.date),
                                  );
                                },
                              );
                            },
                          ),
                  ),
                  if (internetProvider.isNetworkConnected)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        right: 14,
                        left: 14,
                        bottom: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 15,
                            child: TextField(
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "NunitoSans",
                                fontWeight: FontWeight.w500,
                              ),
                              cursorColor: AppColors.primaryColor,
                              controller: chatProvider.userInputController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.message_outlined,
                                  color: AppColors.subTitleColor,
                                ),
                                border: const OutlineInputBorder(),
                                hintText: 'Enter your message',
                                filled: true,
                                fillColor: AppColors.secondaryColor,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.primaryColor,
                                    width: 1.4,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.primaryColor,
                                    width: 1.4,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "NunitoSans",
                                  color: AppColors.subTitleColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () async {
                              await chatProvider.sendMessage();
                              // Scroll to bottom after message is sent
                              context
                                  .read<ScrollChatProvider>()
                                  .scrollToBottom();
                            },
                            child: Center(
                              child: Container(
                                height: 54,
                                width: 54,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.primaryColor,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/images/svg/send-icon.svg",
                                    height: 26,
                                    width: 26,
                                    fit: BoxFit.cover,
                                    color: AppColors.secondaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
