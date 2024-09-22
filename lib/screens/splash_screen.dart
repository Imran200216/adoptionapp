import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/screens/get_started.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// media query of app
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.zero,
          color: AppColors.secondaryColor,
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const GetStarted();
            }));
          },
          child: Center(
            child: Text(
              "ReHome",
              style: TextStyle(
                fontFamily: "NunitoSans",
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
                fontSize: size.width * 0.068,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
