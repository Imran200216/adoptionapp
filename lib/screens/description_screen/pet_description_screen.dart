import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/modals/pet_modal.dart';
import 'package:adoptionapp/provider/app_required_providers/phone_call_provider.dart';
import 'package:adoptionapp/provider/favorite_provider/add_pet_favorite_provider.dart';
import 'package:adoptionapp/provider/pet_description_provider/pet_description_provider.dart';
import 'package:adoptionapp/provider/user_chat_provider/chat_room_provider.dart';
import 'package:adoptionapp/screens/chat_messaging_screen/chat_description_screen.dart';
import 'package:adoptionapp/widgets/circular_icon_btn.dart';
import 'package:adoptionapp/widgets/custom_btn.dart';
import 'package:adoptionapp/widgets/pet_description_content.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        body: Consumer4<PhoneCallProvider, PetDescriptionProvider,
            AddPetFavoriteProvider, ChatRoomProvider>(
          builder: (
            context,
            phoneCallProvider,
            petDescriptionProvider,
            favoriteProvider,
            chatRoomProvider,
            child,
          ) {
            return Container(
              margin: const EdgeInsets.only(
                top: 30,
              ),
              child: Stack(
                children: [
                  /// ui design contents
                  Column(
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
                                      color:
                                          AppColors.petDescriptionSubTitleColor,
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
                                        petDescriptionContentTitle:
                                            pet.petGender,
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
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                                    color:
                                                        const Color(0xFF445549),
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
                                                  color:
                                                      const Color(0xFF445549),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(
                                          height: size.height * 0.05,
                                          width: size.width * 0.48,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                                    color: AppColors
                                                        .secondaryColor,
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
                                                  color:
                                                      AppColors.secondaryColor,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      color:
                                          AppColors.petDescriptionSubTitleColor,
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

                                          /// creating the chat room
                                          CircularIconBtn(
                                            onTap: () async {
                                              final currentUser = FirebaseAuth
                                                  .instance.currentUser;

                                              if (currentUser != null) {
                                                final currentUserUid = currentUser
                                                    .uid; // Fetch the logged-in user UID
                                                final otherUserUid = pet
                                                    .userUid; // UID of the user who posted the pet card
                                                final petOwnerName = pet
                                                    .petOwnerName; // Owner's name
                                                final currentUserName = currentUser
                                                        .displayName ??
                                                    'Your Name'; // Current user's name

                                                // Create or fetch the chat room
                                                await context
                                                    .read<ChatRoomProvider>()
                                                    .createChatRoom(
                                                      currentUserUid,
                                                      otherUserUid,
                                                      context,
                                                    );

                                                // Fetch userUid1's avatar URL (current user)
                                                final userUid1AvatarUrl =
                                                    await context
                                                        .read<
                                                            ChatRoomProvider>()
                                                        .getUserAvatarUrl(
                                                            currentUserUid);

                                                // Fetch userUid2's avatar URL (other user)
                                                final userUid2AvatarUrl =
                                                    await context
                                                        .read<
                                                            ChatRoomProvider>()
                                                        .getUserAvatarUrl(
                                                            otherUserUid);

                                                // Check if user UIDs are different before navigating
                                                if (currentUserUid !=
                                                    otherUserUid) {
                                                  // Get the roomId
                                                  String roomId = context
                                                      .read<ChatRoomProvider>()
                                                      .getRoomId(currentUserUid,
                                                          otherUserUid);

                                                  // Navigate to the ChatDescriptionScreen
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return ChatDescriptionScreen(
                                                          roomId: roomId,
                                                          userUid1:
                                                              currentUserUid,
                                                          // Current user's UID
                                                          userUid2:
                                                              otherUserUid,
                                                          // Other user's UID
                                                          userUid1Name:
                                                              currentUserName,
                                                          // Current user's name
                                                          petOwnerName:
                                                              petOwnerName,
                                                          // Pet owner's name
                                                          userUid1AvatarUrl:
                                                              userUid1AvatarUrl ??
                                                                  "https://imgs.search.brave.com/G7EAKN2_tgpXRvp6SG9UP-WdSrIotMa3XzzGAZ29UCo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAwLzIzLzcyLzU5/LzM2MF9GXzIzNzI1/OTQ0X1cyYVNyZzNL/cXczbE9tVTRJQW43/aVhWODhSbm5mY2gx/LmpwZw",
                                                          // Avatar URL for current user
                                                          userUid2AvatarUrl:
                                                              userUid2AvatarUrl ??
                                                                  "https://imgs.search.brave.com/G7EAKN2_tgpXRvp6SG9UP-WdSrIotMa3XzzGAZ29UCo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAwLzIzLzcyLzU5/LzM2MF9GXzIzNzI1/OTQ0X1cyYVNyZzNL/cXczbE9tVTRJQW43/aVhWODhSbm5mY2gx/LmpwZw",
                                                          // Avatar URL for other user
                                                        );
                                                      },
                                                    ),
                                                  );
                                                }
                                              } else {
                                                // Handle case when user is not logged in
                                                print("User is not logged in");
                                              }
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

                  /// loading state of creation of chat room
                  chatRoomProvider.isLoading
                      ? Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Center(
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                // Adjust the radius as needed
                                color: AppColors.secondaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    // Black shadow with 30% opacity
                                    offset: Offset(0, 4),
                                    // Shadow offset
                                    blurRadius: 10,
                                    // Blur radius for shadow
                                    spreadRadius:
                                        2, // Optional: Spread radius for shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child: LoadingAnimationWidget.discreteCircle(
                                  color: AppColors.primaryColor,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
