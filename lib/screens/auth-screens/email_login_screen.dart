import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/constants/textStyles.dart';
import 'package:adoptionapp/provider/auth_providers/email_auth_provider.dart';
import 'package:adoptionapp/screens/auth-screens/email_register_screen.dart';
import 'package:adoptionapp/screens/auth-screens/forget_password_screen.dart';
import 'package:adoptionapp/widgets/custom_icon_btn.dart';
import 'package:adoptionapp/widgets/custom_password_textfield.dart';
import 'package:adoptionapp/widgets/custom_textfield.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EmailLoginScreen extends StatelessWidget {
  const EmailLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DoubleTapToExit(
      child: SafeArea(
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
                      SizedBox(
                        height: size.height * 0.03,
                      ),

                      /// email address text field
                      CustomTextField(
                        textEditingController:
                            emailAuthProvider.loginEmailController,
                        textFieldInputType: TextInputType.emailAddress,
                        textFieldIcon: Icons.alternate_email,
                        textFieldName: "Email Address",
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      /// password text field
                      CustomPasswordTextField(
                        textEditingController:
                            emailAuthProvider.loginPasswordController,
                        hintText: "Password",
                        fieldKey: "loginPassword",
                        prefixIcon: Icons.lock_outline,
                        keyboardType: TextInputType.visiblePassword,
                        textFieldName: "Password",
                      ),

                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      /// forget password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              HapticFeedback.heavyImpact();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const ForgetPasswordScreen();
                              }));
                            },
                            child: Text(
                              "Forget Password?",
                              style: TextStyle(
                                fontFamily: "NunitoSans",
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryColor,
                                fontSize: size.width * 0.042,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: size.height * 0.04,
                      ),

                      /// login btn (email login functionality)
                      CustomIconBtn(
                        btnTextColor: AppColors.secondaryColor,
                        btnIconColor: AppColors.secondaryColor,
                        btnColor: AppColors.primaryColor,
                        btnHeight: size.height * 0.06,
                        btnWidth: size.width,
                        btnText: "Login",
                        btnBorderRadius: 4,
                        btnOnTap: () {
                          HapticFeedback.heavyImpact();

                          emailAuthProvider.loginWithEmailPassword(context);
                        },
                        btnIcon: Icons.login_rounded,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "You are new?",
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
                                return const EmailRegisterScreen();
                              }));
                            },
                            child: Text(
                              "Just Register!",
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
      ),
    );
  }
}
