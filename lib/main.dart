import 'package:adoptionapp/constants/colors.dart';
import 'package:adoptionapp/provider/get_started_provider.dart';
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
        ],
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryColor,
              ),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
          );
        });
  }
}
