import 'package:adoptionapp/provider/app_required_providers/carousel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/services.dart';
import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/constants/textStyles.dart';
import 'package:adoptionapp/screens/auth-screens/email_login_screen.dart';
import 'package:adoptionapp/screens/auth-screens/email_register_screen.dart';
import 'package:adoptionapp/screens/get_started_screens/get_started_screen1.dart';
import 'package:adoptionapp/screens/get_started_screens/get_started_screen2.dart';
import 'package:adoptionapp/screens/get_started_screens/get_started_screen3.dart';
import 'package:adoptionapp/widgets/custom_btn.dart';
import 'package:adoptionapp/widgets/custom_outlined_btn.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DoubleTapToExit(
      snackBar: SnackBar(
        content: Text(
          'Tap again to exit!',
          style: CustomTextStyles.doubleTapExitSnackBarText(context),
        ),
      ),
      child: Consumer<CarouselProvider>(
        // Updated to CarouselProvider
        builder: (context, carouselProvider, child) {
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: PageView(
                        controller: carouselProvider.pageController,
                        // Updated reference
                        onPageChanged: (int page) {},
                        children: const [
                          GetStartedScreen1(),
                          GetStartedScreen2(),
                          GetStartedScreen3(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 30,
                    ),
                    child: Column(
                      children: [
                        // Smooth Page Indicator
                        SmoothPageIndicator(
                          controller: carouselProvider.pageController,
                          // Updated reference
                          count: 3,
                          effect: ExpandingDotsEffect(
                            activeDotColor: AppColors.primaryColor,
                            dotColor: Colors.grey.shade300,
                            dotHeight: 8,
                            dotWidth: 8,
                            expansionFactor: 3,
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        // Buttons for Register and Sign In
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Register Button
                            Expanded(
                              child: CustomBtn(
                                btnOnTap: () {
                                  HapticFeedback.heavyImpact();
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const EmailRegisterScreen();
                                  }));
                                },
                                btnBorderRadius: 8,
                                btnHeight: size.height * 0.064,
                                btnWidth: size.width * 0.3,
                                btnText: "Register",
                              ),
                            ),
                            SizedBox(width: size.width * 0.05),

                            // Login Button
                            Expanded(
                              child: CustomOutlinedBtn(
                                btnOnTap: () {
                                  HapticFeedback.heavyImpact();
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const EmailLoginScreen();
                                  }));
                                },
                                btnBorderRadius: 8,
                                btnHeight: size.height * 0.064,
                                btnWidth: size.width * 0.3,
                                btnText: "Sign in",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
