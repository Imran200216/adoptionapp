import 'package:adoptionapp/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData textFieldIcon;
  final TextEditingController? textEditingController;
  final String textFieldName;
  final TextInputType textFieldInputType;

  const CustomTextField({
    super.key,
    required this.textFieldIcon,
    required this.textFieldName,
    this.textEditingController,
    required this.textFieldInputType,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextField(
      keyboardType: textFieldInputType,
      style: TextStyle(
        fontSize: size.width * 0.042,
        color: AppColors.blackColor,
        fontWeight: FontWeight.w600,
        fontFamily: "NunitoSans",
      ),
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: textFieldName,
        labelStyle: TextStyle(
          fontSize: size.width * 0.042,
          color: AppColors.subTitleColor,
          fontWeight: FontWeight.w600,
          fontFamily: "NunitoSans",
        ),
        prefixIcon: Icon(
          textFieldIcon,
          color: AppColors.subTitleColor,
          size: size.height * 0.032,
        ),
        // Icon for the email
        border: const UnderlineInputBorder(
          borderRadius: BorderRadius.zero,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.subTitleColor),
          // Color for the border
          borderRadius: BorderRadius.zero, // Rounded corners
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.subTitleColor,
            width: 2,
          ),
          // Focused border color
          borderRadius: BorderRadius.zero,
        ),
      ),
    );
  }
}
