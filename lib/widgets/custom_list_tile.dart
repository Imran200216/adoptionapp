import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/constants/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomListTile extends StatelessWidget {
  final String leadingListTilePath;
  final Color leadingListTileBgColor;
  final String listTileText;
  final VoidCallback listTileOnTap;

  const CustomListTile({
    super.key,
    required this.leadingListTilePath,
    required this.leadingListTileBgColor,
    required this.listTileText,
    required this.listTileOnTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: listTileOnTap, // This should handle the tap
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        leading: Container(
          height: size.height * 0.14,
          width: size.width * 0.14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: leadingListTileBgColor,
          ),
          child: Center(
            child: SvgPicture.asset(
              "assets/images/svg/$leadingListTilePath.svg",
              color: AppColors.blackColor,
              height: size.height * 0.034,
              fit: BoxFit.cover,
            ),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: size.width * 0.05,
          color: AppColors.blackColor,
        ),
        title: Text(listTileText),
        titleTextStyle: CustomTextStyles.profileListTileText(context),
      ),
    );
  }
}
