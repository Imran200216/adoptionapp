import 'package:adoptionapp/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppInformationScreen extends StatelessWidget {
  const AppInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// media query
    final size = MediaQuery.of(context).size;

    // List of image URLs for the carousel
    final List<String> imageUrls = [
      'https://plus.unsplash.com/premium_photo-1668098738089-e417d5ecde01?q=80&w=2072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      "https://images.unsplash.com/photo-1700408273757-b3e190a2dfa2?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "https://images.unsplash.com/photo-1511044568932-338cba0ad803?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    ];

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 30,
            bottom: 30,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.blackColor,
                        size: size.width * 0.072,
                      ),
                    ),
                    Text(
                      "About ReHome",
                      style: TextStyle(
                        fontFamily: "NunitoSans",
                        fontWeight: FontWeight.w800,
                        color: AppColors.blackColor,
                        fontSize: size.width * 0.06,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: size.height * 0.3,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                  ),
                  items: imageUrls.map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return CachedNetworkImage(
                          imageUrl: imageUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              // Set the border radius here
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Center(
                            child: LoadingAnimationWidget.discreteCircle(
                              color: AppColors.primaryColor,
                              size: size.width * 0.08,
                            ),
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: Icon(
                              Icons.error,
                              size: size.width * 0.08,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Text(
                  'Welcome to ReHome, the ultimate adoption app designed to connect loving families with pets in need of a forever home. '
                  'ReHome provides a seamless and user-friendly platform where potential adopters can browse through a diverse range of animals available for adoption. '
                  'Each profile includes detailed information about the pet\'s age, breed, temperament, and medical history, alongside heartwarming photos that capture their unique personalities. '
                  'Our goal is to facilitate meaningful connections, ensuring that every pet finds a safe and loving environment where they can thrive.',
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    height: 1.5,
                    fontFamily: "NunitoSans",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'ReHome goes beyond just pet adoption; it fosters a community of passionate animal lovers. '
                  'Users can share their adoption journeys, post updates, and interact with other adopters through our integrated social features. '
                  'We also provide valuable resources, including tips on pet care, training, and responsible ownership, helping families prepare for the responsibilities of pet parenthood. '
                  'With ReHome, we aim to create a supportive ecosystem that encourages adoption and promotes the welfare of all animals, ensuring that every pet finds their perfect match.',
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    height: 1.5,
                    fontFamily: "NunitoSans",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
