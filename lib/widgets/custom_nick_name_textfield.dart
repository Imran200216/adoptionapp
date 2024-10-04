import 'package:adoptionapp/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomNickNameTextField extends StatelessWidget {
  final TextEditingController nickNameController;
  final VoidCallback onTap;

  const CustomNickNameTextField({
    super.key,
    required this.nickNameController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return TextField(
      controller: nickNameController,
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
          onPressed: onTap,
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
    );
  }
}
