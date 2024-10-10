import 'package:adoptionapp/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      title: Text(
        title,
      ),
      titleTextStyle: TextStyle(
        fontFamily: "NunitoSans",
        color: AppColors.primaryColor,
        fontSize: size.width * 0.05,
        fontWeight: FontWeight.w700,
      ),
      content: Text(
        content,
      ),
      contentTextStyle: TextStyle(
        fontFamily: "NunitoSans",
        color: AppColors.subTitleColor,
        fontSize: size.width * 0.05,
        fontWeight: FontWeight.w700,
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(
            cancelText,
            style: TextStyle(
              fontFamily: "NunitoSans",
              color: AppColors.subTitleColor,
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(
            confirmText,
            style: TextStyle(
              fontFamily: "NunitoSans",
              color: AppColors.primaryColor,
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
