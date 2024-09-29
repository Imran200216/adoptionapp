import 'package:adoptionapp/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PetCategoryChips extends StatelessWidget {
  final List<Map<String, String>> petCategories;

  const PetCategoryChips({
    super.key,
    required this.petCategories,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: petCategories.map((category) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 18,
            ),
            child: Container(
              width: size.width * 0.20,
              height: size.height * 0.12,
              decoration: BoxDecoration(
                color: AppColors.primaryLightShapeColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    category['icon']!,
                    width: 50.0, // Size of the SVG icon
                    height: 50.0,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['name']!,
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontFamily: "NunitoSans",
                      fontWeight: FontWeight.w700,
                      fontSize: size.width * 0.04, // Text size
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
