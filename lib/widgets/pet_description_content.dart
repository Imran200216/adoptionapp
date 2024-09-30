import 'package:adoptionapp/constants/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class PetDescriptionContent extends StatelessWidget {
  final Color dividerColor;
  final String petDescriptionContentTitle;
  final String petDescriptionContentSubTitle;

  const PetDescriptionContent({
    super.key,
    required this.dividerColor,
    required this.petDescriptionContentTitle,
    required this.petDescriptionContentSubTitle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        /// pet gender
        Container(
          margin: const EdgeInsets.only(
            right: 16,
          ),
          height: size.height * 0.064,
          width: size.width * 0.02,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: dividerColor,
          ),
        ),

        /// pet breed name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// pet gender
            AutoSizeText(
              textAlign: TextAlign.start,
              petDescriptionContentTitle,
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: size.width * 0.042,
                color: AppColors.petDescriptionTitleColor,
                fontFamily: "NunitoSans",
              ),
            ),
            SizedBox(
              height: size.height * 0.003,
            ),

            /// male or female
            AutoSizeText(
              textAlign: TextAlign.start,
              petDescriptionContentSubTitle,
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: size.width * 0.036,
                color: AppColors.petDescriptionSubTitleColor,
                fontFamily: "NunitoSans",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
