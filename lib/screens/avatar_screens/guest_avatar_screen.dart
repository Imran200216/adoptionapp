import 'package:adoptionapp/constants/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GuestAvatarScreen extends StatelessWidget {
  const GuestAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 30,
            top: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                textAlign: TextAlign.start,
                'Add Avatars',
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: size.width * 0.062,
                  color: AppColors.blackColor,
                  fontFamily: "NunitoSans",
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Container(
                height: size.height * 0.40,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade200,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/images/svg/add-person-icon.svg",
                    height: size.height * 0.30,
                    fit: BoxFit.cover,
                    color: AppColors.subTitleColor,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              ListView.builder(
                itemBuilder: (context, index) {
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
