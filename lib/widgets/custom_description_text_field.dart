import 'package:adoptionapp/constants/colors.dart';
import 'package:flutter/material.dart';

class DescriptionTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardTextInputType;
  final int maxLines;
  final IconData prefixIcon;

  const DescriptionTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardTextInputType = TextInputType.text,
    this.maxLines = 5,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width, // Makes it take the full width
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: TextField(
        style: TextStyle(
          fontSize: size.width * 0.042,
          color: AppColors.blackColor,
          fontWeight: FontWeight.w600,
          fontFamily: "NunitoSans",
        ),
        controller: controller,
        maxLines: maxLines,
        // Allows for longer input
        keyboardType: keyboardTextInputType,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
              left: 3.0,
              right: 10.0,
              bottom: 176,
            ),
            // Add padding to align the icon properly
            child: Icon(
              prefixIcon,
              color: AppColors.primaryColor,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
          hintStyle: TextStyle(
            fontSize: size.width * 0.042,
            color: AppColors.subTitleColor,
            fontWeight: FontWeight.w600,
            fontFamily: "NunitoSans",
          ),
        ),
      ),
    );
  }
}
