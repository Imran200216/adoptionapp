import 'package:adoptionapp/constants/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: size.height * 0.42,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.zero,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.zero,
                child: CachedNetworkImage(
                  imageUrl:
                      "https://images.unsplash.com/photo-1570122734014-386e3ef867cc?q=80&w=1936&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
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
              height: size.height * 0.2,
            ),
            AutoSizeText(
              textAlign: TextAlign.start,
              'The text to display',
              maxLines: 2,
            )
          ],
        ),
      ),
    );
  }
}
