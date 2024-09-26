import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/auth_providers/email_auth_provider.dart';
import 'package:adoptionapp/provider/auth_providers/guest_auth_provider.dart';
import 'package:adoptionapp/provider/screen_provider/get_started_provider.dart';
import 'package:adoptionapp/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
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
          create: (_) => EmailAuthProvider(),
        ),

        /// guest authentication provider
        ChangeNotifierProvider(
          create: (_) => GuestAuthProvider(),
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
