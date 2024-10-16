import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/modals/pet_modal.dart';
import 'package:adoptionapp/provider/app_required_providers/phone_call_provider.dart';
import 'package:adoptionapp/provider/favorite_provider/add_pet_favorite_provider.dart';
import 'package:adoptionapp/provider/pet_description_provider/pet_description_provider.dart';
import 'package:adoptionapp/screens/bottom_nav_screens/chat_screen.dart';
import 'package:adoptionapp/screens/chat_messaging_screen/chat_description_screen.dart';
import 'package:adoptionapp/widgets/circular_icon_btn.dart';
import 'package:adoptionapp/widgets/custom_btn.dart';
import 'package:adoptionapp/widgets/custom_message_request_dialog_box.dart';
import 'package:adoptionapp/widgets/pet_description_content.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PetDescriptionScreen extends StatelessWidget {
  final PetModels pet;

  const PetDescriptionScreen({
    super.key,
    required this.pet,
  });

  @override
  Widget build(BuildContext context) {
    /// media query
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Consumer3<PhoneCallProvider, PetDescriptionProvider,
            AddPetFavoriteProvider>(
          builder: (
            context,
            phoneCallProvider,
            petDescriptionProvider,
            favoriteProvider,
            child,
          ) {
            return Container(
              margin: const EdgeInsets.only(
                top: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: size.height * 0.03,
                            color: AppColors.subTitleColor,
                          ),
                        ),

                        /// favorite btn
                        IconButton(
                          onPressed: () {
                            /// add to favorite using provider
                            if (favoriteProvider.isFavorite(pet.petId)) {
                              // If the pet is already a favorite, remove it
                              favoriteProvider.removeFavoritePet(
                                  pet.petId, context);
                            } else {
                              // If the pet is not a favorite, add it
                              favoriteProvider.addFavoritePet(
                                  pet.petId, context);
                            }
                          },
                          icon: Icon(
                            favoriteProvider.isFavorite(pet.petId)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: favoriteProvider.isFavorite(pet.petId)
                                ? AppColors.failureToastColor
                                : AppColors.subTitleColor,
                            size: size.width * 0.08,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  /// pet image
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    height: MediaQuery.of(context).size.height * 0.30,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                      controller: petDescriptionProvider.pageController,
                      itemCount: pet.petImages.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl: pet.petImages[index],
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: LoadingAnimationWidget.discreteCircle(
                                color: AppColors.primaryColor,
                                size: size.width * 0.06,
                              ),
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: Icon(
                                Icons.error,
                                size: size.width * 0.06,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  // Space between images and indicator

                  pet.petImages.length == 2
                      ? SmoothPageIndicator(
                          controller: petDescriptionProvider.pageController,
                          count: pet.petImages.length,
                          effect: const WormEffect(
                            activeDotColor: Colors.blue,
                            dotHeight: 8,
                            dotWidth: 8,
                            spacing: 8,
                          ),
                        )
                      : const SizedBox(),

                  SizedBox(height: size.height * 0.04),

                  /// Expanded section to make it scrollable
                  Expanded(
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 26,
                            bottom: 20,
                            right: 20,
                            left: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// pet name
                              AutoSizeText(
                                textAlign: TextAlign.start,
                                pet.petName,
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: size.width * 0.06,
                                  color: AppColors.petDescriptionTitleColor,
                                  fontFamily: "NunitoSans",
                                ),
                              ),

                              SizedBox(
                                height: size.height * 0.001,
                              ),

                              /// pet breed name
                              AutoSizeText(
                                textAlign: TextAlign.start,
                                pet.petBreed,
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: size.width * 0.04,
                                  color: AppColors.petDescriptionSubTitleColor,
                                  fontFamily: "NunitoSans",
                                ),
                              ),

                              SizedBox(
                                height: size.height * 0.02,
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  /// pet gender
                                  PetDescriptionContent(
                                    dividerColor: const Color(0xFFFFE7A9),
                                    petDescriptionContentTitle: pet.petGender,
                                    petDescriptionContentSubTitle: "Gender",
                                  ),

                                  /// pet age
                                  PetDescriptionContent(
                                    dividerColor: const Color(0xFFFFDFDF),
                                    petDescriptionContentTitle:
                                        "${pet.petAge} Months",
                                    petDescriptionContentSubTitle: "Age",
                                  ),

                                  /// pet weight
                                  PetDescriptionContent(
                                    dividerColor: const Color(0xFFEEDFFF),
                                    petDescriptionContentTitle:
                                        "${pet.petWeight} kg",
                                    petDescriptionContentSubTitle: "Weight",
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: size.height * 0.02,
                              ),

                              /// vaccinated or not
                              pet.isVaccinated == true
                                  ? Container(
                                      height: size.height * 0.05,
                                      width: size.width * 0.44,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xFF7ED596),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AutoSizeText(
                                              textAlign: TextAlign.start,
                                              'Vaccinated',
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: size.width * 0.04,
                                                color: const Color(0xFF445549),
                                                fontFamily: "NunitoSans",
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.width * 0.03,
                                            ),
                                            SvgPicture.asset(
                                              "assets/images/svg/correct-icon.svg",
                                              height: size.height * 0.03,
                                              fit: BoxFit.cover,
                                              color: const Color(0xFF445549),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: size.height * 0.05,
                                      width: size.width * 0.48,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.failureToastColor,
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AutoSizeText(
                                              textAlign: TextAlign.start,
                                              'Not Vaccinated',
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: size.width * 0.04,
                                                color: AppColors.secondaryColor,
                                                fontFamily: "NunitoSans",
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.width * 0.03,
                                            ),
                                            SvgPicture.asset(
                                              "assets/images/svg/vaccine-icon.svg",
                                              height: size.height * 0.03,
                                              fit: BoxFit.cover,
                                              color: AppColors.secondaryColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                              SizedBox(
                                height: size.height * 0.02,
                              ),

                              /// address
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // To ensure alignment at the top
                                children: [
                                  Container(
                                    height: size.height * 0.12,
                                    width: size.width * 0.12,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFE5F3F8),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.location_on,
                                        size: size.height * 0.03,
                                        color: const Color(0xFF85C1E1),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.04,
                                  ),

                                  /// location
                                  Expanded(
                                    // Allowing the text to expand within available space
                                    child: AutoSizeText(
                                      pet.petLocation,
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      // Add ellipsis if the text overflows
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: size.width * 0.04,
                                        color: AppColors
                                            .petDescriptionSubTitleColor,
                                        fontFamily: "NunitoSans",
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              /// pet description
                              AutoSizeText(
                                textAlign: TextAlign.start,
                                'About ${pet.petName}',
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: size.width * 0.054,
                                  color: AppColors.petDescriptionTitleColor,
                                  fontFamily: "NunitoSans",
                                ),
                              ),

                              SizedBox(
                                height: size.height * 0.01,
                              ),

                              AutoSizeText(
                                textAlign: TextAlign.start,
                                pet.petDescription,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: size.width * 0.042,
                                  color: AppColors.petDescriptionSubTitleColor,
                                  fontFamily: "NunitoSans",
                                ),
                              ),

                              SizedBox(
                                height: size.height * 0.02,
                              ),

                              Row(
                                children: [
                                  Row(
                                    children: [
                                      /// calling phone number functionality
                                      CircularIconBtn(
                                        onTap: () {
                                          phoneCallProvider.phoneCallToggle(
                                            pet.petOwnerPhoneNumber,
                                            context,
                                          );
                                        },
                                        btnIcon: Icons.phone,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.04,
                                      ),
                                      CircularIconBtn(
                                        onTap: () {
                                          /// want to make the functionality of the chat of my userUID and another userUID to chat
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return ChatDescriptionScreen();
                                          }));
                                        },
                                        btnIcon: Icons.chat,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: size.width * 0.08,
                                  ),
                                  Expanded(
                                    child: CustomBtn(
                                      btnHeight: size.height * 0.052,
                                      btnWidth: size.width,
                                      btnText: "Adopt Buddy",
                                      btnBorderRadius: 6,
                                      btnOnTap: () {
                                        /// adopt functionality
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
