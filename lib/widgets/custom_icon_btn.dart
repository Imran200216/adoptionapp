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
  final Color btnColor;
  final Color btnTextColor;
  final Color btnIconColor;

  const CustomIconBtn({
    super.key,
    required this.btnHeight,
    required this.btnWidth,
    required this.btnText,
    required this.btnBorderRadius,
    required this.btnOnTap,
    required this.btnIcon,
    required this.btnColor,
    required this.btnTextColor,
    required this.btnIconColor,
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
          color: btnColor,
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                btnIcon,
                size: size.height * 0.03,
                color: btnIconColor,
              ),
              SizedBox(
                width: size.width * 0.02,
              ),
              Text(
                btnText,
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.w800,
                  fontFamily: "NunitoSans",
                  color: btnTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
