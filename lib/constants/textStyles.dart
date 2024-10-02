import 'package:adoptionapp/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextStyles {
  // Responsive headline style
  static TextStyle headline(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth * 0.08, // 8% of screen width
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  // normal btn text
  static TextStyle buttonText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth * 0.04,
      fontWeight: FontWeight.w600,
      fontFamily: "NunitoSans",
      color: AppColors.secondaryColor,
    );
  }

  /// outlined btn text
  static TextStyle buttonOutlinedText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth * 0.04,
      fontWeight: FontWeight.w600,
      fontFamily: "NunitoSans",
      color: AppColors.primaryColor,
    );
  }

  /// title text
  static TextStyle getStartedTitleText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth * 0.06,
      fontWeight: FontWeight.bold,
      fontFamily: "NunitoSans",
      color: AppColors.titleColor,
    );
  }

  /// title text
  static TextStyle getStartedSubTitleText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth * 0.04,
      fontWeight: FontWeight.w500,
      fontFamily: "NunitoSans",
      color: AppColors.subTitleColor,
    );
  }

  /// snack bar text
  static TextStyle doubleTapExitSnackBarText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth * 0.05,
      fontWeight: FontWeight.w500,
      fontFamily: "NunitoSans",
      color: AppColors.primaryColor,
    );
  }

  /// auth title text
  static TextStyle authTitleText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth * 0.07,
      fontWeight: FontWeight.w900,
      fontFamily: "NunitoSans",
      color: AppColors.primaryColor,
    );
  }

  static TextStyle authSubTitleText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth * 0.04,
      fontWeight: FontWeight.w600,
      fontFamily: "NunitoSans",
      color: const Color(0xFF57647F),
    );
  }

  /// drawer text
  static TextStyle drawerText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth * 0.04,
      fontWeight: FontWeight.w700,
      fontFamily: "NunitoSans",
      color: AppColors.subTitleColor,
    );
  }

  /// drawer text
  static TextStyle profileTitleText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth * 0.054,
      fontWeight: FontWeight.w800,
      fontFamily: "NunitoSans",
      color: AppColors.blackColor,
    );
  }

  static TextStyle profileSubTitleText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth * 0.044,
      fontWeight: FontWeight.w700,
      fontFamily: "NunitoSans",
      color: AppColors.subTitleColor,
    );
  }

  static TextStyle profileListTileText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth * 0.046,
      fontWeight: FontWeight.w700,
      fontFamily: "NunitoSans",
      color: AppColors.blackColor,
    );
  }
}
