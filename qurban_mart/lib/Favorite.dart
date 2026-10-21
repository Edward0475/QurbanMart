import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'SearchPage.dart';
import 'OrderPage.dart';
import 'AccountPage.dart';
import 'FavoriteManager.dart'; // Mengambil data hewan yang difavoritkan
import 'AnimalPageDetail.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  static const Color _primaryGreen = Color(0xFF166036);
  static const Color _bgColor = Color(0xFFFCFDF9);
  final int _selectedIndex = 2; // Index 2 untuk halaman Favorit

  int _activeTab = 0; // 0: Peternak, 1: Hewan

  // Dummy Data Peternak Favorit (Sesuai Gambar)
  final List<Map<String, dynamic>> _peternakFavorit = [
    {
      'name': 'Sumber Rezeki Farm',
      'rating': '4.8',
      'reviews': '120 ulasan',
      'location': 'Bandung, Jawa Barat',
      'image': 'Asset/image/Bali.png', // Ganti dengan asset Anda
    },
    {
      'name': 'Barokah Livestock',
      'rating': '4.7',
      'reviews': '98 ulasan',
      'location': 'Cianjur, Jawa Barat',
      'image': 'Asset/image/Boer.png', // Ganti dengan asset Anda
    },
    {
      'name': 'Maju Bersama Farm',
      'rating': '4.6',
      'reviews': '76 ulasan',
      'location': 'Garut, Jawa Barat',
      'image': 'Asset/image/Domba.png', // Ganti dengan asset Anda
    },
    {
      'name': 'Rizky Farm',
      'rating': '4.5',
      'reviews': '54 ulasan',
      'location': 'Sumedang, Jawa Barat',
      'image': 'Asset/image/Sapi.png', // Ganti dengan asset Anda
    },
  ];

  // Fungsi Navigasi Bawah
  void _navigateTo(Widget page) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil data hewan yang sudah di-love dari FavoriteManager
    final List<Map<String, dynamic>> hewanFavorit =
        FavoriteManager.favoriteList;

    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _bgColor,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF1E293B),
            size: 20,
          ),
          onPressed: () {
            // SOLUSI TOMBOL BACK: Memaksa kembali ke HomePage dan menghapus riwayat Onboarding
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false,
            );
          },
        ),
        title: const Text(
          'Favorit Saya',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
      ),
      body: Stack(
        children: [
          // ==========================================
          // KONTEN UTAMA
          // ==========================================
          Column(
            children: [
              const SizedBox(height: 12),
              // --- 1. TOGGLE TAB (Peternak / Hewan) ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFFF1F5F9,
                    ), // Warna abu-abu muda background tab
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: _buildTabButton('Peternak', 0)),
                      Expanded(child: _buildTabButton('Hewan', 1)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // --- 2. LIST KONTEN ---
              Expanded(
                child: _activeTab == 0
                    ? _buildPeternakList() // Tampilkan Peternak
                    : _buildHewanList(
                        hewanFavorit,
                      ), // Tampilkan Hewan dari FavoriteManager
              ),
            ],
          ),

          // ==========================================
          // BOTTOM NAVIGATION BAR (MODEL LAMA)
          // ==========================================
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
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
                    Icons.favorite,
                    'Favorit',
                    2,
                  ), // Ikon Favorite aktif (Penuh)
                  _buildBottomNavItem(
                    Icons.receipt_long_outlined,
                    'Pesanan',
                    3,
                  ),
                  _buildBottomNavItem(Icons.person_outline, 'Akun', 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET TOGGLE TAB ---
  Widget _buildTabButton(String title, int index) {
    bool isActive = _activeTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeTab = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isActive ? _primaryGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey.shade600,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // --- LIST PETERNAK FAVORIT ---
  Widget _buildPeternakList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        24,
        0,
        24,
        120,
      ), // Padding bawah agar tidak tertutup nav bar
      physics: const BouncingScrollPhysics(),
      itemCount: _peternakFavorit.length,
      itemBuilder: (context, index) {
        final peternak = _peternakFavorit[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200, width: 0.8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.015),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Gambar Peternak (Bentuk Bulat Sesuai Desain)
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(peternak['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Info Peternak
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      peternak['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          peternak['rating'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${peternak['reviews']})',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.grey.shade400,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            peternak['location'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Ikon Love Merah
              IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Color(0xFFEF4444),
                  size: 24,
                ),
                onPressed: () {
                  // Fitur hapus peternak dari favorit (bisa ditambahkan nanti)
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // --- LIST HEWAN FAVORIT (Menggunakan Data Asli FavoriteManager) ---
  Widget _buildHewanList(List<Map<String, dynamic>> favList) {
    if (favList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 60, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text(
              'Belum ada hewan favorit',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Hewan yang Anda sukai akan muncul di sini.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
      physics: const BouncingScrollPhysics(),
      itemCount: favList.length,
      itemBuilder: (context, index) {
        final animal = favList[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AnimalDetailPage(animal: animal),
              ),
            ).then((_) => setState(() {}));
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200, width: 0.8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.015),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    animal['image'] ?? 'Asset/image/Sapi.png',
                    width: 65,
                    height: 65,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stack) => Container(
                      width: 65,
                      height: 65,
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        animal['name'] ?? 'Hewan',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        animal['price'] ?? '-',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: Color(0xFFEF4444),
                    size: 24,
                  ),
                  onPressed: () {
                    setState(() {
                      FavoriteManager.toggleFavorite(animal);
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- WIDGET NAVIGASI BAWAH ---
  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        if (isSelected) return;
        switch (index) {
          case 0:
            _navigateTo(const HomePage());
            break;
          case 1:
            _navigateTo(const SearchPage());
            break;
          case 2:
            return; // Sudah di halaman Favorite
          case 3:
            _navigateTo(const OrderPage());
            break;
          case 4:
            _navigateTo(const AccountPage());
            break;
        }
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
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? _primaryGreen : Colors.grey.shade400,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
