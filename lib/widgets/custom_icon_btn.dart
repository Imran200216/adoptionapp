import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/constants/textStyles.dart';
import 'package:flutter/material.dart';

class CustomIconBtn extends StatelessWidget {
  final double btnHeight;
  final double btnWidth;
  final String btnText;
  final double btnBorderRadius;
  final IconData btnIcon;
  final VoidCallback btnOnTap;

  const CustomIconBtn({
    super.key,
    required this.btnHeight,
    required this.btnWidth,
    required this.btnText,
    required this.btnBorderRadius,
    required this.btnOnTap,
    required this.btnIcon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: btnOnTap,
      child: Container(
        height: btnHeight,
        width: btnWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(btnBorderRadius),
          color: AppColors.primaryColor,
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                btnIcon,
                size: size.height * 0.03,
                color: AppColors.secondaryColor,
              ),
              SizedBox(
                width: size.width * 0.02,
              ),
              Text(
                btnText,
                style: CustomTextStyles.buttonText(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
