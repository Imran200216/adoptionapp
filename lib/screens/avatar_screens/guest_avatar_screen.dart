import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/user_details_providers/guest_avatar_provider.dart';
import 'package:adoptionapp/screens/nick_name_screens/guest_nick_name_screen.dart';
import 'package:adoptionapp/widgets/custom_icon_btn.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GuestAvatarScreen extends StatefulWidget {
  const GuestAvatarScreen({super.key});

  @override
  State<GuestAvatarScreen> createState() => _GuestAvatarScreenState();
}

class _GuestAvatarScreenState extends State<GuestAvatarScreen> {
 void initState() {
    super.initState();
    // Fetch avatars when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userGuestDetailsProvider =
      Provider.of<GuestUserDetailsProvider>(context, listen: false);
      if (userGuestDetailsProvider.imageUrls.isEmpty) {
        userGuestDetailsProvider.fetchAvatars();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userGuestDetailsProvider =
    Provider.of<GuestUserDetailsProvider>(context);

    return DoubleTapToExit(
      snackBar: SnackBar(
        backgroundColor: AppColors.secondaryColor,
        content: Text(
          "Tag again to exit!",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: size.width * 0.040,
            color: AppColors.secondaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          bottomSheet: userGuestDetailsProvider.isAvatarUpdated
              ? Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.zero,
              color: AppColors.primaryColor,
            ),
            child: CustomIconBtn(
              btnHeight: size.height * 0.06,
              btnWidth: size.width,
              btnText: "All Set, Let's Go!",
              btnBorderRadius: 4,
              btnOnTap: () {
                /// moving to the next screen
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
          )
              : const SizedBox(),
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
                Text(
                  "Add Cool Avatars\nfor your profile",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: size.width * 0.060,
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Center(
                  child: DottedBorder(
                    borderType: BorderType.Circle,
                    dashPattern: const [6, 6],
                    color: Colors.grey.shade200,
                    strokeWidth: 2,
                    child: Container(
                      width: size.width * 0.42,
                      height: size.width * 0.42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: userGuestDetailsProvider.selectedAvatarURL !=
                              null
                              ? CachedNetworkImageProvider(
                              userGuestDetailsProvider.selectedAvatarURL!)
                              : const AssetImage(
                              "assets/images/png/avatar-bg-img.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                userGuestDetailsProvider.imageUrls.isEmpty
                    ? Center(
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.02),
                      Lottie.asset(
                        'assets/images/animation/empty-animation.json',
                        height: size.height * 0.3,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                )
                    : Expanded(
                  child: GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1,
                    ),
                    itemCount:
                    userGuestDetailsProvider.imageUrls.length,
                    itemBuilder: (context, index) {
                      final avatarUrl =
                      userGuestDetailsProvider.imageUrls[index];

                      return InkWell(
                        onTap: () {
                          userGuestDetailsProvider.setSelectedAvatar(
                              avatarUrl, context);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: avatarUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child:
                                LoadingAnimationWidget.dotsTriangle(
                                  color: AppColors.secondaryColor,
                                  size: 40,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(
                                    Icons.error,
                                    color: AppColors.secondaryColor,
                                  ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.08),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
