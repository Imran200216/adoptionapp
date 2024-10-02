import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/constants/textStyles.dart';
import 'package:adoptionapp/provider/auth_providers/email_auth_provider.dart';
import 'package:adoptionapp/screens/auth-screens/email_login_screen.dart';
import 'package:adoptionapp/screens/avatar_screens/guest_avatar_screen.dart';
import 'package:adoptionapp/widgets/custom_icon_btn.dart';
import 'package:adoptionapp/widgets/custom_password_textfield.dart';
import 'package:adoptionapp/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EmailRegisterScreen extends StatelessWidget {
  const EmailRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Consumer<EmailAuthenticationProvider>(
          builder: (
            context,
            emailAuthProvider,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/images/svg/register.svg",
                      height: size.height * 0.4,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      "Register In",
                      style: CustomTextStyles.authTitleText(context),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),

                    /// user name
                    CustomTextField(
                      textEditingController: emailAuthProvider.nameController,
                      textFieldInputType: TextInputType.text,
                      textFieldIcon: Icons.person_outlined,
                      textFieldName: "Person",
                    ),

                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    /// mail address
                    CustomTextField(
                      textEditingController:
                          emailAuthProvider.registerEmailController,
                      textFieldInputType: TextInputType.emailAddress,
                      textFieldIcon: Icons.alternate_email,
                      textFieldName: "Email Address",
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    /// password
                    CustomPasswordTextField(
                      textEditingController:
                          emailAuthProvider.registerPasswordController,
                      hintText: "Password",
                      fieldKey: "registerPassword",
                      prefixIcon: Icons.lock_outline,
                      keyboardType: TextInputType.visiblePassword,
                      textFieldName: "Password",
                    ),

                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    /// confirm password
                    CustomPasswordTextField(
                      textEditingController:
                          emailAuthProvider.registerConfirmPasswordController,
                      hintText: "Password",
                      fieldKey: "registerConfirmPassword",
                      prefixIcon: Icons.lock_outline,
                      keyboardType: TextInputType.visiblePassword,
                      textFieldName: "Password",
                    ),

                    SizedBox(
                      height: size.height * 0.04,
                    ),

                    /// register btn (register functionality)
                    CustomIconBtn(
                      btnTextColor: AppColors.secondaryColor,
                      btnIconColor: AppColors.secondaryColor,
                      btnColor: AppColors.primaryColor,
                      btnHeight: size.height * 0.06,
                      btnWidth: size.width,
                      btnText: "Register",
                      btnBorderRadius: 4,
                      btnOnTap: () {
                        HapticFeedback.heavyImpact();
                        emailAuthProvider.registerWithEmailPassword(context);
                      },
                      btnIcon: Icons.login_rounded,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            height: 0.1,
                            color: AppColors.subTitleColor,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Text(
                          "OR",
                          style: CustomTextStyles.drawerText(context),
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Expanded(
                          child: Divider(
                            height: 0.1,
                            color: AppColors.subTitleColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    /// guest tbn
                    CustomIconBtn(
                      btnTextColor: AppColors.blackColor,
                      btnIconColor: AppColors.blackColor,
                      btnColor: AppColors.guestBtnColor,
                      btnHeight: size.height * 0.06,
                      btnWidth: size.width,
                      btnText: "Register with guest",
                      btnBorderRadius: 4,
                      btnOnTap: () {
                        HapticFeedback.heavyImpact();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const GuestAvatarScreen();
                        }));
                      },
                      btnIcon: Icons.person,
                    ),

                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Joined us before?",
                          style: TextStyle(
                            fontFamily: "NunitoSans",
                            fontWeight: FontWeight.w500,
                            color: AppColors.subTitleColor,
                            fontSize: size.width * 0.044,
                          ),
                        ),

                        /// register text btn
                        TextButton(
                          onPressed: () {
                            HapticFeedback.heavyImpact();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const EmailLoginScreen();
                            }));
                          },
                          child: Text(
                            "Login in!",
                            style: TextStyle(
                              fontFamily: "NunitoSans",
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor,
                              fontSize: size.width * 0.048,
                            ),
                          ),
                        ),
                      ],
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
