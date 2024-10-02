import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/auth_providers/password_visibility_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomPasswordTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String hintText;
  final String fieldKey;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final String textFieldName;

  const CustomPasswordTextField({
    super.key,
    this.textEditingController,
    required this.hintText,
    required this.fieldKey,
    required this.prefixIcon,
    required this.keyboardType,
    required this.textFieldName,

  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<PasswordVisibilityProvider>(
      builder: (
        context,
        passwordVisibilityProvider,
        child,
      ) {
        return TextField(
          obscureText: passwordVisibilityProvider.isObscure(fieldKey),
          // Toggles password visibility
          keyboardType: keyboardType,
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
              prefixIcon,
              color: AppColors.subTitleColor,
              size: size.height * 0.032,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                // Toggles the visibility when pressed
                passwordVisibilityProvider.toggleVisibility(fieldKey);
              },
              icon: Icon(
                passwordVisibilityProvider.isObscure(fieldKey)
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: passwordVisibilityProvider.isObscure(fieldKey)
                    ? AppColors.subTitleColor
                    : AppColors.primaryColor,
              ),
            ),
            border: const UnderlineInputBorder(
              borderRadius: BorderRadius.zero,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.subTitleColor),
              borderRadius: BorderRadius.zero,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.subTitleColor,
                width: 2,
              ),
              borderRadius: BorderRadius.zero,
            ),
          ),
        );
      },
    );
  }
}
