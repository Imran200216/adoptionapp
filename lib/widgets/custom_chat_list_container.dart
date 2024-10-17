import 'package:adoptionapp/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomChatListContainer extends StatelessWidget {
  final String avatarUrl; // Should be userUid2AvatarUrl
  final String personName; // Should be petOwnerName
  final String recentMessage;
  final int recentMessageIndication;
  final VoidCallback onTap;

  const CustomChatListContainer({
    super.key,
    required this.avatarUrl,
    required this.personName,
    required this.recentMessage,
    required this.recentMessageIndication,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.height * 0.09,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColors.secondaryColor,
        ),
        child: Container(
          margin: const EdgeInsets.only(
            left: 14,
            right: 14,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  /// Avatar
                  Container(
                    height: size.height * 0.12,
                    width: size.width * 0.12,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: avatarUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Center(
                        child: LoadingAnimationWidget.discreteCircle(
                          color: AppColors.primaryColor,
                          size: size.width * 0.03,
                        ),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(
                          Icons.error,
                          size: size.width * 0.03,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.04),

                  /// Chat messages (person name + recent message)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Pet owner name
                      Text(
                        personName,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackColor,
                          fontSize: size.width * 0.05,
                          fontFamily: "NunitoSans",
                        ),
                      ),

                      /// Recent message (or "Update Soon" if empty)
                      Text(
                        recentMessage.isEmpty ? "Update Soon" : recentMessage,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.subTitleColor,
                          fontSize: size.width * 0.04,
                          fontFamily: "NunitoSans",
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              /// Recent chat indication number
              if (recentMessageIndication > 0)
                Container(
                  height: size.height * 0.06,
                  width: size.width * 0.06,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      recentMessageIndication.toString(),
                      style: TextStyle(
                        fontFamily: "NunitoSans",
                        fontSize: size.width * 0.03,
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
