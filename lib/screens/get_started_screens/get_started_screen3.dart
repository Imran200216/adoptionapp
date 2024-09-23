import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/constants/textStyles.dart';
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
          CachedNetworkImage(
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
            imageBuilder: (context, imageProvider) {
              return Container(
                width: size.width * 0.84,
                height: size.height * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: size.height * 0.04,
          ),

          /// titles
          Text(
            textAlign: TextAlign.center,
            "Open Your Heart to a Friend in Need",
            style: CustomTextStyles.getStartedTitleText(context),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),

          /// sub title
          Text(
            textAlign: TextAlign.center,
            "Adopting an animal is more than just gaining a pet. It’s about saving a life and gaining unconditional love. Start your adoption journey with us.",
            style: CustomTextStyles.getStartedSubTitleText(context),
          ),
        ],
      ),
    );
  }
}
