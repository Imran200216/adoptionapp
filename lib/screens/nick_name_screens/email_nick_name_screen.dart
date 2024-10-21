import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/user_details_providers/email_avatar_provider.dart';
import 'package:adoptionapp/widgets/custom_icon_btn.dart';
import 'package:adoptionapp/widgets/custom_nick_name_textfield.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class EmailNickNameScreen extends StatelessWidget {
  const EmailNickNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.secondaryColor,
        body: Consumer<EmailUserDetailsProvider>(
          builder: (
            context,
            emailUserDetailsProvider,
            child,
          ) {
            return SingleChildScrollView(
              // Add SingleChildScrollView here
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  top: 30,
                  bottom: 30,
                  right: 30,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/images/svg/avatar.svg",
                        height: size.height * 0.4,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      AutoSizeText(
                        textAlign: TextAlign.start,
                        'Set up Profile Name',
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: size.width * 0.060,
                          color: AppColors.blackColor,
                          fontFamily: "NunitoSans",
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      AutoSizeText(
                        textAlign: TextAlign.center,
                        'Add a cool nickname to blend in your adoption vibes!',
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: size.width * 0.044,
                          color: AppColors.subTitleColor,
                          fontFamily: "NunitoSans",
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      CustomNickNameTextField(
                        nickNameController:
                            emailUserDetailsProvider.nicknameControllerByEmail,
                        onTap: () {
                          emailUserDetailsProvider.nicknameControllerByEmail
                              .clear();
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.08,
                      ),

                      /// updating the nickname to the database
                      emailUserDetailsProvider.isLoading
                          ? LoadingAnimationWidget.discreteCircle(
                              color: AppColors.primaryColor,
                              size: size.width * 0.06,
                            )
                          : CustomIconBtn(
                              btnHeight: size.height * 0.06,
                              btnWidth: size.width,
                              btnText: "All Set, Let's Go!",
                              btnBorderRadius: 4,
                              btnOnTap: () {
                                emailUserDetailsProvider.setNickname(context);
                              },
                              btnIcon: Icons.navigate_next_outlined,
                              btnColor: AppColors.primaryColor,
                              btnTextColor: AppColors.secondaryColor,
                              btnIconColor: AppColors.secondaryColor,
                            ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
