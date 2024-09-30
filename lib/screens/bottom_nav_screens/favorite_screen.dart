import 'package:adoptionapp/constants/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 30,
            top: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                textAlign: TextAlign.start,
                'My Favorites',
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: size.width * 0.062,
                  color: AppColors.blackColor,
                  fontFamily: "NunitoSans",
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Lottie.asset(
                      "assets/lotties/my_favorites_no_item_lottie.json",
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: size.height * 0.0001,
                    ),
                    AutoSizeText(
                      textAlign: TextAlign.start,
                      'No favorites added',
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.044,
                        color: const Color(0xFF646883),
                        fontFamily: "NunitoSans",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
