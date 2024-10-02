import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/screens/bottom_nav.dart';
import 'package:adoptionapp/widgets/custom_icon_btn.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GuestNickNameScreen extends StatelessWidget {
  const GuestNickNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.secondaryColor,
        body: SingleChildScrollView(
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
                  TextField(
                    keyboardType: TextInputType.name,
                    style: TextStyle(
                      fontSize: size.width * 0.042,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: "NunitoSans",
                    ),
                    decoration: InputDecoration(
                      labelText: "Nickname",
                      labelStyle: TextStyle(
                        fontSize: size.width * 0.042,
                        color: AppColors.subTitleColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: "NunitoSans",
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: AppColors.subTitleColor,
                        size: size.height * 0.032,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.clear,
                          color: AppColors.subTitleColor,
                          size: size.width * 0.054,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColors.subTitleColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.08,
                  ),
                  CustomIconBtn(
                    btnHeight: size.height * 0.06,
                    btnWidth: size.width,
                    btnText: "All Set, Let's Go!",
                    btnBorderRadius: 4,
                    btnOnTap: () {
                      /// moving to the next screen
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return BottomNavBar();
                      }));
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
        ),
      ),
    );
  }
}
