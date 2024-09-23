import 'package:adoptionapp/constants/textStyles.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmailLoginScreen extends StatelessWidget {
  const EmailLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DoubleTapToExit(
      child: SafeArea(
        child: Scaffold(
          body: Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 30,
              bottom: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/images/svg/login.svg",
                  height: size.height * 0.4,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  "Sign up",
                  style: CustomTextStyles.authTitleText(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
