import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/constants/textStyles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GetStartedScreen3 extends StatelessWidget {
  const GetStartedScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
        left: 20,
        right: 20,
      ),
      height: size.height * 0.8,
      width: size.width,
      child: Column(
        children: [
          Container(
            width: size.width * 0.84,
            height: size.height * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl:
                    "https://images.unsplash.com/photo-1505628346881-b72b27e84530?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                placeholder: (context, url) {
                  return Center(
                    child: LoadingAnimationWidget.newtonCradle(
                      color: AppColors.primaryColor,
                      size: size.width * 0.3,
                    ),
                  );
                },
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: AppColors.primaryColor,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(
            height: size.height * 0.04,
          ),

          /// titles
          AutoSizeText(
            textAlign: TextAlign.center,
            "Find Your Perfect Companion",
            style: CustomTextStyles.getStartedTitleText(context),
            maxLines: 1,
          ),

          SizedBox(
            height: size.height * 0.02,
          ),

          /// sub title
          AutoSizeText(
            textAlign: TextAlign.center,
            "Join us in giving these wonderful animals a loving home. Browse through our furry, feathered, and scaly friends to find your next family member.",
            maxLines: 4,
            style: CustomTextStyles.getStartedSubTitleText(context),
          ),
        ],
      ),
    );
  }
}
