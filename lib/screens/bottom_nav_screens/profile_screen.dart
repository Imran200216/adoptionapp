import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/constants/textStyles.dart';
import 'package:adoptionapp/provider/app_required_providers/app_version_provider.dart';
import 'package:adoptionapp/provider/app_required_providers/in_app_review_provider.dart';
import 'package:adoptionapp/provider/app_required_providers/share_app_provider.dart';
import 'package:adoptionapp/provider/auth_providers/email_auth_provider.dart';
import 'package:adoptionapp/provider/auth_providers/guest_auth_provider.dart';
import 'package:adoptionapp/provider/user_details_providers/email_avatar_provider.dart';
import 'package:adoptionapp/provider/user_details_providers/guest_avatar_provider.dart';
import 'package:adoptionapp/screens/permission_screen/notification_permission_screen.dart';
import 'package:adoptionapp/screens/profile_sub_screens/app_information_screen.dart';
import 'package:adoptionapp/screens/profile_sub_screens/edit_profile_screen.dart';
import 'package:adoptionapp/widgets/custom_list_tile.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// to identify the current user
    final user = FirebaseAuth.instance.currentUser;

    // Fetch guest user details when the widget is built
    if (user != null && user.isAnonymous) {
      Provider.of<GuestUserDetailsProvider>(context, listen: false)
          .fetchGuestUserDetails();
    } else {
      Provider.of<EmailUserDetailsProvider>(context, listen: false)
          .fetchEmailUserDetails();
    }

    /// media query
    final size = MediaQuery.of(context).size;

    /// share provider
    final shareProvider = Provider.of<ShareProvider>(context, listen: false);

    return Scaffold(
      body: Consumer6<
          EmailAuthenticationProvider,
          GuestAuthenticationProvider,
          EmailUserDetailsProvider,
          GuestUserDetailsProvider,
          AppVersionProvider,
          InAppReviewProvider>(
        builder: (
          context,
          emailAuthProvider,
          guestAuthProvider,
          emailUserDetailsProvider,
          guestUserDetailsProvider,
          appVersionProvider,
          inAppReviewProvider,
          child,
        ) {
          /// Fetch correct user data based on sign-in method
          final avatarUrl = user!.isAnonymous
              ? guestUserDetailsProvider.avatarPhotoURL
              : emailUserDetailsProvider.avatarPhotoURL;

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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: AutoSizeText(
                      "My Profile",
                      style: CustomTextStyles.profileTitleText(context),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  AvatarGlow(
                    startDelay: const Duration(microseconds: 1000),
                    repeat: true,
                    glowRadiusFactor: 0.12,
                    child: Material(
                      elevation: 0.1,
                      shape: const CircleBorder(),
                      color: AppColors.primaryColor,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.16,
                        width: MediaQuery.of(context).size.height * 0.16,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: avatarUrl ??
                                "https://imgs.search.brave.com/G7EAKN2_tgpXRvp6SG9UP-WdSrIotMa3XzzGAZ29UCo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAwLzIzLzcyLzU5/LzM2MF9GXzIzNzI1/OTQ0X1cyYVNyZzNL/cXczbE9tVTRJQW43/aVhWODhSbm5mY2gx/LmpwZw",
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  user.isAnonymous
                      ? Text(
                          guestUserDetailsProvider.nickname ?? "No User",
                          style: CustomTextStyles.profileTitleText(context),
                        )
                      : Text(
                          user.displayName ?? "No User",
                          style: CustomTextStyles.profileTitleText(context),
                        ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),

                  user.isAnonymous
                      ? const SizedBox.shrink()
                      : Text(
                          user.email ?? "No email Address",
                          style: CustomTextStyles.profileSubTitleText(context),
                        ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),

                  /// edit screen
                  CustomListTile(
                    listTileOnTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const EditProfileScreen();
                      }));
                    },
                    leadingListTilePath: "edit-icon",
                    leadingListTileBgColor: AppColors.listLeadingBgColor,
                    listTileText: "Edit Profile",
                  ),

                  SizedBox(
                    height: size.height * 0.03,
                  ),

                  /// app icon screen
                  CustomListTile(
                    listTileOnTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const AppInformationScreen();
                      }));
                    },
                    leadingListTilePath: "app-icon",
                    leadingListTileBgColor: AppColors.listLeadingBgColor,
                    listTileText: "App Information",
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),

                  /// app invite functionality
                  CustomListTile(
                    listTileOnTap: () async {
                      await shareProvider.shareAppLink(context);
                    },
                    leadingListTilePath: "invite-icon",
                    leadingListTileBgColor: AppColors.listLeadingBgColor,
                    listTileText: "Invite Friends To Adopt",
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),

                  /// rating
                  CustomListTile(
                    listTileOnTap: () {
                      /// ratings functionality must be added
                      inAppReviewProvider.triggerInAppReview(context);
                    },
                    leadingListTilePath: "rating-icon",
                    leadingListTileBgColor: AppColors.listLeadingBgColor,
                    listTileText: "Rate Our ReHome",
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),

                  /// allow notification functionality screen
                  CustomListTile(
                    listTileOnTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const NotificationPermissionScreen();
                      }));
                    },
                    leadingListTilePath: "notification-icon",
                    leadingListTileBgColor: AppColors.listLeadingBgColor,
                    listTileText: "Allow Notification",
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),

                  /// logout
                  user.isAnonymous
                      ? CustomListTile(
                          listTileOnTap: () {
                            /// logout functionality of guest
                            guestAuthProvider.signOutWithGuest(context);
                          },
                          leadingListTilePath: "logout-icon",
                          leadingListTileBgColor:
                              AppColors.primaryLightShapeColor,
                          listTileText: "Logout",
                        )
                      : CustomListTile(
                          listTileOnTap: () {
                            /// logout functionality of email
                            emailAuthProvider.signOutWithEmail(context);
                          },
                          leadingListTilePath: "logout-icon",
                          leadingListTileBgColor:
                              AppColors.primaryLightShapeColor,
                          listTileText: "Logout",
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
