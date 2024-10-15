import 'package:adoptionapp/constants/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

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
                'My Favorites',
                maxLines: 2,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: size.width * 0.062,
                  color: AppColors.blackColor,
                  fontFamily: "NunitoSans",
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
