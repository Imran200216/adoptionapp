import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/favorite_provider/add_pet_favorite_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class PetCard extends StatelessWidget {
  final String petId;
  final String imageUrl;
  final String petName;
  final String petBreed;
  final String petGender;
  final int petAge;
  final String petOwnerName;

  const PetCard({
    super.key,
    required this.imageUrl,
    required this.petName,
    required this.petBreed,
    required this.petGender,
    required this.petAge,
    required this.petOwnerName,
    required this.petId,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // pet category provider
    final favoritePetsProvider = Provider.of<AddPetFavoriteProvider>(context);

    return Container(
      height: size.height * 0.18,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFFF2F3F2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Row(
              children: [
                // pet image
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: size.height,
                    width: size.width * 0.34,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: AppColors.primaryColor,
                        size: size.width * 0.05,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      size: size.width * 0.03,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.06),

                /// Pet name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      petName,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: size.width * 0.050,
                        color: const Color(0xFF4D4C4C),
                        fontFamily: "NunitoSans",
                      ),
                    ),

                    SizedBox(height: size.height * 0.002),

                    /// Pet breed
                    AutoSizeText(
                      petBreed,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.040,
                        color: const Color(0xFF4D4C4C),
                        fontFamily: "NunitoSans",
                      ),
                    ),

                    SizedBox(height: size.height * 0.002),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /// Pet gender
                        AutoSizeText(
                          "$petGender,",
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.036,
                            color: AppColors.subTitleColor,
                            fontFamily: "NunitoSans",
                          ),
                        ),

                        /// Pet age
                        AutoSizeText(
                          petAge.toString(),
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.036,
                            color: AppColors.subTitleColor,
                            fontFamily: "NunitoSans",
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: size.height * 0.03),

                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: AppColors.primaryColor,
                          size: size.width * 0.06,
                        ),
                        SizedBox(width: size.width * 0.02),

                        /// Pet owner name
                        AutoSizeText(
                          petOwnerName,
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: size.width * 0.040,
                            color: AppColors.primaryColor,
                            fontFamily: "NunitoSans",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: -10,
              child: IconButton(
                onPressed: () {
                  // Check if the pet is already a favorite
                  if (favoritePetsProvider.isFavorite(petId)) {
                    // If it is, remove it from favorites
                    favoritePetsProvider.removePetFromFavorites(petId, context);
                  } else {
                    // If it's not, add it to favorites
                    favoritePetsProvider.addPetToFavorites({
                      'petId': petId,
                      'imageUrl': imageUrl,
                      'name': petName,
                      'breed': petBreed,
                      'gender': petGender,
                      'age': petAge,
                      'ownerName': petOwnerName,
                    }, context);
                  }
                },
                icon: Icon(
                  favoritePetsProvider.isFavorite(petId)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: favoritePetsProvider.isFavorite(petId)
                      ? Colors.red
                      : Colors.grey,
                  size: size.width * 0.072,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
