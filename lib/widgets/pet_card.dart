import 'package:adoptionapp/constants/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class PetCard extends StatelessWidget {
  const PetCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                /// pet image[0]
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.network(
                    "https://plus.unsplash.com/premium_photo-1668606763482-8dd2042c934e?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    height: size.height,
                    width: size.width * 0.34,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.06,
                ),

                /// pet name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///pet name
                    AutoSizeText(
                      textAlign: TextAlign.start,
                      "Sparkly",
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: size.width * 0.050,
                        color: const Color(0xFF4D4C4C),
                        fontFamily: "NunitoSans",
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.002,
                    ),

                    /// pet breed
                    AutoSizeText(
                      textAlign: TextAlign.start,
                      "Golden Retriver",
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.040,
                        color: const Color(0xFF4D4C4C),
                        fontFamily: "NunitoSans",
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.002,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /// pet gender
                        AutoSizeText(
                          textAlign: TextAlign.start,
                          "Female,",
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.036,
                            color: AppColors.subTitleColor,
                            fontFamily: "NunitoSans",
                          ),
                        ),

                        /// pet age
                        AutoSizeText(
                          textAlign: TextAlign.start,
                          "8 months",
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.036,
                            color: AppColors.subTitleColor,
                            fontFamily: "NunitoSans",
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: size.height * 0.03,
                    ),

                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: AppColors.primaryColor,
                          size: size.width * 0.06,
                        ),
                        SizedBox(
                          width: size.width * 0.02,
                        ),

                        /// pet owner name
                        AutoSizeText(
                          textAlign: TextAlign.start,
                          "Sanjiv",
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: size.width * 0.040,
                            color: AppColors.primaryColor,
                            fontFamily: "NunitoSans",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: -10,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: const Color(0xFFFE5E4E),
                  size: size.width * 0.072,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
