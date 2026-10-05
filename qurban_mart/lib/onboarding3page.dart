import 'package:flutter/material.dart';

import 'Homepage.dart'; // Menghubungkan ke file Homepage.dart

// Menghubungkan ke homepage.dart sesuai instruksi Anda
//import 'homepage.dart';

class Onboarding3Page extends StatelessWidget {
  const Onboarding3Page({super.key});

  // Menggunakan warna hijau utama
  final Color _primaryGreen = const Color(0xFF38683A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              // 1. Judul Halaman (Title)
              Text(
                'QurbanMart',
                style: TextStyle(
                  fontFamily: 'ABeeZee',
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: _primaryGreen,
                ),
              ),
              const SizedBox(height: 20),

              // 2. Sub-judul / Deskripsi (Subtitle)
              Text(
                'Pengiriman hingga Lokasi tujuan\ntersedia layanan pengiriman atau pembelian langsung di peternakan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'ABeeZee',
                  fontSize: 22,
                  color: _primaryGreen,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),

              // 3. Gambar (Location)
              Expanded(
                child: Center(
                  child: Image.asset(
                    'Asset/image/Loc.png',
                    fit: BoxFit.contain,
                    height: 250,
                  ),
                ),
              ),

              // 4. Indikator Halaman (Dots) - Titik KETIGA yang aktif
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDot(isActive: false), // Titik pertama kosong
                  const SizedBox(width: 8),
                  _buildDot(isActive: false), // Titik kedua kosong
                  const SizedBox(width: 8),
                  _buildDot(isActive: true), // Titik ketiga terisi
                ],
              ),
              const SizedBox(height: 40),

              // 5. Tombol Selesai / Mulai (Menuju HomePage)
              ElevatedButton(
                onPressed: () {
                  // Navigasi ke HomePage diaktifkan di sini
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryGreen,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Mulai Sekarang', // Teks diubah agar sesuai dengan halaman terakhir
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Widget bantuan untuk membuat bulatan indikator halaman (Dots)
  Widget _buildDot({required bool isActive}) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: isActive ? _primaryGreen : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: _primaryGreen, width: 1.5),
      ),
    );
  }
}
