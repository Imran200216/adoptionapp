import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/category_provider/pet_category_provider.dart';
import 'package:adoptionapp/screens/description_screen/pet_description_screen.dart';
import 'package:adoptionapp/widgets/custom_chips.dart';
import 'package:adoptionapp/widgets/pet_card.dart';
import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final petProvider = Provider.of<PetCategoryProvider>(context);

    // Define the pet categories and SVG icons
    final List<Map<String, String>> petCategories = [
      {'name': 'All', 'icon': 'assets/images/svg/all.svg'},
      {'name': 'Cats', 'icon': 'assets/images/svg/cat.svg'},
      {'name': 'Dogs', 'icon': 'assets/images/svg/dog.svg'},
      {'name': 'Birds', 'icon': 'assets/images/svg/bird.svg'},
      {'name': 'Others', 'icon': 'assets/images/svg/other.svg'},
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
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                        ),
                      ),
                    ),

                    /// chips
                    PetCategoryChips(
                      onTap: (String category) {
                        petProvider.setCategory(category);
                        // You can decide whether to fetch pets again
                        // petProvider.fetchPets(); // Fetch pets based on selected category
                      },
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

                    /// Fetch and display pets from database based on selected category
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('pets')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting &&
                            !snapshot.hasData) {
                          // Initial loading state
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  "assets/lotties/waiting.json",
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                AutoSizeText(
                                  textAlign: TextAlign.start,
                                  'Loading!',
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: size.width * 0.040,
                                    color: const Color(0xFF4D4C4C),
                                    fontFamily: "NunitoSans",
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          // If no pets are found, show Lottie animation
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  'assets/lotties/empty-animation.json',
                                  fit: BoxFit.cover,
                                ),
                                AutoSizeText(
                                  textAlign: TextAlign.start,
                                  'No pets found!',
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: size.width * 0.040,
                                    color: const Color(0xFF4D4C4C),
                                    fontFamily: "NunitoSans",
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        // Get all pets initially
                        final allPets = snapshot.data!.docs;

                        // If a category is selected, filter the pets
                        final filteredPets =
                            petProvider.selectedCategory == 'All'
                                ? allPets
                                : allPets.where((pet) {
                                    final petCategory = pet['petCategory'] ??
                                        'Others'; // Replace with your actual field name
                                    return petCategory ==
                                        petProvider.selectedCategory;
                                  }).toList();

                        // If no pets match the selected category, show the empty animation
                        if (filteredPets.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  'assets/lotties/empty-animation.json',
                                  fit: BoxFit.cover,
                                ),
                                AutoSizeText(
                                  textAlign: TextAlign.start,
                                  'No pets found in this category!',
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: size.width * 0.040,
                                    color: const Color(0xFF4D4C4C),
                                    fontFamily: "NunitoSans",
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        // If pets are found, display them
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredPets.length,
                          itemBuilder: (context, index) {
                            var pet = filteredPets[index];
                            return OpenContainer(
                              transitionType: ContainerTransitionType.fade,
                              transitionDuration:
                                  const Duration(milliseconds: 800),
                              openBuilder:
                                  (BuildContext context, VoidCallback _) {
                                return const PetDescriptionScreen();
                              },
                              closedShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              closedElevation: 0.0,
                              openElevation: 0.0,
                              closedColor: AppColors.secondaryColor,
                              openColor: AppColors.secondaryColor,
                              closedBuilder: (BuildContext context,
                                  VoidCallback openContainer) {
                                return InkWell(
                                  onTap: openContainer,
                                  child: PetCard(
                                    imageUrl: pet['petImages'][0] ?? "",
                                    petName: pet['petName'] ?? "Unknown",
                                    petBreed: pet['petBreed'] ?? "Unknown",
                                    petGender: pet['petGender'] ?? "Unknown",
                                    petAge: pet['petAge'] ?? 0,
                                    petOwnerName:
                                        pet['petOwnerName'] ?? "Unknown",
                                  ),
                                );
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: size.height * 0.02,
                            );
                          },
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
