import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/screens/get_started.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    /// Navigate to GetStarted screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      // Check if the widget is still mounted before navigating
      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const GetStarted();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    /// media query of app
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.zero,
          image: DecorationImage(
            image: AssetImage(
              "assets/images/jpg/splash-bg.jpeg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/svg/splash-logo.svg",
                height: size.height * 0.18,
                color: AppColors.secondaryColor,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: size.height * 0.028,
              ),
              Text(
                'ReHome',
                style: TextStyle(
                  fontSize: size.width * 0.068,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Playwrite",
                  color: AppColors.secondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
