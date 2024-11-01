import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/user_details_providers/email_avatar_provider.dart';
import 'package:adoptionapp/screens/nick_name_screens/email_nick_name_screen.dart';
import 'package:adoptionapp/widgets/custom_icon_btn.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class EmailAvatarScreen extends StatefulWidget {
  const EmailAvatarScreen({super.key});

  @override
  State<EmailAvatarScreen> createState() => _EmailAvatarScreenState();
}

class _EmailAvatarScreenState extends State<EmailAvatarScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch avatars when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userEmailDetailsProvider =
          Provider.of<EmailUserDetailsProvider>(context, listen: false);
      if (userEmailDetailsProvider.imageUrls.isEmpty) {
        userEmailDetailsProvider.fetchAvatars();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userEmailDetailsProvider =
        Provider.of<EmailUserDetailsProvider>(context);

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
          backgroundColor: AppColors.secondaryColor,
          bottomSheet: userEmailDetailsProvider.isAvatarUpdated
              ? userEmailDetailsProvider.isLoading
                  ? LoadingAnimationWidget.discreteCircle(
                      color: AppColors.primaryColor,
                      size: size.width * 0.06,
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.zero,
                        color: AppColors.secondaryColor,
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
                            return const EmailNickNameScreen();
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// title
                AutoSizeText(
                  textAlign: TextAlign.start,
                  'Set up your profile',
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: size.width * 0.060,
                    color: AppColors.blackColor,
                    fontFamily: "NunitoSans",
                  ),
                ),
                SizedBox(height: size.height * 0.01),

                /// sub title
                AutoSizeText(
                  textAlign: TextAlign.start,
                  'Add a cool avatars to make the profile more awesome and fun!',
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: size.width * 0.040,
                    color: AppColors.subTitleColor,
                    fontFamily: "NunitoSans",
                  ),
                ),

                SizedBox(height: size.height * 0.02),
                Center(
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    dashPattern: const [6, 6],
                    color: Colors.grey.shade500,
                    radius: const Radius.circular(12),
                    strokeWidth: 2,
                    child: Container(
                      width: size.width,
                      height: size.height * 0.40,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.grey.shade400,
                        image: DecorationImage(
                          image: userEmailDetailsProvider.selectedAvatarURL !=
                                  null
                              ? CachedNetworkImageProvider(
                                  userEmailDetailsProvider.selectedAvatarURL!)
                              : const NetworkImage(
                                  "https://imgs.search.brave.com/G7EAKN2_tgpXRvp6SG9UP-WdSrIotMa3XzzGAZ29UCo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAwLzIzLzcyLzU5/LzM2MF9GXzIzNzI1/OTQ0X1cyYVNyZzNL/cXczbE9tVTRJQW43/aVhWODhSbm5mY2gx/LmpwZw",
                                ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                userEmailDetailsProvider.imageUrls.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            SizedBox(height: size.height * 0.02),
                            Lottie.asset(
                              'assets/lotties/empty-animation.json',
                              height: size.height * 0.03,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          // Horizontal scrolling
                          itemCount: userEmailDetailsProvider.imageUrls.length,
                          itemBuilder: (context, index) {
                            final avatarUrl =
                                userEmailDetailsProvider.imageUrls[index];

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: InkWell(
                                onTap: () {
                                  userEmailDetailsProvider.setSelectedAvatar(
                                    avatarUrl,
                                    context,
                                  );
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: size.width * 0.38,
                                      height: size.height * 0.20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          imageUrl: avatarUrl,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Center(
                                            child: LoadingAnimationWidget
                                                .threeArchedCircle(
                                              color: AppColors.primaryColor,
                                              size: size.width * 0.06,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(
                                            Icons.error,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: size.width * 0.04,
                            ); // Adds space between the items
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
