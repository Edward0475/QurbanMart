import 'package:flutter/material.dart';
import 'package:qurban_mart/OnboardingPage.dart';

import 'onboardingPage.dart';

void main() {
  runApp(const QurbanMartApp());
}

class QurbanMartApp extends StatelessWidget {
  const QurbanMartApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QurbanMart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1B5E20), // Hijau utama
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto', // Sesuaikan dengan font pilihan Anda
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1B5E20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: const OnboardingPage(),
    );
  }
}
