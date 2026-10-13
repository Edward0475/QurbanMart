import 'package:flutter/material.dart';

import 'HomePage.dart'; // Sesuaikan jika Anda menggunakan home_page.dart
import 'SearchPage.dart';
import 'OrderPage.dart';
import 'AccountPage.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  // Warna Utama agar konsisten dengan HomePage & OrderPage
  static const Color _primaryGreen = Color(0xFF1B5E20);
  static const Color backgroundColor = Color(0xFFF8F9F7);

  final int _selectedIndex = 2; // Index 2 Aktif untuk halaman Favorit

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // --- KONTEN UTAMA ---
            Column(
              children: [
                // HEADER
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 18),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Favorit Saya',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ),
                ),
                // EMPTY STATE
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 24,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 180,
                            height: 180,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE7F5EB),
                              shape: BoxShape.circle,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                const Icon(
                                  Icons.favorite_rounded,
                                  size: 100,
                                  color: Color(0xFFB8DEC5),
                                ),
                                Container(
                                  width: 66,
                                  height: 66,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.favorite_border_rounded,
                                    color: _primaryGreen,
                                    size: 38,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 28),
                          const Text(
                            'Belum ada favorit',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF222222),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Simpan hewan kurban yang kamu sukai '
                            'dengan menekan ikon hati. '
                            'Kamu bisa melihatnya kembali di sini.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.6,
                              color: Color(0xFF777777),
                            ),
                          ),
                          const SizedBox(height: 26),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const SearchPage(),
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
                                  Icon(Icons.search_rounded, size: 21),
                                  SizedBox(width: 8),
                                  Text(
                                    'Jelajahi Hewan Kurban',
                                    style: TextStyle(
                                      fontSize: 14,
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

            // --- BOTTOM NAVIGATION BAR MENGAMBANG (KONSISTEN) ---
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
                      color: Colors.black.withOpacity(0.1),
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
                    _buildBottomNavItem(
                      Icons.favorite_border,
                      'Favorit',
                      2,
                    ), // Aktif
                    _buildBottomNavItem(Icons.receipt_long, 'Order', 3),
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

  // ============================================================
  // NAVIGATION BOTTOM NAV
  // ============================================================
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
            return; // Sudah di halaman Favorit
          case 3:
            nextScreen = const OrderPage();
            break;
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
