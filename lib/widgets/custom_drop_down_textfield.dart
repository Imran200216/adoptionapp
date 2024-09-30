import 'package:flutter/material.dart';
import 'package:adoptionapp/constants/colors.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final String hintText;
  final IconData dropdownIcon;
  final Function(T?)? onChanged;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.hintText,
    required this.dropdownIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DropdownButtonFormField<T>(
      value: selectedItem,
      onChanged: onChanged,
      icon: Icon(
        dropdownIcon,
        color: AppColors.subTitleColor,
      ),
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(
          fontSize: size.width * 0.042,
          color: AppColors.subTitleColor,
          fontWeight: FontWeight.w600,
          fontFamily: "NunitoSans",
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.subTitleColor),
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.subTitleColor,
            width: 2,
          ),
          borderRadius: BorderRadius.zero,
        ),
      ),
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
