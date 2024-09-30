import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/app_required_providers/notification_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Consumer<NotificationProvider>(
          builder: (
            context,
            notificationProvider,
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
                    IconButton(
                      onPressed: () {
                        HapticFeedback.heavyImpact();
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: size.height * 0.04,
                        color: AppColors.subTitleColor,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SvgPicture.asset(
                      "assets/images/svg/notification.svg",
                      height: size.height * 0.42,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    AutoSizeText(
                      textAlign: TextAlign.start,
                      'Turn on Notifications',
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: size.width * 0.064,
                        color: AppColors.blackColor,
                        fontFamily: "NunitoSans",
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    AutoSizeText(
                      textAlign: TextAlign.start,
                      'This way you will notify when the pet are posted for adoption.',
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.040,
                        color: const Color(0xFF70778C),
                        fontFamily: "NunitoSans",
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Container(
                      height: size.height * 0.10,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: const Color(0xFFEDF1F5),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AutoSizeText(
                            textAlign: TextAlign.start,
                            'Turn on notification',
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * 0.044,
                              color: const Color(0xFF646883),
                              fontFamily: "NunitoSans",
                            ),
                          ),

                          /// switch functionality if the switch is on it should allow notification
                          Switch.adaptive(
                            value: notificationProvider.isNotificationEnabled,
                            onChanged: (value) {
                              // Pass the current context to show the toast notification
                              notificationProvider.toggleNotification(
                                value,
                                context,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
