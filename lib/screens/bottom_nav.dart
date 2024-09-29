import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/screen_provider/bottom_nav_provider.dart';
import 'package:adoptionapp/screens/bottom_nav_screens/add_screen.dart';
import 'package:adoptionapp/screens/bottom_nav_screens/chat_screen.dart';
import 'package:adoptionapp/screens/bottom_nav_screens/favorite_screen.dart';
import 'package:adoptionapp/screens/bottom_nav_screens/home_screen.dart';
import 'package:adoptionapp/screens/bottom_nav_screens/profile_screen.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  /// Bottom navigation bar screens
  final List<Widget> widgetList = [
    const HomeScreen(),
    const FavoriteScreen(),
    const AddScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<BottomNavProvider>(
      builder: (context, bottomNavProvider, child) {
        return WillPopScope(
          onWillPop: () async {
            if (bottomNavProvider.currentIndex != 0) {
              // If not on the first screen, go to the previous screen
              bottomNavProvider.setIndex(0);
              return false;
            } else {
              // Allow the app to be popped (exit) if already on the first screen
              return true;
            }
          },
          child: DoubleTapToExit(
            snackBar: SnackBar(
              backgroundColor: AppColors.blackColor,
              content: Text(
                "Tap again to exit!",
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

                /// Bottom navigation bar
                bottomNavigationBar: BottomNavigationBar(
                  onTap: (index) {
                    HapticFeedback.heavyImpact();
                    bottomNavProvider.setIndex(index);
                  },
                  backgroundColor: AppColors.primaryColor,
                  currentIndex: bottomNavProvider.currentIndex,
                  selectedItemColor: AppColors.primaryColor,
                  unselectedItemColor: AppColors.subTitleColor,
                  unselectedLabelStyle: TextStyle(
                    fontFamily: "NunitoSans",
                    fontWeight: FontWeight.w600,
                    color: AppColors.subTitleColor,
                  ),
                  selectedLabelStyle: TextStyle(
                    fontFamily: "NunitoSans",
                    fontSize: size.width * 0.040,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryColor,
                  ),
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/images/svg/home-icon.svg',
                        color: bottomNavProvider.currentIndex == 0
                            ? AppColors.primaryColor
                            : AppColors.subTitleColor,
                        height: 30,
                        width: 30,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/images/svg/favorite-icon.svg',
                        color: bottomNavProvider.currentIndex == 1
                            ? AppColors.primaryColor
                            : AppColors.subTitleColor,
                        height: 26,
                        width: 26,
                        fit: BoxFit.cover,
                      ),
                      label: 'Favorites',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/images/svg/add-icon.svg',
                        color: bottomNavProvider.currentIndex == 2
                            ? AppColors.primaryColor
                            : AppColors.subTitleColor,
                        height: 34,
                        width: 34,
                        fit: BoxFit.cover,
                      ),
                      label: 'Add',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/images/svg/chat-icon.svg',
                        color: bottomNavProvider.currentIndex == 3
                            ? AppColors.primaryColor
                            : AppColors.subTitleColor,
                        height: 30,
                        width: 30,
                        fit: BoxFit.cover,
                      ),
                      label: 'Chats',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/images/svg/profile-icon.svg',
                        color: bottomNavProvider.currentIndex == 4
                            ? AppColors.primaryColor
                            : AppColors.subTitleColor,
                        height: 30,
                        width: 30,
                        fit: BoxFit.cover,
                      ),
                      label: 'Profile',
                    ),
                  ],
                ),

                body: IndexedStack(
                  index: bottomNavProvider.currentIndex,
                  children: widgetList,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
