import 'package:adoptionapp/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddTextField extends StatelessWidget {
  final String prefixIconPath;
  final String hintText;
  final TextEditingController? textEditingController;
  final TextInputType keyboardTextInputType;

  const AddTextField({
    super.key,
    required this.prefixIconPath,
    required this.hintText,
    this.textEditingController,
    required this.keyboardTextInputType,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextField(
      controller: textEditingController,
      keyboardType: keyboardTextInputType,
      style: TextStyle(
        fontSize: size.width * 0.042,
        color: AppColors.blackColor,
        fontWeight: FontWeight.w600,
        fontFamily: "NunitoSans",
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: size.width * 0.042,
          color: AppColors.subTitleColor,
          fontWeight: FontWeight.w600,
          fontFamily: "NunitoSans",
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          // Adjust padding to fit the icon size
          child: SvgPicture.asset(
            "assets/images/svg/$prefixIconPath.svg",

            color: AppColors.primaryColor,

            height: 24,

            width: 24, // Adjust the width if needed
          ),
        ),
        filled: true,
        fillColor: Colors.white,
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
    );
  }
}
