import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/firebase_options.dart';
import 'package:adoptionapp/provider/add_post_provider/add_pet_to_firestore_provider.dart';
import 'package:adoptionapp/provider/app_required_providers/carousel_provider.dart';
import 'package:adoptionapp/provider/app_required_providers/internet_checker_provider.dart';
import 'package:adoptionapp/provider/app_required_providers/phone_call_provider.dart';
import 'package:adoptionapp/provider/auth_providers/guest_auth_provider.dart';
import 'package:adoptionapp/provider/auth_providers/password_visibility_provider.dart';
import 'package:adoptionapp/provider/user_details_providers/email_avatar_provider.dart';
import 'package:adoptionapp/provider/app_required_providers/notification_provider.dart';
import 'package:adoptionapp/provider/auth_providers/email_auth_provider.dart';
import 'package:adoptionapp/provider/screen_provider/bottom_nav_provider.dart';
import 'package:adoptionapp/provider/screen_provider/get_started_provider.dart';
import 'package:adoptionapp/provider/user_details_providers/guest_avatar_provider.dart';
import 'package:adoptionapp/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// get started provider
        ChangeNotifierProvider(
          create: (_) => GetStartedProvider(),
        ),

        /// email authentication provider
        ChangeNotifierProvider(
          create: (_) => EmailAuthenticationProvider(),
        ),

        /// password visibility provider
        ChangeNotifierProvider(
          create: (_) => PasswordVisibilityProvider(),
        ),

        /// guest authentication provider
        ChangeNotifierProvider(
          create: (_) => GuestAuthenticationProvider(),
        ),

        /// bottom nav provider
        ChangeNotifierProvider(
          create: (_) => BottomNavProvider(),
        ),

        /// notification provider
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(),
        ),

        /// guest avatar provider
        ChangeNotifierProvider(
          create: (_) => GuestUserDetailsProvider(),
        ),

        /// email avatar provider
        ChangeNotifierProvider(
          create: (_) => EmailUserDetailsProvider(),
        ),

        /// add pet to firebase provider
        ChangeNotifierProvider(
          create: (_) => AddPetToFireStoreProvider(),
        ),

        /// carousel provider
        ChangeNotifierProvider(
          create: (_) => CarouselProvider(),
        ),

        /// internet checker provider
        ChangeNotifierProvider(
          create: (_) => InternetCheckerProvider(),
        ),

        /// phone call provider
        ChangeNotifierProvider(
          create: (_) => PhoneCallProvider(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryColor,
            ),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
