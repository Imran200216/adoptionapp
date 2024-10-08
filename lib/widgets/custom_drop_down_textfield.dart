import 'package:flutter/material.dart';
import 'package:adoptionapp/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final String hintText;
  final String prefixIconPath; // Added for prefix icon

  final Function(T?)? onChanged;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.hintText,
    required this.prefixIconPath, // Added parameter

    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DropdownButtonFormField<T>(
      value: selectedItem,
      onChanged: onChanged,
      icon: Icon(
        Icons.arrow_drop_down_circle,
        color: AppColors.primaryColor,
        size: size.width * 0.06,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: size.width * 0.042,
          color: AppColors.subTitleColor,
          fontWeight: FontWeight.w600,
          fontFamily: "NunitoSans",
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          // Adjust padding to fit the icon size
          child: SvgPicture.asset(
            "assets/images/svg/$prefixIconPath.svg",
            // Use the provided SVG path for prefix icon
            color: AppColors.primaryColor,
            height: 24,
            width: 24, // Adjust the width if needed
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.subTitleColor,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dropdownColor: Colors.white,
      items: items.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(
            value.toString(),
            style: TextStyle(
              fontSize: size.width * 0.042,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w600,
              fontFamily: "NunitoSans",
            ),
          ),
        );
      }).toList(),
    );
  }
}
