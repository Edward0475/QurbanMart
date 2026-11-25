import 'package:flutter/material.dart';

import 'TransactionPage.dart';
import 'ChatPage.dart';
import 'Favorite.dart';

class AnimalDetailPage extends StatefulWidget {
  final Map<String, dynamic> animal;

  const AnimalDetailPage({super.key, required this.animal});

  @override
  State<AnimalDetailPage> createState() => _AnimalDetailPageState();
}

class _AnimalDetailPageState extends State<AnimalDetailPage> {
  static const Color _primaryGreen = Color(0xFF166036);
  static const Color _lightGreen = Color(0xFFE6F4EA);
  static const Color _bgColor = Color(0xFFF8FAF8);

  late final PageController _pageController;
  int _selectedPhoto = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showFullImage(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.92),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Stack(
            alignment: Alignment.center,
            children: [
              InteractiveViewer(
                minScale: 0.8,
                maxScale: 4.0,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.pets, size: 100, color: Colors.white),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 12,
                right: 20,
                child: Material(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: const CircleBorder(),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectPhoto(int index) {
    setState(() {
      _selectedPhoto = index;
    });
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final animal = widget.animal;
    final String mainImage = (animal['image'] ?? 'Asset/image/Sapi.png')
        .toString();

    final List<String> photoList =
        (animal['images'] is List && (animal['images'] as List).isNotEmpty)
        ? (animal['images'] as List).map((e) => e.toString()).toList()
        : [mainImage];

    final int currentIndex = _selectedPhoto < photoList.length
        ? _selectedPhoto
        : 0;
    final String activeImage = photoList[currentIndex];

    final String name = (animal['name'] ?? 'Sapi Limousin').toString();
    final String price = (animal['price'] ?? 'Rp 24.500.000').toString();
    final String weight = (animal['weight'] ?? '350 kg').toString();
    final String age = (animal['age'] ?? '2 tahun').toString();
    final String location = (animal['location'] ?? 'Bogor, Jawa Barat')
        .toString();
    final String category = (animal['category'] ?? 'Sapi').toString();
    final String breed =
        (animal['breed'] ?? (category == 'Sapi' ? 'Sapi Limousin' : name))
            .toString();
    final String sellerName = (animal['seller'] ?? 'Peternakan Berkah')
        .toString();
    final String ratingValue = (animal['rating'] ?? '4.8').toString();
    final String reviewsValue = (animal['reviews'] ?? '120 ulasan').toString();
    final String description =
        (animal['description'] ??
                'Hewan kurban dalam kondisi sehat, nafsu makan baik, dan perawatan rutin. Cocok untuk ibadah kurban dengan kualitas yang terjaga.')
            .toString();

    final double topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: _bgColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- 1. HERO GALLERY FOTO HEWAN ---
                  Stack(
                    children: [
                      SizedBox(
                        height: 340 + topPadding * 0.4,
                        width: double.infinity,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: photoList.length,
                          onPageChanged: (index) {
                            setState(() {
                              _selectedPhoto = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () =>
                                  _showFullImage(context, photoList[index]),
                              child: Image.asset(
                                photoList[index],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: _lightGreen,
                                    child: const Icon(
                                      Icons.pets_rounded,
                                      size: 90,
                                      color: _primaryGreen,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      // Gradasi atas & bawah agar ikon dan indikator kontras
                      Positioned.fill(
                        child: IgnorePointer(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withValues(alpha: 0.42),
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.35),
                                ],
                                stops: const [0.0, 0.28, 0.72, 1.0],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Bar Navigasi Atas (Kembali, Favorit, Bagikan)
                      Positioned(
                        top: topPadding + 10,
                        left: 18,
                        right: 18,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _roundIcon(
                              Icons.arrow_back_ios_new_rounded,
                              () => Navigator.pop(context),
                            ),
                            Row(
                              children: [
                                _roundIcon(Icons.favorite_border_rounded, () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const FavoritePage(),
                                    ),
                                  );
                                }, color: const Color(0xFFE53935)),
                                const SizedBox(width: 10),
                                _roundIcon(Icons.share_outlined, () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Fitur berbagi akan segera tersedia.',
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Tombol Perbesar & Nomor Foto
                      Positioned(
                        left: 18,
                        right: 18,
                        bottom: 34,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => _showFullImage(context, activeImage),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.55),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.2),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.fullscreen_rounded,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Lihat Penuh',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 11,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.55),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${currentIndex + 1} / ${photoList.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // --- 2. KONTEN UTAMA (OVERLAP ROUNDED SHEET) ---
                  Transform.translate(
                    offset: const Offset(0, -20),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: _bgColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Thumbnail Galeri jika foto > 1
                          if (photoList.length > 1) ...[
                            SizedBox(
                              height: 62,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: photoList.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 10),
                                itemBuilder: (context, index) {
                                  final bool isSelected = currentIndex == index;
                                  return GestureDetector(
                                    onTap: () => _selectPhoto(index),
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      width: 72,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: isSelected
                                              ? _primaryGreen
                                              : Colors.grey.shade300,
                                          width: isSelected ? 2.2 : 1,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          photoList[index],
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(
                                                    Icons.pets,
                                                    color: _primaryGreen,
                                                  ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 18),
                          ],

                          // Badge Kategori, Verifikasi, dan Rating
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _lightGreen,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  category,
                                  style: const TextStyle(
                                    color: _primaryGreen,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.verified_rounded,
                                size: 16,
                                color: _primaryGreen,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'Terverifikasi',
                                style: TextStyle(
                                  color: _primaryGreen,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.amber.withValues(alpha: 0.14),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star_rounded,
                                      size: 15,
                                      color: Color(0xFFF59E0B),
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      '$ratingValue ($reviewsValue)',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF334155),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Nama Hewan & Harga
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A),
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            price,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: _primaryGreen,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Termasuk sertifikat kesehatan & perawatan hingga pengiriman',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(height: 18),

                          // --- 3. KARTU RINGKASAN 3 KOLOM ---
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade200),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.02),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildHighlightItem(
                                    icon: Icons.scale_rounded,
                                    label: 'Estimasi Bobot',
                                    value: weight,
                                  ),
                                ),
                                _buildVerticalDivider(),
                                Expanded(
                                  child: _buildHighlightItem(
                                    icon: Icons.access_time_filled_rounded,
                                    label: 'Usia Ternak',
                                    value: age,
                                  ),
                                ),
                                _buildVerticalDivider(),
                                Expanded(
                                  child: _buildHighlightItem(
                                    icon: Icons.health_and_safety_rounded,
                                    label: 'Kesehatan',
                                    value: 'Bebas PMK',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),

                          // --- 4. KARTU INFORMASI PETERNAK ---
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade200),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.02),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    const CircleAvatar(
                                      radius: 23,
                                      backgroundColor: _lightGreen,
                                      child: Icon(
                                        Icons.agriculture_rounded,
                                        color: _primaryGreen,
                                        size: 24,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF22C55E),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              sellerName,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 14,
                                                color: Color(0xFF0F172A),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          const Icon(
                                            Icons.verified_rounded,
                                            size: 14,
                                            color: _primaryGreen,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_rounded,
                                            size: 13,
                                            color: Colors.grey.shade500,
                                          ),
                                          const SizedBox(width: 3),
                                          Expanded(
                                            child: Text(
                                              location,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 11.5,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                OutlinedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChatPage(animal: animal),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.chat_bubble_outline_rounded,
                                    size: 15,
                                  ),
                                  label: const Text(
                                    'Chat',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: _primaryGreen,
                                    backgroundColor: _lightGreen.withValues(
                                      alpha: 0.35,
                                    ),
                                    side: const BorderSide(
                                      color: _primaryGreen,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 13,
                                      vertical: 8,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),

                          // --- 5. KARTU DETAIL SPESIFIKASI ---
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Spesifikasi Hewan',
                                  style: TextStyle(
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 14),
                                _detailRow(
                                  Icons.pets_outlined,
                                  'Jenis / Ras',
                                  breed,
                                ),
                                _detailRow(
                                  Icons.category_outlined,
                                  'Kategori',
                                  category,
                                ),
                                _detailRow(
                                  Icons.scale_outlined,
                                  'Estimasi Berat',
                                  weight,
                                ),
                                _detailRow(
                                  Icons.access_time_rounded,
                                  'Usia',
                                  age,
                                ),
                                _detailRow(
                                  Icons.health_and_safety_outlined,
                                  'Status Kesehatan',
                                  'Sehat & Bebas PMK',
                                ),
                                _detailRow(
                                  Icons.location_on_outlined,
                                  'Lokasi Kandang',
                                  location,
                                  isLast: true,
                                ),
                                const SizedBox(height: 14),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    _buildServiceBadge(
                                      Icons.verified_user_rounded,
                                      'Sesuai Syariat',
                                    ),
                                    _buildServiceBadge(
                                      Icons.local_shipping_rounded,
                                      'Pengiriman Aman',
                                    ),
                                    _buildServiceBadge(
                                      Icons.videocam_rounded,
                                      'Cek Video Sebelum Kirim',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),

                          // --- 6. KARTU DESKRIPSI HEWAN ---
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Deskripsi Lengkap',
                                  style: TextStyle(
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  description,
                                  style: TextStyle(
                                    fontSize: 13,
                                    height: 1.6,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
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

          // --- 7. BOTTOM ACTION BAR ---
          Container(
            padding: EdgeInsets.fromLTRB(
              20,
              12,
              20,
              MediaQuery.of(context).padding.bottom + 14,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(animal: animal),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.chat_bubble_outline_rounded,
                        size: 18,
                      ),
                      label: const Text(
                        'Chat Penjual',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _primaryGreen,
                        side: const BorderSide(
                          color: _primaryGreen,
                          width: 1.4,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TransactionPage(animal: animal),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_bag_outlined, size: 19),
                      label: const Text(
                        'Pesan Sekarang',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.5,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryGreen,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _roundIcon(
    IconData icon,
    VoidCallback onTap, {
    Color color = const Color(0xFF1E293B),
  }) {
    return Material(
      color: Colors.white.withValues(alpha: 0.94),
      shape: const CircleBorder(),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.15),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 19, color: color),
        ),
      ),
    );
  }

  Widget _buildHighlightItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: _primaryGreen, size: 18),
        const SizedBox(height: 5),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 13,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 10.5, color: Colors.grey.shade500),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(height: 32, width: 1, color: Colors.grey.shade200);
  }

  Widget _buildServiceBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _lightGreen.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _primaryGreen, size: 14),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: _primaryGreen,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(
    IconData icon,
    String label,
    String value, {
    bool isLast = false,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Icon(icon, size: 17, color: _primaryGreen),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
        ),
        if (!isLast) Divider(height: 1, color: Colors.grey.shade100),
      ],
    );
  }
}
