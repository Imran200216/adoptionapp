import 'package:adoptionapp/constants/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PetCard extends StatelessWidget {
  final String petId;
  final String imageUrl;
  final String petName;
  final String petBreed;
  final String petGender;
  final int petAge;
  final String petOwnerName;
  final Icon favoriteIcon;
  final VoidCallback onFavoriteTap;

  const PetCard({
    super.key,
    required this.imageUrl,
    required this.petName,
    required this.petBreed,
    required this.petGender,
    required this.petAge,
    required this.petOwnerName,
    required this.petId,
    required this.onFavoriteTap,
    required this.favoriteIcon,
  });

  @override
  Widget build(BuildContext context) {
    /// media query
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.18,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFFF2F3F2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Row(
              children: [
                // Pet image
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: size.height,
                    width: size.width * 0.34,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: AppColors.primaryColor,
                        size: size.width * 0.05,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      size: size.width * 0.03,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.06),

                // Wrapping the Column in Expanded to take up the remaining space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        petName,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: size.width * 0.050,
                          color: const Color(0xFF4D4C4C),
                          fontFamily: "NunitoSans",
                        ),
                      ),
                      SizedBox(height: size.height * 0.002),

                      // Pet breed
                      AutoSizeText(
                        petBreed,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.040,
                          color: const Color(0xFF4D4C4C),
                          fontFamily: "NunitoSans",
                        ),
                      ),
                      SizedBox(height: size.height * 0.002),

                      // Gender and age
                      Row(
                        children: [
                          // Wrapping the gender and age texts in Flexible to prevent overflow
                          Flexible(
                            child: AutoSizeText(
                              "$petGender,",
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: size.width * 0.036,
                                color: AppColors.subTitleColor,
                                fontFamily: "NunitoSans",
                              ),
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          // Add spacing between gender and age
                          Flexible(
                            child: AutoSizeText(
                              petAge.toString(),
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: size.width * 0.036,
                                color: AppColors.subTitleColor,
                                fontFamily: "NunitoSans",
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),

                      // Owner information
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: AppColors.primaryColor,
                            size: size.width * 0.06,
                          ),
                          SizedBox(width: size.width * 0.02),
                          Expanded(
                            child: AutoSizeText(
                              petOwnerName,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: size.width * 0.040,
                                color: AppColors.primaryColor,
                                fontFamily: "NunitoSans",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: -10,
              child: IconButton(
                onPressed: onFavoriteTap,
                icon: favoriteIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
