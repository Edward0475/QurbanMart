import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'SearchPage.dart';
import 'Favorite.dart'; // Sesuaikan jika nama file Anda FavoritePage.dart
import 'OrderPage.dart';
import 'SaldoQurbanPage.dart';
import 'SettingsPage.dart';
import 'AddressPage.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // Warna Utama
  static const Color _primaryGreen = Color(
    0xFF166036,
  ); // Hijau menyesuaikan gambar
  static const Color _backgroundColor = Color(
    0xFFFAFAFA,
  ); // Latar belakang abu sangat muda

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
                // 1. HEADER (Custom App Bar)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.account_circle_outlined,
                            size: 28,
                            color: Color(0xFF222222),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Akun Saya',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF222222),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsPage(),
                            ),
                          );
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.settings_outlined,
                          color: Color(0xFF222222),
                        ),
                      ),
                    ],
                  ),
                ),

                // ISI HALAMAN (Bisa di-scroll)
                Expanded(
                  child: SingleChildScrollView(
                    // Padding bawah 120 ditambahkan agar konten tidak tertutup bottom nav
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 2. PROFIL PENGGUNA (Mengikuti desain gambar)
                        _buildProfileHeader(),
                        const SizedBox(height: 20),

                        // 3. KARTU TABUNGAN KURBAN (Warna Hijau)
                        _buildTabunganCard(),
                        const SizedBox(height: 24),

                        // 4. TARGET TABUNGAN CARD
                        const Text(
                          'Target Tabungan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF222222),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildTargetTabunganCard(),
                        const SizedBox(height: 24),

                        // 5. MENU BAWAH
                        _buildMenuList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // --- BOTTOM NAVIGATION BAR MENGAMBANG (KONSISTEN & TIDAK DIRUBAH) ---
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
  // KOMPONEN UI SESUAI DESAIN GAMBAR
  // ============================================================

  // --- Bagian Profil ---
  Widget _buildProfileHeader() {
    return Row(
      children: [
        // Avatar Lingkaran
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade200,
            image: const DecorationImage(
              // Pastikan Anda menaruh foto profil di folder Asset jika ingin tampil,
              // Jika tidak, ini akan otomatis fallback ke warna abu-abu
              image: AssetImage('Asset/image/profile.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: const Icon(Icons.person, color: Colors.grey, size: 35),
        ),
        const SizedBox(width: 16),
        // Nama dan Email
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edward Jeremy Panjaitan',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'edward@gmail.com',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    );
  }

  // --- Bagian Kartu Tabungan Kurban (Hijau) ---
  Widget _buildTabunganCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _primaryGreen,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _primaryGreen.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tabungan Kurban Anda',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              // Lingkaran Persentase
              SizedBox(
                width: 75,
                height: 75,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: 0.45,
                      strokeWidth: 7,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                    const Center(
                      child: Text(
                        '45%',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              // Nominal dan Tombol
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Rp 11.250.000 ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: '/ Rp 25.000.000',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Terkumpul',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Tombol Atur Target
                    SizedBox(
                      height: 32,
                      child: OutlinedButton(
                        onPressed: () {
                          // Tetap terhubung ke Halaman Saldo Qurban
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SaldoQurbanPage(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                        ),
                        child: const Text(
                          'Atur Target & Nabung',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Bagian Kartu Target (Sapi) ---
  Widget _buildTargetTabunganCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Gambar Sapi
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'Asset/image/Sapi.png', // Sesuai path gambar Anda
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 70,
                height: 70,
                color: Colors.grey.shade200,
                child: const Icon(Icons.image, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Deskripsi Target
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sapi 25 Juta',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Rp 2.000.000/bulan',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                const SizedBox(height: 10),
                // Linear Progress
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: 0.45,
                          minHeight: 6,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF22C55E),
                          ), // Hijau cerah
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '45%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Mulai: Jan 2025 • 12 bulan',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Bagian Menu List (Riwayat, dsb) ---
  Widget _buildMenuList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuTile(
            icon: Icons.receipt_long_outlined,
            title: 'Riwayat Transaksi',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrderPage()),
              );
            },
          ),
          Divider(height: 1, color: Colors.grey.shade100, indent: 50),
          _buildMenuTile(
            icon: Icons.lock_outline,
            title: 'Metode Pembayaran',
            onTap: () {}, // Dummy
          ),
          Divider(height: 1, color: Colors.grey.shade100, indent: 50),
          _buildMenuTile(
            icon: Icons.location_on_outlined,
            title: 'Alamat Saya',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddressPage()),
              );
            },
          ),
          Divider(height: 1, color: Colors.grey.shade100, indent: 50),
          // Tambahan tombol favorit agar fungsinya tidak hilang
          _buildMenuTile(
            icon: Icons.favorite_border_rounded,
            title: 'Hewan Favorit',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritePage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Icon(icon, color: const Color(0xFF475569), size: 24),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF334155),
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Color(0xFFCBD5E1),
        size: 22,
      ),
      onTap: onTap,
    );
  }

  // ============================================================
  // NAVIGATION BOTTOM NAV (TIDAK DIRUBAH)
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
