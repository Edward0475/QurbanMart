import 'package:flutter/material.dart';

import 'HomePage.dart'; // Sesuaikan jika Anda menggunakan home_page.dart
import 'SearchPage.dart';
import 'Favorite.dart';
import 'OrderPage.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // Warna Utama agar konsisten
  static const Color _primaryGreen = Color(0xFF1B5E20);
  static const Color _backgroundColor = Color(0xFFF8F9F7);

  final int _selectedIndex = 4; // Index 4 Aktif untuk halaman Akun

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // --- KONTEN UTAMA ---
            Column(
              children: [
                // HEADER
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Akun Saya',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ),
                ),

                // ISI HALAMAN (Bisa di-scroll)
                Expanded(
                  child: SingleChildScrollView(
                    // Padding bawah ditambahkan agar list tidak tertutup bottom nav
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. KARTU PROFIL PENGGUNA
                        _buildProfileCard(),
                        const SizedBox(height: 24),

                        // 2. BAGIAN AKTIVITAS
                        const Text(
                          'Aktivitas',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF222222),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildMenuSection([
                          _buildMenuItem(
                            Icons.account_balance_wallet_outlined,
                            'Saldo qurban',
                            trailingText: '0 Poin',
                          ),
                          _buildMenuItem(
                            Icons.receipt_long_outlined,
                            'Riwayat Pesanan',
                          ),
                          _buildMenuItem(
                            Icons.favorite_border_rounded,
                            'Hewan Favorit',
                          ),
                        ]),
                        const SizedBox(height: 24),

                        // 3. BAGIAN PENGATURAN
                        const Text(
                          'Pengaturan Akun',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF222222),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildMenuSection([
                          _buildMenuItem(Icons.person_outline, 'Edit Profil'),
                          _buildMenuItem(
                            Icons.location_on_outlined,
                            'Alamat Tersimpan',
                          ),
                          _buildMenuItem(
                            Icons.shield_outlined,
                            'Keamanan & Kata Sandi',
                          ),
                          _buildMenuItem(Icons.help_outline, 'Pusat Bantuan'),
                        ]),
                        const SizedBox(height: 24),

                        // 4. TOMBOL KELUAR
                        _buildMenuSection([
                          _buildMenuItem(
                            Icons.logout,
                            'Keluar',
                            isLogout: true,
                          ),
                        ]),
                      ],
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
                    _buildBottomNavItem(Icons.receipt_long, 'Order', 3),
                    _buildBottomNavItem(Icons.person, 'Akun', 4), // Aktif
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
  // KOMPONEN UI KUSTOM
  // ============================================================

  // Kartu Profil
  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              shape: BoxShape.circle,
              border: Border.all(
                color: _primaryGreen.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
            child: const Icon(Icons.person, size: 35, color: _primaryGreen),
          ),
          const SizedBox(width: 16),
          // Info Pengguna
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Haikal', // Dummy Name
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '0812-3456-7890',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
                Text(
                  'haikal@example.com',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          // Tombol Edit
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_square, color: _primaryGreen, size: 22),
          ),
        ],
      ),
    );
  }

  // Wadah Putih untuk List Menu
  Widget _buildMenuSection(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  // Baris Menu Individual
  Widget _buildMenuItem(
    IconData icon,
    String title, {
    bool isLogout = false,
    String? trailingText,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isLogout ? Colors.red.shade50 : const Color(0xFFF1F8F1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isLogout ? Colors.red : _primaryGreen,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isLogout ? Colors.red : const Color(0xFF333333),
        ),
      ),
      trailing: trailingText != null
          ? Text(
              trailingText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: _primaryGreen,
              ),
            )
          : const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onTap: () {
        // Aksi ketika menu ditekan
      },
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
            nextScreen = const FavoritePage();
            break;
          case 3:
            nextScreen = const OrderPage();
            break;
          case 4:
            return; // Sudah di halaman Akun
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
