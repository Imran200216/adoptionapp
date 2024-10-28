import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/modals/pet_modal.dart';
import 'package:adoptionapp/provider/add_post_provider/add_pet_to_firestore_provider.dart';
import 'package:adoptionapp/provider/app_required_providers/internet_checker_provider.dart';
import 'package:adoptionapp/provider/category_provider/pet_category_provider.dart';
import 'package:adoptionapp/provider/favorite_provider/add_pet_favorite_provider.dart';
import 'package:adoptionapp/provider/search_provider/search_provider.dart';
import 'package:adoptionapp/screens/chat_bot/chat_bot_intro_screen.dart';
import 'package:adoptionapp/screens/chat_bot/chat_bot_screen.dart';
import 'package:adoptionapp/screens/description_screen/pet_description_screen.dart';
import 'package:adoptionapp/widgets/custom_alert_dialog.dart';
import 'package:adoptionapp/widgets/custom_chips.dart';
import 'package:adoptionapp/widgets/custom_internet_checker.dart';
import 'package:adoptionapp/widgets/pet_card.dart';
import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_refresh/liquid_pull_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// media query
    final size = MediaQuery.of(context).size;

    /// add pet content provider
    final addPetContentProvider =
        Provider.of<AddPetToFireStoreProvider>(context);

    /// pet category providers
    final petProvider = Provider.of<PetCategoryProvider>(context);

    /// internet checker provider
    final internetCheckerProvider =
        Provider.of<InternetCheckerProvider>(context);

    /// favorite provider
    final favoriteProvider = Provider.of<AddPetFavoriteProvider>(context);

    /// search provider
    final searchProvider = Provider.of<SearchProvider>(context);

    /// Define the pet categories and SVG icons
    final List<Map<String, String>> petCategories = [
      {'name': 'All', 'icon': 'assets/images/svg/all.svg'},
      {'name': 'Cats', 'icon': 'assets/images/svg/cat.svg'},
      {'name': 'Dogs', 'icon': 'assets/images/svg/dog.svg'},
      {'name': 'Birds', 'icon': 'assets/images/svg/bird.svg'},
      {'name': 'Others', 'icon': 'assets/images/svg/other.svg'},
    ];

    /// check intro status
    Future<void> checkIntroStatus(BuildContext context) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isIntroSeen = prefs.getBool('isIntroSeen') ?? false;

      if (!isIntroSeen) {
        // If the intro is not seen, navigate to ChatBotIntroScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatBotIntroScreen()),
        );
      } else {
        // Otherwise, navigate to the ChatBotScreen directly
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatBotScreen()),
        );
      }
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          // Check if the intro has been seen before navigating
          checkIntroStatus(context);
        },
        child: Center(
          child: SvgPicture.asset(
            "assets/images/svg/chatbot-icon.svg",
            height: size.height * 0.036,
            color: AppColors.secondaryColor,
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: LiquidPullRefresh(
        showChildOpacityTransition: true,
        onRefresh: () async {
          /// loading all pets from the add pet content provider
          await addPetContentProvider.fetchAllPets();
        },
        color: AppColors.secondaryColor,
        backgroundColor: AppColors.primaryColor,
        child: SingleChildScrollView(
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
                        onChanged: (value) {
                          /// search functionality
                          searchProvider.setSearchQuery(value);
                        },
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
                      },
                      petCategories: petCategories,
                      selectedCategory: petProvider.selectedCategory,
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

                    if (!internetCheckerProvider.isNetworkConnected)
                      const CustomInternetChecker()
                    else

                      /// Fetch and display pets from database based on selected category
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('pets')
                            .snapshots(),
                        builder: (context, snapshot) {
                          // Check if the snapshot has data
                          if (!snapshot.hasData) {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                /// shimmer card
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height: size.height * 0.15,
                                    // Example height for the shimmer
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: size.height * 0.02,
                                );
                              },
                            );
                          }

                          /// Get all pets initially
                          final allPets = snapshot.data!.docs;

                          /// Filter pets based on selected category and search query
                          final filteredPets = allPets.where((pet) {
                            final petCategory = pet['petCategory'] ??
                                'Others'; // Replace with your actual field name
                            final petName = pet['petName']?.toLowerCase() ?? '';
                            final petBreed =
                                pet['petBreed']?.toLowerCase() ?? '';
                            final searchQuery =
                                searchProvider.searchQuery.toLowerCase();

                            final matchesCategory =
                                petProvider.selectedCategory == 'All' ||
                                    petCategory == petProvider.selectedCategory;

                            final matchesSearchQuery = searchQuery.isEmpty ||
                                petName.contains(searchQuery) ||
                                petBreed.contains(searchQuery);

                            return matchesCategory && matchesSearchQuery;
                          }).toList();

                          /// If no pets match the selected category or search query, show the empty animation
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
                                    'No pets found in this category or search query!',
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

                          /// If pets are found, display them
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredPets.length,
                            itemBuilder: (context, index) {
                              /// Get the pet data as a DocumentSnapshot
                              var petSnapshot = filteredPets[index];

                              /// Ensure that petSnapshot is of type DocumentSnapshot
                              /// Extract the data as a Map<String, dynamic>
                              var petData =
                                  petSnapshot.data() as Map<String, dynamic>?;

                              // Check if petData is not null before creating an instance of PetModels
                              if (petData != null) {
                                // Create an instance of PetModels from the pet data
                                PetModels pet =
                                    PetModels.fromFirestore(petData);

                                return Dismissible(
                                  key: Key(pet.petId),
                                  // Ensure that the key is unique
                                  background: Container(
                                    color: Colors.red,
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomAlertDialog(
                                            title: "Delete adoption post",
                                            content:
                                                "Are you sure want to delete the post?",
                                            confirmText: "Delete",
                                            cancelText: "Cancel",
                                            onConfirm: () {
                                              /// deletion of pet posts
                                              addPetContentProvider.deletePet(
                                                pet.petId,
                                                pet.petImages,
                                                context,
                                              );
                                            },
                                            onCancel: () {
                                              Navigator.pop(context);
                                            });
                                      },
                                    );
                                  },
                                  child: OpenContainer(
                                    transitionType:
                                        ContainerTransitionType.fade,
                                    transitionDuration:
                                        const Duration(milliseconds: 800),
                                    openBuilder:
                                        (BuildContext context, VoidCallback _) {
                                      // Pass the pet object to PetDescriptionScreen
                                      return PetDescriptionScreen(pet: pet);
                                    },
                                    closedShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    closedElevation: 0.0,
                                    closedBuilder: (BuildContext context,
                                        VoidCallback openContainer) {
                                      return PetCard(
                                        onFavoriteTap: () {
                                          /// add to favorite using provider
                                          if (favoriteProvider
                                              .isFavorite(pet.petId)) {
                                            // If the pet is already a favorite, remove it
                                            favoriteProvider.removeFavoritePet(
                                                pet.petId, context);
                                          } else {
                                            // If the pet is not a favorite, add it
                                            favoriteProvider.addFavoritePet(
                                                pet.petId, context);
                                          }
                                        },
                                        favoriteIcon: Icon(
                                          favoriteProvider.isFavorite(pet.petId)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: favoriteProvider
                                                  .isFavorite(pet.petId)
                                              ? AppColors.failureToastColor
                                              : AppColors.subTitleColor,
                                        ),
                                        petId: pet.petId,
                                        imageUrl: pet.petImages.isNotEmpty
                                            ? pet.petImages[0]
                                            : "Pet Image",
                                        petName: pet.petName,
                                        petBreed: pet.petBreed,
                                        petGender: pet.petGender,
                                        petAge: pet.petAge,
                                        petOwnerName: pet.petOwnerName,
                                      );
                                    },
                                  ),
                                );
                              } else {
                                // Return an empty container if petData is null
                                return Container();
                              }
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
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
