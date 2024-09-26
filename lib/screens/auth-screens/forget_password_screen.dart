import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/constants/textStyles.dart';
import 'package:adoptionapp/widgets/custom_icon_btn.dart';
import 'package:adoptionapp/widgets/custom_textfield.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(
              left: 20,
              top: 30,
              bottom: 30,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: size.height * 0.04,
                    color: AppColors.subTitleColor,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SvgPicture.asset(
                  "assets/images/svg/forget-password.svg",
                  height: size.height * 0.5,
                  fit: BoxFit.cover,
                ),
                Text(
                  "Forget\nPassword?",
                  style: CustomTextStyles.authTitleText(context),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                AutoSizeText(
                  "Don't worry! It happens. Please address associated with your account.",
                  style: CustomTextStyles.authSubTitleText(context),
                ),
                SizedBox(
                  height: size.height * 0.033,
                ),
                const CustomTextField(
                  textFieldInputType: TextInputType.emailAddress,
                  textFieldIcon: Icons.alternate_email,
                  textFieldName: "Email Address",
                ),
                SizedBox(
                  height: size.height * 0.033,
                ),
                CustomIconBtn(
                  btnTextColor: AppColors.secondaryColor,
                  btnIconColor: AppColors.secondaryColor,
                  btnColor: AppColors.primaryColor,
                  btnHeight: size.height * 0.06,
                  btnWidth: size.width,
                  btnText: "Submit",
                  btnBorderRadius: 4,
                  btnOnTap: () {},
                  btnIcon: Icons.send,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
