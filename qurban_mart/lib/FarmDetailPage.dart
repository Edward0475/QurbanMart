import 'package:flutter/material.dart';

class FarmDetailPage extends StatefulWidget {
  final Map<String, dynamic> peternak;

  const FarmDetailPage({super.key, required this.peternak});

  @override
  State<FarmDetailPage> createState() => _FarmDetailPageState();
}

class _FarmDetailPageState extends State<FarmDetailPage> {
  static const Color _primaryGreen = Color(0xFF166036);
  static const Color _bgColor = Color(0xFFFCFDF9);

  int _activeTab = 0; // 0: Tentang, 1: Ulasan, 2: Produk

  // Dummy data hewan yang dijual peternak ini
  final List<Map<String, dynamic>> _hewanTersedia = [
    {
      'name': 'Sapi Limousin',
      'price': 'Rp 24.500.000',
      'image': 'Asset/image/Sapi.png',
    },
    {
      'name': 'Kambing Etawa',
      'price': 'Rp 4.500.000',
      'image': 'Asset/image/Kambinghidup.png', // Sesuaikan dengan asset Anda
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: Stack(
        children: [
          // KONTEN UTAMA
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              bottom: 100,
            ), // Ruang untuk tombol bawah
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- 1. HEADER (BANNER & AVATAR) ---
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Banner Image
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'Asset/image/Bannersapi.png',
                          ), // Gunakan banner default
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Tombol Back Floating
                    Positioned(
                      top: 50,
                      left: 20,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    // Foto Profil (Avatar) Peternak
                    Positioned(
                      bottom: -40,
                      left: 24,
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage(
                              widget.peternak['image'] ??
                                  'Asset/image/Bali.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50), // Jarak setelah avatar meluap
                // --- 2. INFO PETERNAK ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.peternak['name'],
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.peternak['rating'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '(${widget.peternak['reviews']})',
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: _primaryGreen,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.peternak['location'],
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Badge Peternak Terpercaya
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE6F4EA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.verified,
                              color: _primaryGreen,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Peternak Terpercaya',
                              style: TextStyle(
                                color: _primaryGreen,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- 3. TAB MENU (Tentang, Ulasan, Produk) ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTabItem('Tentang', 0),
                      _buildTabItem('Ulasan (120)', 1),
                      _buildTabItem('Produk', 2),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- 4. KONTEN TAB (TENTANG) ---
                if (_activeTab == 0) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Peternakan sapi dan kambing sehat dengan standar kesehatan tinggi. Semua hewan kami dilengkapi sertifikat bebas PMK dan siap untuk ibadah Qurban maupun Aqiqah Anda.',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Badges Layanan
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _buildServiceBadge(
                          Icons.health_and_safety,
                          'Bebas PMK',
                        ),
                        _buildServiceBadge(
                          Icons.local_shipping,
                          'Pengiriman Aman',
                        ),
                        _buildServiceBadge(
                          Icons.handshake,
                          'Mitra Terverifikasi',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // --- 5. HEWAN TERSEDIA ---
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Hewan Tersedia',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio:
                              0.85, // Menyesuaikan proporsi kartu gambar
                        ),
                    itemCount: _hewanTersedia.length,
                    itemBuilder: (context, index) {
                      return _buildAnimalCard(_hewanTersedia[index]);
                    },
                  ),
                ],
              ],
            ),
          ),

          // --- 6. TOMBOL HUBUNGI PETERNAK (BOTTOM NAV) ---
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Aksi hubungi peternak (bisa dialihkan ke ChatPage)
                },
                icon: const Icon(Icons.person, color: Colors.white),
                label: const Text(
                  'Hubungi Peternak',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                  shadowColor: _primaryGreen.withOpacity(0.4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET BANTUAN UNTUK TAB
  Widget _buildTabItem(String title, int index) {
    bool isActive = _activeTab == index;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? _primaryGreen : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey.shade600,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  // WIDGET BANTUAN UNTUK BADGE (Bebas PMK, dll)
  Widget _buildServiceBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFBF7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _primaryGreen, size: 14),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF334155),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET KARTU HEWAN TERSEDIA
  Widget _buildAnimalCard(Map<String, dynamic> animal) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.asset(
                animal['image'],
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, stack) => Container(
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  animal['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  animal['price'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: _primaryGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
