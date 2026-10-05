import 'package:flutter/material.dart';

import 'LoginPage.dart';

// Pastikan file HomePage.dart dan halaman lainnya sudah Anda pindahkan ke folder lib/ di repo baru ini

void main() {
  runApp(const QurbanApp());
}

class QurbanApp extends StatelessWidget {
  const QurbanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QurbanKu',
      debugShowCheckedModeBanner:
          false, // Menghilangkan pita merah "DEBUG" di kanan atas
      theme: ThemeData(
        // Tema utama aplikasi disesuaikan dengan hijau gelap QurbanKu
        primaryColor: const Color(0xFF0F5A38),
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F5A38),
          primary: const Color(0xFF0F5A38),
        ),
        useMaterial3: true, // Menggunakan desain UI Flutter terbaru
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF0F5A38)),
        ),
      ),
      home: const LoginPage(), // Halaman pertama yang dibuka adalah LoginPage
    );
  }
}
