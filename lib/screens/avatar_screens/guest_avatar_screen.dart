import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/app_required_providers/guest_avatar_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GuestAvatarScreen extends StatefulWidget {
  const GuestAvatarScreen({super.key});

  @override
  _GuestAvatarScreenState createState() => _GuestAvatarScreenState();
}

class _GuestAvatarScreenState extends State<GuestAvatarScreen> {
  String? _selectedAvatarUrl;

  @override
  void initState() {
    super.initState();
    // Fetch avatars when the screen is initialized
    Future.microtask(() =>
        Provider.of<GuestAvatarProvider>(context, listen: false)
            .fetchAvatars());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Consumer<GuestAvatarProvider>(
          builder: (
            context,
            guestAvatarProvider,
            child,
          ) {
            return Container(
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
                    'Add Avatars',
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: size.width * 0.062,
                      color: AppColors.blackColor,
                      fontFamily: "NunitoSans",
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  // Display selected avatar or placeholder
                  Container(
                    height: size.height * 0.40,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade200,
                    ),
                    child: Center(
                      child: _selectedAvatarUrl == null
                          ? SvgPicture.asset(
                              "assets/images/svg/add-person-icon.svg",
                              height: size.height * 0.30,
                              fit: BoxFit.cover,
                              color: AppColors.subTitleColor,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: _selectedAvatarUrl!,
                                height: size.height * 0.40,
                                width: size.width,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    LoadingAnimationWidget.discreteCircle(
                                  color: AppColors.primaryColor,
                                  size: size.width * 0.08,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  // Check if loading
                  guestAvatarProvider.isLoading
                      ? Center(
                          child: LoadingAnimationWidget.discreteCircle(
                            color: AppColors.primaryColor,
                            size: size.width * 0.04,
                          ),
                        )
                      : Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: guestAvatarProvider.imageUrls.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(width: size.width * 0.04),
                            // Add space between avatars
                            itemBuilder: (context, index) {
                              String avatarUrl =
                                  guestAvatarProvider.imageUrls[index];

                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedAvatarUrl = avatarUrl;
                                  });

                                  // Set the selected avatar and update Firestore
                                  guestAvatarProvider.setSelectedAvatar(
                                      avatarUrl, context);
                                },
                                child: Container(
                                  width: size.width * 0.20, // Set avatar size
                                  height: size.width * 0.20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: _selectedAvatarUrl == avatarUrl
                                          ? AppColors
                                              .primaryColor // Highlight selected avatar
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: avatarUrl,
                                      placeholder: (context, url) =>
                                          LoadingAnimationWidget.discreteCircle(
                                        color: AppColors.primaryColor,
                                        size: size.width * 0.08,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
