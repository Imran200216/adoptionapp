import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/favorite_provider/add_pet_favorite_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
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

              // Use Consumer to listen to changes in the AddPetFavoriteProvider
              Consumer<AddPetFavoriteProvider>(
                builder: (context, favoriteProvider, child) {
                  // If the list of favorite pets is empty, show the Lottie animation
                  if (favoriteProvider.favoritePets.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          Lottie.asset(
                            "assets/lotties/my_favorites_no_item_lottie.json",
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          AutoSizeText(
                            'No favorites added',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * 0.044,
                              color: const Color(0xFF646883),
                              fontFamily: "NunitoSans",
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    // If there are favorite pets, show them in a list
                    return Expanded(
                      child: ListView.builder(
                        itemCount: favoriteProvider.favoritePets.length,
                        itemBuilder: (context, index) {
                          // Retrieve the pet data from the favoritePets list
                          var petData = favoriteProvider.favoritePets[index];

                          // Extract details from the pet data
                          String petId = petData['petId'];
                          String petName = petData['petName'];
                          String petBreed = petData['petBreed'];
                          String petGender = petData['petGender'];
                          int petAge = petData['petAge'];
                          String imageUrl = petData['imageUrl'];

                          // Return a ListTile to display the pet information
                          return ListTile(
                            leading: imageUrl.isNotEmpty
                                ? Image.network(
                                    imageUrl,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(Icons.pets),
                            // Default icon if no image
                            title: Text(petName),
                            subtitle: Text(
                                '$petBreed, $petGender, $petAge years old'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // Remove pet from favorites
                                favoriteProvider.removePetFromFavorites(
                                  petId,
                                  context,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
