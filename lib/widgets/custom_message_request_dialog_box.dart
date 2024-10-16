import 'package:adoptionapp/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomMessageRequestDialogBox extends StatelessWidget {
  final VoidCallback onAllow;
  final VoidCallback onDeny;

  const CustomMessageRequestDialogBox({
    super.key,
    required this.onAllow,
    required this.onDeny,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      title: const Text('Chat Request'),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: AppColors.blackColor,
        fontSize: size.width * 0.05,
        fontFamily: "NunitoSans",
      ),
      content: const Text('Send the request to chat with adoption pet owner'),
      contentTextStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: AppColors.subTitleColor,
        fontSize: size.width * 0.04,
        fontFamily: "NunitoSans",
      ),
      actions: [
        TextButton(
          onPressed: onDeny,
          child: Text(
            'Deny',
            style: TextStyle(
              color: AppColors.subTitleColor,
              fontFamily: "NunitoSans",
              fontSize: size.width * 0.036,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextButton(
          onPressed: onAllow,
          child: Text(
            'Send request',
            style: TextStyle(
              fontFamily: "NunitoSans",
              fontSize: size.width * 0.036,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
