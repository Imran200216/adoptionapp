import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/modals/pet_modal.dart';
import 'package:adoptionapp/provider/add_post_provider/add_pet_to_firestore_provider.dart';
import 'package:adoptionapp/provider/favorite_provider/add_pet_favorite_provider.dart';
import 'package:adoptionapp/screens/description_screen/pet_description_screen.dart';
import 'package:adoptionapp/widgets/custom_alert_dialog.dart';
import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:adoptionapp/widgets/pet_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// media query
    final size = MediaQuery.of(context).size;

    /// add pet content provider
    final addPetContentProvider =
        Provider.of<AddPetToFireStoreProvider>(context);

    /// favorite provider
    final favoriteProvider = Provider.of<AddPetFavoriteProvider>(context);
    final favoritePets = favoriteProvider.favoritePetIds;

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 30,
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              'My Favorites',
              maxLines: 2,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: size.width * 0.062,
                color: AppColors.blackColor,
                fontFamily: "NunitoSans",
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: favoritePets.isEmpty
                  ? Center(
                      // Display Lottie animation when the favorite list is empty
                      child: Column(
                        children: [
                          Lottie.asset(
                            'assets/lotties/empty-animation.json',
                            // Path to your Lottie file
                            width: size.width * 0.7,
                            height: size.height * 0.4,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            "No pet is added to favorite!",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.subTitleColor,
                              fontSize: size.width * 0.04,
                              fontFamily: "NunitoSans",
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: favoritePets.length,
                      itemBuilder: (context, index) {
                        final petId = favoritePets[index];

                        // Fetch the pet details from Firestore using the petId
                        return FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('pets')
                              .doc(petId)
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (!snapshot.hasData || snapshot.data == null) {
                              return const Center(
                                child: Text('Pet details not found'),
                              );
                            }

                            // Extract the pet data using fromFirestore
                            var petData =
                                snapshot.data!.data() as Map<String, dynamic>;
                            PetModels pet = PetModels.fromFirestore(petData);

                            return Slidable(
                              key: Key(petId),
                              endActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                extentRatio: 0.25,
                                // Adjusts the width of the slide able action
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
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
                                              // Handle deletion of pet posts
                                              addPetContentProvider.deletePet(
                                                pet.petId,
                                                pet.petImages,
                                                context,
                                              );
                                              Navigator.pop(
                                                  context); // Close dialog after delete
                                            },
                                            onCancel: () {
                                              Navigator.pop(
                                                  context); // Close dialog without action
                                            },
                                          );
                                        },
                                      );
                                    },
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: OpenContainer(
                                transitionType: ContainerTransitionType.fade,
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
                                openElevation: 0.0,
                                closedColor: AppColors.secondaryColor,
                                openColor: AppColors.secondaryColor,
                                closedBuilder: (BuildContext context,
                                    VoidCallback openContainer) {
                                  return InkWell(
                                    onTap: openContainer,
                                    child: PetCard(
                                      petId: petId,
                                      imageUrl: pet.petImages.isNotEmpty
                                          ? pet.petImages[0]
                                          : 'https://via.placeholder.com/150',
                                      petName: pet.petName,
                                      petBreed: pet.petBreed,
                                      petGender: pet.petGender,
                                      petAge: pet.petAge,
                                      petOwnerName: pet.petOwnerName,
                                      favoriteIcon: const Icon(
                                        Icons.favorite,
                                        color:
                                            Colors.red, // Show solid red icon
                                      ),
                                      onFavoriteTap: () {
                                        // Remove from favorites when tapped
                                        favoriteProvider.removeFavoritePet(
                                          petId,
                                          context,
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
