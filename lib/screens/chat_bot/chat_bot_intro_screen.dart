import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/app_required_providers/carousel_provider.dart';
import 'package:adoptionapp/provider/chat_bot_provider/ai_chat_bot_intro_provider.dart';
import 'package:adoptionapp/screens/chat_bot/chat_bot_screen.dart';
import 'package:adoptionapp/widgets/custom_icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ChatBotIntroScreen extends StatelessWidget {
  const ChatBotIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// media query for the screen size
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Consumer2<CarouselProvider, AiChatBotIntroProvider>(
          builder: (
            context,
            carouselProvider,
            aiChatBotIntroProvider,
            child,
          ) {
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 30,
                  bottom: 30,
                ),
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.zero,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // index for carousel slider
                    Center(
                      child: AnimatedSmoothIndicator(
                        activeIndex: carouselProvider.currentIndex,
                        count: carouselProvider.svgList.length,
                        effect: ExpandingDotsEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: AppColors.primaryColor,
                          dotColor: Colors.grey,
                        ),
                        onDotClicked: (index) {
                          // Update the page in PageView when a dot is clicked
                          carouselProvider.pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          carouselProvider.updateIndex(index);
                        },
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.05,
                    ),

                    /// image slider
                    SizedBox(
                      height: size.height * 0.40,
                      width: 400,
                      child: PageView.builder(
                        controller: carouselProvider.pageController,
                        itemCount: carouselProvider.svgList.length,
                        onPageChanged: (index) {
                          carouselProvider.updateIndex(index);
                        },
                        itemBuilder: (context, index) {
                          return SvgPicture.asset(
                            carouselProvider.svgList[index],
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    Text.rich(
                      TextSpan(
                        text: "Hello, It's AI ",
                        style: TextStyle(
                          fontSize: 28,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w700,
                          fontFamily: "NunitoSans",
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Echo',
                            style: TextStyle(
                              fontSize: 28,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w900,
                              fontFamily: "NunitoSans",
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    Text(
                      textAlign: TextAlign.center,
                      "Welcome to our AI assistant App!\nWe're excited to have you on\nboard. Here are a few steps to\nhelp you get started.  ",
                      style: TextStyle(
                        fontSize: size.width * 0.042,
                        color: AppColors.subTitleColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: "NunitoSans",
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    CustomIconBtn(
                      btnHeight: size.height * 0.06,
                      btnWidth: size.width,
                      btnText: "Skip",
                      btnBorderRadius: 40,
                      btnOnTap: () {
                        // Mark the intro screen as seen
                        aiChatBotIntroProvider.setIntroSeen();

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const ChatBotScreen();
                        }));
                      },
                      btnIcon: Icons.arrow_forward,
                      btnColor: AppColors.primaryColor,
                      btnTextColor: AppColors.secondaryColor,
                      btnIconColor: AppColors.secondaryColor,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
