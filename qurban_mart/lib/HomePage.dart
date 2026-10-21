import 'package:flutter/material.dart';

import 'AccountPage.dart';
import 'OrderPage.dart';
import 'Favorite.dart';
import 'SearchPage.dart';
import 'NotificationPage.dart';
import 'FarmDetailPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color _primaryGreen = const Color(0xFF1B5E20);
  final int _selectedIndex = 0;

  // Data dummy peternak
  final List<Map<String, dynamic>> _peternakList = [
    {
      'name': 'Sumber Rezeki Farm',
      'rating': '4.8',
      'reviews': '120 ulasan',
      'location': 'Bandung, Jawa Barat',
      'image': 'Asset/image/Bali.png',
    },
    {
      'name': 'Barokah Livestock',
      'rating': '4.7',
      'reviews': '98 ulasan',
      'location': 'Cianjur, Jawa Barat',
      'image': 'Asset/image/Boer.png',
    },
    {
      'name': 'Maju Bersama Farm',
      'rating': '4.6',
      'reviews': '76 ulasan',
      'location': 'Garut, Jawa Barat',
      'image': 'Asset/image/Domba.png',
    },
  ];

  // Navigasi dengan transisi tanpa animasi
  void _navigateTo(Widget page) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: Duration.zero,
      ),
    );
  }

  // Membuka halaman notifikasi tanpa mengganti halaman Home
  void _openNotifications() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const NotificationPage(),
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Stack(
        children: [
          // KONTEN UTAMA
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. HEADER
                Container(
                  padding: const EdgeInsets.only(
                    top: 60,
                    left: 24,
                    right: 24,
                    bottom: 10,
                  ),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('Asset/image/QurbanMart.png', height: 40),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'QurbanMart',
                                style: TextStyle(
                                  color: _primaryGreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const Text(
                                'Berkah untuk Semua',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // IKON NOTIFIKASI
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_none,
                          color: Colors.black87,
                          size: 28,
                        ),
                        onPressed: _openNotifications,
                        tooltip: 'Notifikasi',
                      ),
                    ],
                  ),
                ),

                // 2. BANNER
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: _buildAestheticBanner('Asset/image/Bannersapi.png'),
                ),

                // 3. SEARCH BAR
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  child: GestureDetector(
                    onTap: () => _navigateTo(const SearchPage()),
                    child: Container(
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.grey.shade500,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Cari hewan, paket aqiqah...',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 4. KATEGORI KURBAN
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Kategori Kurban',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: _primaryGreen,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCategoryItem('Asset/image/logoSapi.jpeg', 'Sapi'),
                      _buildCategoryItem(
                        'Asset/image/logoKambing.jpeg',
                        'Kambing',
                      ),
                      _buildCategoryItem('Asset/image/logoDomba.jpeg', 'Domba'),
                      _buildCategoryItem(
                        'Asset/image/logoSapi.jpeg',
                        'Patungan\nSapi 1/7',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // 5. KATEGORI AQIQAH
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kategori Aqiqah',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: _primaryGreen,
                        ),
                      ),
                      Text(
                        'Lihat Semua >',
                        style: TextStyle(
                          fontSize: 13,
                          color: _primaryGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildAqiqahCard(
                          'Asset/image/Kambinghidup.png',
                          'Kambing Hidup',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildAqiqahCard(
                          'Asset/image/Siapsaji.png',
                          'Paket Siap Saji',
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // 6. PETERNAK TERFAVORIT
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Peternak Terfavorit',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: _primaryGreen,
                        ),
                      ),
                      Text(
                        'Lihat Semua >',
                        style: TextStyle(
                          fontSize: 13,
                          color: _primaryGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _peternakList.length,
                  itemBuilder: (context, index) {
                    return _buildPeternakCard(_peternakList[index]);
                  },
                ),
              ],
            ),
          ),

          // BOTTOM NAVIGATION
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
                  _buildBottomNavItem(Icons.home, 'Home', 0),
                  _buildBottomNavItem(Icons.search_outlined, 'Search', 1),
                  _buildBottomNavItem(Icons.favorite_border, 'Favorit', 2),
                  _buildBottomNavItem(Icons.receipt_long, 'Order', 3),
                  _buildBottomNavItem(Icons.person_outline, 'Akun', 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET BANNER
  Widget _buildAestheticBanner(String imagePath) {
    return AspectRatio(
      aspectRatio: 16 / 7,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _primaryGreen,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // WIDGET KATEGORI KURBAN
  Widget _buildCategoryItem(String imagePath, String title) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F8F1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Image.asset(imagePath, fit: BoxFit.contain),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // WIDGET KARTU AQIQAH
  Widget _buildAqiqahCard(String imagePath, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.asset(
              imagePath,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET KARTU PETERNAK
  // WIDGET KARTU PETERNAK
  Widget _buildPeternakCard(Map<String, dynamic> peternak) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail peternak dengan membawa data 'peternak'
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FarmDetailPage(peternak: peternak),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        // ... sisa kodingan isi kartu Anda (Row, Image, Column teks) tidak perlu diubah ...
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                peternak['image'],
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    peternak['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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
                          fontSize: 11,
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
                            color: Colors.grey.shade500,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // NAVIGASI BAWAH
  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        if (isSelected) return;

        switch (index) {
          case 0:
            return;
          case 1:
            _navigateTo(const SearchPage());
            break;
          case 2:
            _navigateTo(const FavoritePage());
            break;
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
