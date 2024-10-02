import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/screens/description_screen/pet_description_screen.dart';
import 'package:adoptionapp/widgets/custom_chips.dart';
import 'package:adoptionapp/widgets/pet_card.dart';
import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Define the pet categories and SVG icons
    final List<Map<String, String>> petCategories = [
      {
        'name': 'All',
        'icon': 'assets/images/svg/all.svg',
      },
      {
        'name': 'Cats',
        'icon': 'assets/images/svg/cat.svg',
      },
      {
        'name': 'Dogs',
        'icon': 'assets/images/svg/dog.svg',
      },
      {
        'name': 'Birds',
        'icon': 'assets/images/svg/bird.svg',
      },
      {
        'name': 'Others',
        'icon': 'assets/images/svg/other.svg',
      },
    ];

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          textAlign: TextAlign.start,
                          'ReHome',
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: size.width * 0.05,
                            color: const Color(0xFF4D4C4C),
                            fontFamily: "NunitoSans",
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications,
                            color: AppColors.subTitleColor,
                            size: size.width * 0.06,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    /// search field
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F3F2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          color: AppColors.blackColor,
                          fontFamily: "NunitoSans",
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          hintText: "Type your favorite breed...",
                          hintStyle: TextStyle(
                            color: AppColors.subTitleColor,
                            fontFamily: "NunitoSans",
                            fontSize: size.width * 0.04,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.subTitleColor,
                            size: size.width * 0.06,
                          ),
                          border: InputBorder.none,
                          // Remove the TextField border
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                        ),
                      ),
                    ),

                    ///chips
                    PetCategoryChips(
                      petCategories: petCategories,
                    ),

                    AutoSizeText(
                      textAlign: TextAlign.start,
                      'New Friends for adoption!',
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: size.width * 0.052,
                        color: const Color(0xFF4D4C4C),
                        fontFamily: "NunitoSans",
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.04,
                    ),

                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 24,
                      itemBuilder: (context, index) {
                        return OpenContainer(
                          transitionType: ContainerTransitionType.fade,
                          transitionDuration: const Duration(milliseconds: 800),
                          openBuilder: (BuildContext context, VoidCallback _) {
                            return const PetDescriptionScreen();
                          },
                          closedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              15.0,
                            ),
                          ),
                          closedElevation: 0.0,
                          openElevation: 0.0,
                          closedColor: AppColors.secondaryColor,
                          openColor: AppColors.secondaryColor,
                          closedBuilder: (BuildContext context,
                              VoidCallback openContainer) {
                            return InkWell(
                              onTap: openContainer,
                              child: const PetCard(),
                            );
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: size.height * 0.02,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
