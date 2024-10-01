import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/screens/add_pet_content.dart';
import 'package:adoptionapp/widgets/custom_icon_btn.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 30,
              top: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SvgPicture.asset(
                    "assets/images/svg/modal-sheet.svg",
                    height: size.height * 0.5,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                AutoSizeText(
                  textAlign: TextAlign.start,
                  'Adopt your pet through posting in Rehome',
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: size.width * 0.048,
                    color: AppColors.blackColor,
                    fontFamily: "NunitoSans",
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                AutoSizeText(
                  textAlign: TextAlign.start,
                  'Follow the steps to adopt the pets.',
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: size.width * 0.040,
                    color: AppColors.subTitleColor,
                    fontFamily: "NunitoSans",
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                CustomIconBtn(
                  btnHeight: size.height * 0.06,
                  btnWidth: size.width,
                  btnText: "Post your pet for adoption",
                  btnBorderRadius: 6,
                  btnOnTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const AddPetContent();
                    }));
                  },
                  btnIcon: Icons.post_add,
                  btnColor: AppColors.primaryColor,
                  btnTextColor: AppColors.secondaryColor,
                  btnIconColor: AppColors.secondaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
