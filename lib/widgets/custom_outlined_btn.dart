import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/constants/textStyles.dart';
import 'package:flutter/material.dart';

class CustomOutlinedBtn extends StatelessWidget {
  final double btnHeight;
  final double btnWidth;
  final String btnText;
  final double btnBorderRadius;
  final VoidCallback btnOnTap;

  const CustomOutlinedBtn({
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
          color: AppColors.transparentColor,
          border: Border.all(
            color: AppColors.primaryColor,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            btnText,
            style: CustomTextStyles.buttonOutlinedText(context),
          ),
        ),
      ),
    );
  }
}
