import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/user_details_providers/guest_avatar_provider.dart';
import 'package:adoptionapp/screens/nick_name_screens/guest_nick_name_screen.dart';
import 'package:adoptionapp/widgets/custom_icon_btn.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GuestAvatarScreen extends StatelessWidget {
  const GuestAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DoubleTapToExit(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.secondaryColor,
          bottomSheet: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.zero,
              color: AppColors.secondaryColor,
            ),
            child: CustomIconBtn(
              btnHeight: size.height * 0.06,
              btnWidth: size.width,
              btnText: "Next",
              btnBorderRadius: 4,
              btnOnTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const GuestNickNameScreen();
                }));
              },
              btnIcon: Icons.navigate_next_outlined,
              btnColor: AppColors.primaryColor,
              btnTextColor: AppColors.secondaryColor,
              btnIconColor: AppColors.secondaryColor,
            ),
          ),
          body: Consumer<GuestAvatarProvider>(
            builder: (
              context,
              guestAvatarProvider,
              child,
            ) {
              return SingleChildScrollView(
                child: Container(
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
                        textAlign: TextAlign.start,
                        'Add Cool Avatars',
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: size.width * 0.060,
                          color: AppColors.blackColor,
                          fontFamily: "NunitoSans",
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      AutoSizeText(
                        textAlign: TextAlign.start,
                        'Personalize your profile by choosing from a collection of unique avatars. Stand out with fun and expressive icons that match your style.',
                        maxLines: 4,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: size.width * 0.042,
                          color: AppColors.subTitleColor,
                          fontFamily: "NunitoSans",
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),

                      // Avatar placeholder
                      SizedBox(
                        height: size.height * 0.4,
                        width: size.width,
                        child: DottedBorder(
                          color: Colors.grey.shade400,
                          strokeWidth: 1.2,
                          dashPattern: const [8, 4],
                          borderType: BorderType.Circle,
                          radius: const Radius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade200,
                            ),
                            child: Center(
                              child:
                                  guestAvatarProvider.selectedAvatarUrl != null
                                      ? CachedNetworkImage(
                                          imageUrl: guestAvatarProvider
                                              .selectedAvatarUrl!,
                                          height: size.height * 0.4,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              LoadingAnimationWidget
                                                  .threeRotatingDots(
                                            color: AppColors.primaryColor,
                                            size: size.width * 0.03,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              SvgPicture.asset(
                                            "assets/images/svg/add-person-icon.svg",
                                            height: size.height * 0.28,
                                            fit: BoxFit.cover,
                                            color: Colors.grey.shade300,
                                          ),
                                        )
                                      : SvgPicture.asset(
                                          "assets/images/svg/add-person-icon.svg",
                                          height: size.height * 0.28,
                                          fit: BoxFit.cover,
                                          color: Colors.grey.shade300,
                                        ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.06),

                      // Cool avatars list
                      SizedBox(
                        height: size.height * 0.09,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: guestAvatarProvider.imageUrls.length,
                          itemBuilder: (context, index) {
                            final avatarUrl =
                                guestAvatarProvider.imageUrls[index];
                            return InkWell(
                              onTap: () {
                                guestAvatarProvider.setSelectedAvatar(
                                  avatarUrl,
                                ); // Set the selected avatar URL
                              },
                              child: Container(
                                height: size.height * 0.09,
                                width: size.width * 0.2,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade200,
                                  image: DecorationImage(
                                    image:
                                        CachedNetworkImageProvider(avatarUrl),
                                    // Use CachedNetworkImageProvider
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: size.width * 0.02,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
