import 'package:flutter/material.dart';

import 'HomePage.dart'; // Sesuaikan jika Anda menggunakan home_page.dart
import 'SearchPage.dart';
import 'Favorite.dart';
import 'AccountPage.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // Warna disesuaikan dengan tema utama QurbanMart
  static const Color _primaryGreen = Color(0xFF1B5E20);
  static const Color backgroundColor = Color(0xFFF8F9F7);
  final int _selectedIndex = 3; // Index untuk halaman Order/Pesanan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // --- HEADER ---
                // --- HEADER ---
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                  child: Row(
                    children: [
                      InkWell(
                        // --- BAGIAN YANG DIUBAH ---
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (
                                context,
                                animation,
                                secondaryAnimation,
                              ) => const HomePage(),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );
                        },
                        // --------------------------
                        borderRadius: BorderRadius.circular(20),
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 20,
                            color: Color(0xFF222222),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        'Pesanan Saya',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF222222),
                        ),
                      ),
                    ],
                  ),
                ),
                // --- EMPTY STATE (KOSONG) ---
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ILUSTRASI
                          Container(
                            width: 190,
                            height: 190,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE7F5EB),
                              shape: BoxShape.circle,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                const Icon(
                                  Icons.receipt_long_rounded,
                                  size: 100,
                                  color: Color(0xFFB8DEC5),
                                ),
                                Positioned(
                                  bottom: 15,
                                  right: 15,
                                  child: Container(
                                    width: 65,
                                    height: 65,
                                    decoration: const BoxDecoration(
                                      color: _primaryGreen,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.shopping_bag_outlined,
                                      size: 32,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 28),
                          const Text(
                            'Belum ada pesanan',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF222222),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Kamu belum memiliki pesanan kurban. \nYuk, temukan hewan kurban terbaik \nuntuk ibadahmu!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.6,
                              color: Color(0xFF777777),
                            ),
                          ),
                          const SizedBox(height: 26),
                          // TOMBOL MULAI BELANJA
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SearchPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _primaryGreen,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.shopping_bag_outlined, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'Mulai Belanja',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // --- BOTTOM NAVIGATION BAR MENGAMBANG (KONSISTEN DENGAN HOMEPAGE) ---
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBottomNavItem(Icons.home_outlined, 'Home', 0),
                    _buildBottomNavItem(Icons.search_outlined, 'Search', 1),
                    _buildBottomNavItem(Icons.favorite_border, 'Favorit', 2),
                    _buildBottomNavItem(
                      Icons.receipt_long,
                      'Order',
                      3,
                    ), // Index 3 Aktif
                    _buildBottomNavItem(Icons.person_outline, 'Akun', 4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- FUNGSI NAVIGASI BAWAH YANG SAMA PERSIS DENGAN HOMEPAGE ---
  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        if (isSelected) return;
        Widget nextScreen;
        switch (index) {
          case 0:
            nextScreen = const HomePage();
            break;
          case 1:
            nextScreen = const SearchPage();
            break;
          case 2:
            nextScreen = const FavoritePage();
            break;
          case 3:
            return; // Sudah di halaman Order
          case 4:
            nextScreen = const AccountPage();
            break;
          default:
            return;
        }
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      child: Container(
        color: Colors.transparent,
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? _primaryGreen : Colors.grey.shade400,
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? _primaryGreen : Colors.grey.shade400,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
