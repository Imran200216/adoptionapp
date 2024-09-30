import 'package:adoptionapp/constants/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class PetDescriptionScreen extends StatelessWidget {
  const PetDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 30,
            bottom: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: size.height * 0.03,
                      color: AppColors.subTitleColor,
                    ),
                  ),

                  /// favorite btn
                  Container(
                    height: size.height * 0.062,
                    width: size.width * 0.12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.primaryLightShapeColor,
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          size: size.height * 0.03,
                          color: AppColors.failureToastColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// pet name
                  AutoSizeText(
                    textAlign: TextAlign.start,
                    'Sparkly',
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: size.width * 0.08,
                      color: AppColors.blackColor,
                      fontFamily: "NunitoSans",
                    ),
                  ),

                  /// pet gender
                  Icon(
                    Icons.female,
                    size: size.width * 0.084,
                    color: AppColors.subTitleColor,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.001,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// pet breed name
                  AutoSizeText(
                    textAlign: TextAlign.start,
                    'Golden Retriever',
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.04,
                      color: AppColors.blackColor,
                      fontFamily: "NunitoSans",
                    ),
                  ),

                  /// pet age
                  AutoSizeText(
                    textAlign: TextAlign.start,
                    '8 months old',
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.04,
                      color: AppColors.blackColor,
                      fontFamily: "NunitoSans",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
