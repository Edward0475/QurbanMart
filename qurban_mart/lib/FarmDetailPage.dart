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
  final TextEditingController _reviewController = TextEditingController();
  int _selectedRating = 5;

  // Data unik per seller (Banner, Avatar, Deskripsi, Produk, dan Ulasan)
  final Map _sellerDatabase = {
    'Berkah Farmer': {
      'banner': 'Asset/image/Berkah.jpg',
      'avatar': 'Asset/image/Bali.png',
      'about': 'Peternakan sapi unggulan asal Bandung dengan pakan hijauan alami dan pengawasan dokter hewan rutin. Semua sapi sudah  dilengkapi sertifikat bebas PMK.',
      'products': [
        {
          'name': 'Sapi Limousin Super',
          'weight': '450 kg',
          'price': 'Rp 24.500.000',
          'image': 'Asset/image/Sapi.png',
        },
        {
          'name': 'kambimng Boer',
          'weight': '330 kg',
          'price': 'Rp 19.500.000',
          'image': 'Asset/image/Boer.jpg',
        },
        {
          'name': 'Sapi Brahman Cross',
          'weight': '± 350 kg',
          'price': 'Rp 3.100.000',
          'image': 'Asset/image/Brahman.jpeg',
        },
      ],
      'reviews': [
        {
          'user': 'Ahmad Fauzi',
          'rating': 5,
          'date': '2 hari lalu',
          'comment': 'Sapinya sehat, bobot sesuai deskripsi, dan pengiriman tepat waktu ke Bandung.',
        },
        {
          'user': 'Rina Kartika',
          'rating': 5,
          'date': '1 minggu lalu',
          'comment': 'Admin ramah, dikirimi video kondisi sapi sebelum dikirim. Sangat amanah.',
        },
      ],
    },
    'Barokah Livestock': {
      'banner': 'Asset/image/Kurbanmu.png',
      'avatar': 'Asset/image/Boer.png',
      'about': 'Spesialis kambing kurban dan paket aqiqah higienis di Cianjur. Menyediakan kambing hidup maupun paket olahan siap saji sesuai syariat.',
      'products': [
        {
          'name': 'Kambing Boer Premium',
          'weight': '42 kg',
          'price': 'Rp 4.800.000',
          'image': 'Asset/image/Boer.png',
        },
        {
          'name': 'Kambing Etawa Jantan',
          'weight': '38 kg',
          'price': 'Rp 4.500.000',
          'image': 'Asset/image/Etawa.jpeg',
        },
        {
          'name': 'Paket Aqiqah Siap Saji',
          'weight': '50 Box',
          'price': 'Rp 3.200.000',
          'image': 'Asset/image/Siapsaji.png',
        },
      ],
      'reviews': [
        {
          'user': 'Dimas Pratama',
          'rating': 5,
          'date': '3 hari lalu',
          'comment': 'Kambing Boer-nya gemuk dan tidak bau prengus. Rekomendasi buat kurban!',
        },
        {
          'user': 'Siti Nurhaliza',
          'rating': 4,
          'date': '2 minggu lalu',
          'comment': 'Paket aqiqah siap sajinya enak dan porsinya pas untuk acara keluarga.',
        },
      ],
    },
    'Maju Bersama Farm': {
      'banner': 'Asset/image/Tree.png',
      'avatar': 'Asset/image/Domba.png',
      'about': 'Peternakan domba Garut pilihan langsung dari peternak lokal. Perawatan intensif di dataran tinggi menghasilkan ternak yang sehat dan lincah.',
      'products': [
        {
          'name': 'Domba Garut Tanduk',
          'weight': '40 kg',
          'price': 'Rp 4.200.000',
          'image': 'Asset/image/Domba.png',
        },
        {
          'name': 'Domba Ekor Gemuk',
          'weight': '35 kg',
          'price': 'Rp 3.600.000',
          'image': 'Asset/image/Kambing.png',
        },
        {
          'name': 'Domba Aqiqah Sehat',
          'weight': '28 kg',
          'price': 'Rp 2.900.000',
          'image': 'Asset/image/Domba.png',
        },
      ],
      'reviews': [
        {
          'user': 'Hendra Wijaya',
          'rating': 5,
          'date': '5 hari lalu',
          'comment': 'Domba Garutnya gagah dan sehat. Surat keterangan kesehatannya lengkap.',
        },
        {
          'user': 'Nadia Putri',
          'rating': 5,
          'date': '3 minggu lalu',
          'comment': 'Proses titip salurkan sangat transparan, dapat foto & video penyembelihan.',
        },
      ],
    },
    'Rizky Farm': {
      'banner': 'Asset/image/Bannersapi.png',
      'avatar': 'Asset/image/Sapi.png',
      'about': 'Mitra peternak terpercaya di Sumedang yang menyediakan berbagai pilihan sapi dan domba berkualitas dengan harga transparan.',
      'products': [
        {
          'name': 'Sapi Brahman Cross',
          'weight': '410 kg',
          'price': 'Rp 22.800.000',
          'image': 'Asset/image/Sapi.png',
        },
        {
          'name': 'Kambing Jawa Randu',
          'weight': '34 kg',
          'price': 'Rp 3.400.000',
          'image': 'Asset/image/Kambing.png',
        },
      ],
      'reviews': [
        {
          'user': 'Budi Santoso',
          'rating': 5,
          'date': '1 minggu lalu',
          'comment': 'Pelayanan cepat dan ramah, harga bersahabat langsung dari kandang.',
        },
      ],
    },
  };

  late Map _currentSellerData;
  final List _hewanTersedia = [];
  final List _ulasanList = [];

  @override
  void initState() {
    super.initState();
    final String sellerName = widget.peternak['name'] ?? '';
    _currentSellerData =
        _sellerDatabase[sellerName] ??
        {
          'banner': 'Asset/image/Bannersapi.png',
          'avatar': widget.peternak['image'] ?? 'Asset/image/Bali.png',
          'about': 'Peternakan sapi dan kambing sehat dengan standar kesehatan tinggi. Semua hewan kami dilengkapi sertifikat bebas PMK.',
          'products': [
            {
              'name': 'Sapi Limousin',
              'weight': '420 kg',
              'price': 'Rp 24.500.000',
              'image': 'Asset/image/Sapi.png',
            },
            {
              'name': 'Kambing Etawa',
              'weight': '38 kg',
              'price': 'Rp 4.500.000',
              'image': 'Asset/image/Kambinghidup.png',
            },
          ],
          'reviews': [
            {
              'user': 'Pelanggan QurbanMart',
              'rating': 5,
              'date': 'Baru saja',
              'comment':
                  'Hewan sehat, terawat, dan pelayanan peternak sangat amanah.',
            },
          ],
        };

    _hewanTersedia.addAll(_currentSellerData['products'] as List);
    _ulasanList.addAll(_currentSellerData['reviews'] as List);
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _tambahUlasan() {
    if (_reviewController.text.trim().isEmpty) return;
    setState(() {
      _ulasanList.insert(0, {
        'user': 'Anda (Pengunjung)',
        'rating': _selectedRating,
        'date': 'Baru saja',
        'comment': _reviewController.text.trim(),
      });
      _reviewController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final String bannerImage = _currentSellerData['banner'];
    final String avatarImage =
        widget.peternak['image'] ?? _currentSellerData['avatar'];
    final String aboutText = _currentSellerData['about'];

    return Scaffold(
      backgroundColor: _bgColor,
      body: Stack(
        children: [
          // KONTEN UTAMA
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- 1. HEADER (BANNER & AVATAR UNIK PER SELLER) ---
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(bannerImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
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
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 8,
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage(avatarImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),

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
                                const Icon(
                                  Icons.location_on,
                                  color: _primaryGreen,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    widget.peternak['location'],
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                      _buildTabItem('Ulasan (${_ulasanList.length})', 1),
                      _buildTabItem('Produk (${_hewanTersedia.length})', 2),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- 4. KONTEN TAB 0: TENTANG ---
                if (_activeTab == 0) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      aboutText,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                  _buildProductGrid(),
                ],

                // --- 5. KONTEN TAB 1: ULASAN LANGSUNG ---
                if (_activeTab == 1) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tulis Ulasan Langsung',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: List.generate(5, (index) {
                              return GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedRating = index + 1),
                                child: Icon(
                                  index < _selectedRating
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                  size: 24,
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _reviewController,
                                  decoration: InputDecoration(
                                    hintText:
                                        'Bagikan pengalamanmu dengan ${widget.peternak['name']}...',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: _tambahUlasan,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _primaryGreen,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Kirim',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _ulasanList.length,
                    itemBuilder: (context, index) {
                      final item = _ulasanList[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['user'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                Text(
                                  item['date'],
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: List.generate(
                                item['rating'],
                                (_) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item['comment'],
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],

                // --- 6. KONTEN TAB 2: DAFTAR PRODUK ---
                if (_activeTab == 2) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Daftar Produk ${widget.peternak['name']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildProductGrid(),
                ],
              ],
            ),
          ),

          // --- 7. TOMBOL HUBUNGI PETERNAK ---
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Menghubungi ${widget.peternak['name']}...',
                      ),
                      backgroundColor: _primaryGreen,
                    ),
                  );
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
                  shadowColor: _primaryGreen.withValues(alpha: 0.4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.80,
      ),
      itemCount: _hewanTersedia.length,
      itemBuilder: (context, index) {
        return _buildAnimalCard(_hewanTersedia[index]);
      },
    );
  }

  // WIDGET BANTUAN UNTUK TAB
  Widget _buildTabItem(String title, int index) {
    bool isActive = _activeTab == index;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? _primaryGreen : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey.shade600,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
            fontSize: 12,
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
  Widget _buildAnimalCard(dynamic animal) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF1E293B),
                  ),
                ),
                if (animal['weight'] != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Estimasi: ${animal['weight']}',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  ),
                ],
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
