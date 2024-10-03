import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/screens/nick_name_screens/email_nick_name_screen.dart';
import 'package:adoptionapp/widgets/custom_icon_btn.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EmailAvatarScreen extends StatelessWidget {
  const EmailAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DoubleTapToExit(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.secondaryColor,
          bottomSheet: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.zero,
              color: AppColors.secondaryColor,
            ),
            child: CustomIconBtn(
              btnHeight: size.height * 0.06,
              btnWidth: size.width,
              btnText: "Next",
              btnBorderRadius: 4,
              btnOnTap: () {
                /// moving to the next screen is nickname screen
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const EmailNickNameScreen();
                }));
              },
              btnIcon: Icons.navigate_next_outlined,
              btnColor: AppColors.primaryColor,
              btnTextColor: AppColors.secondaryColor,
              btnIconColor: AppColors.secondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
