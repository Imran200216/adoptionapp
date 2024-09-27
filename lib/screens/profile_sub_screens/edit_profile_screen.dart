import 'package:adoptionapp/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.transparentColor,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.blackColor,
              size: size.width * 0.06,
            ),
          ),
          title: const Text("Edit Profile"),
          titleTextStyle: TextStyle(
            fontSize: size.width * 0.052,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
            fontFamily: "NunitoSans",
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 0,
            bottom: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: size.height * 0.24,
                    width: size.width * 0.24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0x0ff9fdff),
                      border: Border.all(
                        color: AppColors.primaryLightShapeColor,
                        width: 1.6,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/images/svg/image-add-icon.svg",
                        height: size.height * 0.058,
                        color: AppColors.primaryLightShapeColor,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  Text(
                    "Photo Upload+",
                    style: TextStyle(
                      fontFamily: "NunitoSans",
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.044,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
