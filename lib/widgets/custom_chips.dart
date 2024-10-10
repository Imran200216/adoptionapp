import 'package:adoptionapp/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PetCategoryChips extends StatelessWidget {
  final Function(String) onTap;
  final List<Map<String, String>> petCategories;
  final String selectedCategory;

  const PetCategoryChips({
    super.key,
    required this.petCategories,
    required this.onTap,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: petCategories.map((category) {
          bool isSelected = category['name'] == selectedCategory;

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 18,
            ),
            child: InkWell(
              onTap: () => onTap(category['name']!),
              child: Container(
                // Outer Container for the border
                decoration: BoxDecoration(
                  color: Colors.transparent, // Transparent to see the space
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color:
                        isSelected ? AppColors.blackColor : Colors.transparent,
                    width: 2,
                  ),
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
                        width: 50.0,
                        height: 50.0,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category['name']!,
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontFamily: "NunitoSans",
                          fontWeight: FontWeight.w700,
                          fontSize: size.width * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
