import 'package:flutter/material.dart';

import 'ChatPage.dart';
import 'AnimalPageDetail.dart'; // Sesuaikan dengan nama file AnimalDetail di folder lib/ kamu

class FarmDetailPage extends StatefulWidget {
  final Map<String, dynamic> peternak;

  const FarmDetailPage({super.key, required this.peternak});

  @override
  State<FarmDetailPage> createState() => _FarmDetailPageState();
}

class _FarmDetailPageState extends State<FarmDetailPage> {
  static const Color _primaryGreen = Color(0xFF166036);
  static const Color _lightGreen = Color(0xFFE6F4EA);
  static const Color _bgColor = Color(0xFFF8FAF8);

  int _activeTab = 0; // 0: Tentang, 1: Ulasan, 2: Produk
  final TextEditingController _reviewController = TextEditingController();
  int _selectedRating = 5;

  // Data unik per seller beserta produk dengan gambar & deskripsi berbeda-beda
  final Map<String, dynamic> _sellerDatabase = {
    'Berkah Farmer': {
      'banner': 'Asset/image/Berkah.jpg',
      'avatar': 'Asset/image/Bali.png',
      'about': 'Peternakan sapi unggulan asal Bandung dengan pakan hijauan alami dan pengawasan dokter hewan rutin. Semua sapi sudah dilengkapi sertifikat bebas PMK.',
      'products': [
        {
          'name': 'Sapi Limousin Super',
          'weight': '450 kg',
          'age': '2,5 tahun',
          'breed': 'Sapi Limousin',
          'price': 'Rp 24.500.000',
          'image': 'Asset/image/Sapi.png',
          'images': [
            'Asset/image/Sapi.png',
            'Asset/image/Bali.png',
            'Asset/image/Brahman.jpeg',
          ],
          'category': 'Sapi',
          'description': 'Sapi Limousin Super bobot 450 kg dengan postur padat dan sehat. Dirawat dengan pakan hijauan pilihan serta konsentrat alami, sudah divaksin dan dilengkapi surat keterangan bebas PMK.',
        },
        {
          'name': 'Kambing Boer',
          'weight': '45 kg',
          'age': '1,5 tahun',
          'breed': 'Kambing Boer',
          'price': 'Rp 4.900.000',
          'image': 'Asset/image/Boer.jpg',
          'images': ['Asset/image/Boer.jpg', 'Asset/image/Boer.png'],
          'category': 'Kambing',
          'description': 'Kambing Boer pedaging unggulan dengan proporsi daging tebal dan tulang ramping. Kondisi lincah, nafsu makan sangat baik, dan memenuhi seluruh syarat sah hewan kurban.',
        },
        {
          'name': 'Sapi Brahman Cross',
          'weight': '380 kg',
          'age': '2 tahun',
          'breed': 'Sapi Brahman Cross',
          'price': 'Rp 22.500.000',
          'image': 'Asset/image/Brahman.jpeg',
          'images': ['Asset/image/Brahman.jpeg', 'Asset/image/Sapi.png'],
          'category': 'Sapi',
          'description': 'Sapi Brahman Cross berpunuk khas dengan daya tahan tubuh kuat. Sangat cocok untuk kurban keluarga maupun patungan 7 orang dengan estimasi karkas tinggi.',
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
          'age': '1,5 tahun',
          'breed': 'Kambing Boer',
          'price': 'Rp 4.800.000',
          'image': 'Asset/image/Boer.png',
          'images': ['Asset/image/Boer.png', 'Asset/image/Boer.jpg'],
          'category': 'Kambing',
          'description': 'Kambing Boer pilihan kualitas premium dari kandang Cianjur. Bulu bersih, tidak cacat fisik, cukup umur (poel), dan siap antar H-1 Idul Adha.',
        },
        {
          'name': 'Kambing Etawa Jantan',
          'weight': '38 kg',
          'age': '1,5 tahun',
          'breed': 'Kambing Etawa',
          'price': 'Rp 4.500.000',
          'image': 'Asset/image/Etawa.jpeg',
          'images': ['Asset/image/Etawa.jpeg', 'Asset/image/Kambing.png'],
          'category': 'Kambing',
          'description': 'Kambing Etawa jantan bertubuh tinggi dan gagah. Perawatan rutin dengan pemeriksaan dokter hewan berkala sehingga terjamin kesehatan dan kebersihannya.',
        },
        {
          'name': 'Paket Aqiqah Siap Saji',
          'weight': '50 Box',
          'age': '1 tahun',
          'breed': 'Paket Olahan Aqiqah',
          'price': 'Rp 3.200.000',
          'image': 'Asset/image/Siapsaji.png',
          'images': ['Asset/image/Siapsaji.png', 'Asset/image/Boer.png'],
          'category': 'Aqiqah',
          'description': 'Paket aqiqah praktis 50 box lengkap dengan olahan gulai dan sate bumbu rempah khas tanpa bau prengus. Sudah termasuk sertifikat aqiqah dan dokumentasi penyembelihan.',
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
      'banner': 'Asset/image/Tangguh.jpeg',
      'avatar': 'Asset/image/Domba.png',
      'about': 'Peternakan domba Garut pilihan langsung dari peternak lokal. Perawatan intensif di dataran tinggi menghasilkan ternak yang sehat dan lincah.',
      'products': [
        {
          'name': 'Domba Garut Tanduk',
          'weight': '40 kg',
          'age': '1,5 tahun',
          'breed': 'Domba Garut',
          'price': 'Rp 4.200.000',
          'image': 'Asset/image/Domba.png',
          'images': ['Asset/image/Domba.png', 'Asset/image/Kambing.png'],
          'category': 'Domba',
          'description': 'Domba Garut bertanduk simetris dengan postur kekar dan sehat. Dipelihara di dataran tinggi berudara sejuk dengan pakan rumput segar pilihan.',
        },
        {
          'name': 'Domba Ekor Gemuk',
          'weight': '35 kg',
          'age': '1,5 tahun',
          'breed': 'Domba Ekor Gemuk',
          'price': 'Rp 3.600.000',
          'image': 'Asset/image/Kambing.png',
          'images': ['Asset/image/Kambing.png', 'Asset/image/Domba.png'],
          'category': 'Domba',
          'description': 'Domba ekor gemuk dengan kualitas daging empuk dan gurih. Kondisi sehat, aktif, dan bebas penyakit kulit maupun kuku.',
        },
        {
          'name': 'Domba Aqiqah Sehat',
          'weight': '28 kg',
          'age': '1 tahun',
          'breed': 'Domba Lokal',
          'price': 'Rp 2.900.000',
          'image': 'Asset/image/Domba.png',
          'images': ['Asset/image/Domba.png'],
          'category': 'Domba',
          'description': 'Domba sehat yang memenuhi syarat sah ibadah aqiqah maupun kurban hemat. Tersedia layanan potong di tempat atau kirim hidup ke alamat tujuan.',
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
          'age': '2 tahun',
          'breed': 'Sapi Brahman Cross',
          'price': 'Rp 22.800.000',
          'image': 'Asset/image/Sapi.png',
          'images': ['Asset/image/Sapi.png', 'Asset/image/Brahman.jpeg'],
          'category': 'Sapi',
          'description': 'Sapi Brahman Cross langsung dari kandang Sumedang dengan bobot terukur timbangan digital. Sehat, terawat, dan gratis biaya perawatan hingga hari pengiriman.',
        },
        {
          'name': 'Kambing Jawa Randu',
          'weight': '34 kg',
          'age': '1,5 tahun',
          'breed': 'Kambing Jawa Randu',
          'price': 'Rp 3.400.000',
          'image': 'Asset/image/Kambing.png',
          'images': ['Asset/image/Kambing.png', 'Asset/image/Etawa.jpeg'],
          'category': 'Kambing',
          'description': 'Kambing Jawa Randu jantan dengan harga bersahabat langsung dari peternak. Sudah memenuhi syarat syariat kurban dan siap dikirim dengan armada khusus.',
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

  late Map<String, dynamic> _currentSellerData;
  final List<dynamic> _hewanTersedia = [];
  final List<dynamic> _ulasanList = [];

  @override
  void initState() {
    super.initState();
    final String sellerName = (widget.peternak['name'] ?? '').toString();
    _currentSellerData =
        (_sellerDatabase[sellerName] as Map<String, dynamic>?) ??
        {
          'banner': 'Asset/image/Bannersapi.png',
          'avatar': widget.peternak['image'] ?? 'Asset/image/Bali.png',
          'about': 'Peternakan sapi dan kambing sehat dengan standar kesehatan tinggi. Semua hewan kami dilengkapi sertifikat bebas PMK.',
          'products': [
            {
              'name': 'Sapi Limousin',
              'weight': '420 kg',
              'age': '2 tahun',
              'breed': 'Sapi Limousin',
              'price': 'Rp 24.500.000',
              'image': 'Asset/image/Sapi.png',
              'images': ['Asset/image/Sapi.png', 'Asset/image/Bali.png'],
              'category': 'Sapi',
              'description': 'Sapi Limousin sehat dengan pakan hijauan berkualitas dan pengawasan rutin dokter hewan.',
            },
            {
              'name': 'Kambing Etawa',
              'weight': '38 kg',
              'age': '1,5 tahun',
              'breed': 'Kambing Etawa',
              'price': 'Rp 4.500.000',
              'image': 'Asset/image/Etawa.jpeg',
              'images': ['Asset/image/Etawa.jpeg', 'Asset/image/Kambing.png'],
              'category': 'Kambing',
              'description': 'Kambing Etawa sehat dan lincah, siap untuk kebutuhan kurban maupun aqiqah keluarga.',
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

    _hewanTersedia.addAll(_currentSellerData['products'] as List<dynamic>);
    _ulasanList.addAll(_currentSellerData['reviews'] as List<dynamic>);
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

  void _openChatPage([Map<String, dynamic>? selectedAnimal]) {
    final String sellerName = (widget.peternak['name'] ?? 'Peternak QurbanMart')
        .toString();
    final String sellerLocation = (widget.peternak['location'] ?? 'Jawa Barat')
        .toString();
    final String sellerAvatar =
        (widget.peternak['image'] ?? _currentSellerData['avatar']).toString();

    final Map<String, dynamic> firstProduct = _hewanTersedia.isNotEmpty
        ? Map<String, dynamic>.from(_hewanTersedia[0] as Map)
        : <String, dynamic>{};

    final Map<String, dynamic> chatPayload =
        selectedAnimal ??
        {
          'name': sellerName,
          'seller': sellerName,
          'location': sellerLocation,
          'image': sellerAvatar,
          'price': (firstProduct['price'] ?? 'Rp 24.500.000').toString(),
        };

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatPage(animal: chatPayload)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String bannerImage = _currentSellerData['banner'].toString();
    final String avatarImage =
        (widget.peternak['image'] ?? _currentSellerData['avatar']).toString();
    final String aboutText = _currentSellerData['about'].toString();
    final String sellerName = (widget.peternak['name'] ?? 'Peternakan Mitra')
        .toString();
    final String sellerRating = (widget.peternak['rating'] ?? '4.9').toString();
    final String sellerReviews =
        (widget.peternak['reviews'] ?? '${_ulasanList.length} ulasan')
            .toString();
    final String sellerLocation =
        (widget.peternak['location'] ?? 'Bandung, Jawa Barat').toString();

    return Scaffold(
      backgroundColor: _bgColor,
      body: Column(
        children: [
          // KONTEN UTAMA SCROLLABLE
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- 1. HEADER BANNER & AVATAR ---
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              bannerImage,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: _primaryGreen.withValues(alpha: 0.2),
                                  ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withValues(alpha: 0.45),
                                    Colors.transparent,
                                    Colors.black.withValues(alpha: 0.15),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Tombol Kembali
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 10,
                        left: 20,
                        child: Material(
                          color: Colors.white.withValues(alpha: 0.95),
                          shape: const CircleBorder(),
                          elevation: 2,
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            customBorder: const CircleBorder(),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                size: 18,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Avatar Peternak + Indikator Online
                      Positioned(
                        bottom: -42,
                        left: 24,
                        child: Stack(
                          children: [
                            Container(
                              width: 88,
                              height: 88,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.12),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                image: DecorationImage(
                                  image: AssetImage(avatarImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 4,
                              bottom: 4,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF22C55E),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Badge Terverifikasi
                      Positioned(
                        bottom: -28,
                        right: 24,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _lightGreen,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _primaryGreen.withValues(alpha: 0.2),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.verified,
                                color: _primaryGreen,
                                size: 15,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Peternak Terpercaya',
                                style: TextStyle(
                                  color: _primaryGreen,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 52),

                  // --- 2. PROFIL & STATISTIK SINGKAT PETERNAK ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sellerName,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0F172A),
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              color: _primaryGreen,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                sellerLocation,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Kartu Statistik 3 Kolom
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 12,
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
                                child: _buildStatItem(
                                  icon: Icons.star_rounded,
                                  iconColor: Colors.amber,
                                  value: sellerRating,
                                  label: sellerReviews,
                                ),
                              ),
                              _buildVerticalDivider(),
                              Expanded(
                                child: _buildStatItem(
                                  icon: Icons.pets_rounded,
                                  iconColor: _primaryGreen,
                                  value: '${_hewanTersedia.length} Jenis',
                                  label: 'Siap Kurban',
                                ),
                              ),
                              _buildVerticalDivider(),
                              Expanded(
                                child: _buildStatItem(
                                  icon: Icons.bolt_rounded,
                                  iconColor: const Color(0xFF0284C7),
                                  value: '± 5 Menit',
                                  label: 'Respon Chat',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- 3. SEGMENTED TAB MENU ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF3F0),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Expanded(child: _buildTabItem('Tentang', 0)),
                          Expanded(
                            child: _buildTabItem(
                              'Ulasan (${_ulasanList.length})',
                              1,
                            ),
                          ),
                          Expanded(
                            child: _buildTabItem(
                              'Produk (${_hewanTersedia.length})',
                              2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- 4. KONTEN TAB 0: TENTANG ---
                  if (_activeTab == 0) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
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
                              'Tentang Peternakan',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              aboutText,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 13.5,
                                height: 1.55,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _buildServiceBadge(
                                  Icons.health_and_safety_rounded,
                                  'Bebas PMK',
                                ),
                                _buildServiceBadge(
                                  Icons.local_shipping_rounded,
                                  'Pengiriman Aman',
                                ),
                                _buildServiceBadge(
                                  Icons.verified_user_rounded,
                                  'Mitra Terverifikasi',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Hewan Tersedia',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => setState(() => _activeTab = 2),
                            child: const Text(
                              'Lihat Semua',
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                                color: _primaryGreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    _buildProductGrid(),
                  ],

                  // --- 5. KONTEN TAB 1: ULASAN ---
                  if (_activeTab == 1) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
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
                              'Tulis Ulasan Anda',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: List.generate(5, (index) {
                                return GestureDetector(
                                  onTap: () => setState(
                                    () => _selectedRating = index + 1,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 4),
                                    child: Icon(
                                      index < _selectedRating
                                          ? Icons.star_rounded
                                          : Icons.star_outline_rounded,
                                      color: Colors.amber,
                                      size: 28,
                                    ),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _reviewController,
                                    decoration: InputDecoration(
                                      hintText:
                                          'Tulis ulasan untuk $sellerName...',
                                      hintStyle: TextStyle(
                                        fontSize: 12.5,
                                        color: Colors.grey.shade400,
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFFF8FAFC),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 11,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade200,
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
                                      horizontal: 16,
                                      vertical: 13,
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
                                      fontSize: 13,
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
                        final item = Map<String, dynamic>.from(
                          _ulasanList[index] as Map,
                        );
                        final String userName = item['user'].toString();
                        final String initial = userName.isNotEmpty
                            ? userName[0].toUpperCase()
                            : 'U';
                        final int ratingCount = (item['rating'] as int?) ?? 5;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 17,
                                    backgroundColor: _lightGreen,
                                    child: Text(
                                      initial,
                                      style: const TextStyle(
                                        color: _primaryGreen,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Color(0xFF1E293B),
                                          ),
                                        ),
                                        Row(
                                          children: List.generate(
                                            ratingCount,
                                            (_) => const Icon(
                                              Icons.star_rounded,
                                              color: Colors.amber,
                                              size: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    item['date'].toString(),
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item['comment'].toString(),
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 13,
                                  height: 1.45,
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
                        'Katalog $sellerName',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    _buildProductGrid(),
                  ],
                ],
              ),
            ),
          ),

          // --- 7. BOTTOM BAR TOMBOL CHAT LANGSUNG ---
          Container(
            padding: EdgeInsets.fromLTRB(
              24,
              12,
              24,
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
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () => _openChatPage(),
                icon: const Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                label: const Text(
                  'Chat Peternak',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryGreen,
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
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 16),
            const SizedBox(width: 4),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 13,
                color: Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(height: 28, width: 1, color: Colors.grey.shade200);
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.78,
      ),
      itemCount: _hewanTersedia.length,
      itemBuilder: (context, index) {
        final animalMap = Map<String, dynamic>.from(
          _hewanTersedia[index] as Map,
        );
        return _buildAnimalCard(animalMap);
      },
    );
  }

  Widget _buildTabItem(String title, int index) {
    final bool isActive = _activeTab == index;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? _primaryGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(11),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: _primaryGreen.withValues(alpha: 0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey.shade700,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildServiceBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _lightGreen.withValues(alpha: 0.6),
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

  Widget _buildAnimalCard(Map<String, dynamic> animal) {
    final Map<String, dynamic> fullAnimalData = {
      ...animal,
      'location': widget.peternak['location'] ?? 'Bandung, Jawa Barat',
      'seller': widget.peternak['name'] ?? 'Peternakan Mitra',
      'rating': widget.peternak['rating'] ?? '4.9',
      'reviews': widget.peternak['reviews'] ?? '120 ulasan',
    };

    return GestureDetector(
      onTap: () {
        // Langsung berpindah ke halaman AnimalDetailPage membawa data unik hewan ini
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimalDetailPage(animal: fullAnimalData),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.asset(
                      animal['image'].toString(),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey.shade100,
                        child: const Icon(Icons.pets, color: _primaryGreen),
                      ),
                    ),
                  ),
                  if (animal['weight'] != null)
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          animal['weight'].toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    animal['name'].toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.5,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    animal['price'].toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13.5,
                      color: _primaryGreen,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
