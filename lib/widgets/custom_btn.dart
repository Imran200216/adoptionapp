import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/constants/textStyles.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final double btnHeight;
  final double btnWidth;
  final String btnText;
  final double btnBorderRadius;
  final VoidCallback btnOnTap;

  const CustomBtn({
    super.key,
    required this.btnHeight,
    required this.btnWidth,
    required this.btnText,
    required this.btnBorderRadius,
    required this.btnOnTap,
  });

  @override
  Widget build(BuildContext context) {
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
          child: Text(
            btnText,
            style: CustomTextStyles.buttonText(context),
          ),
        ),
      ),
    );
  }
}
