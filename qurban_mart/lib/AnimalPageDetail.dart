import 'package:flutter/material.dart';

import 'TransactionPage.dart';
import 'ChatPage.dart';
import 'Favorite.dart'; // Sesuaikan jika nama file Anda FavoritePage.dart

class AnimalDetailPage extends StatefulWidget {
  final Map<String, dynamic> animal;

  const AnimalDetailPage({super.key, required this.animal});

  @override
  State<AnimalDetailPage> createState() => _AnimalDetailPageState();
}

class _AnimalDetailPageState extends State<AnimalDetailPage> {
  static const Color green = Color(0xFF078A4B);
  static const Color background = Color(0xFFF8F9F7);

  int selectedPhoto = 0;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final animal = widget.animal;

    final image = (animal['image'] ?? 'Asset/image/Sapi.png').toString();
    final name = (animal['name'] ?? 'Sapi Limousin').toString();
    final price = (animal['price'] ?? 'Rp 24.500.000').toString();
    final weight = (animal['weight'] ?? '350 kg').toString();
    final age = (animal['age'] ?? '2 tahun').toString();
    final location = (animal['location'] ?? 'Bogor, Jawa Barat').toString();
    final category = (animal['category'] ?? 'Sapi').toString();

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  // FOTO UTAMA HEWAN
                  SliverToBoxAdapter(
                    child: Stack(
                      children: [
                        GestureDetector(
                          onHorizontalDragEnd: (_) {
                            setState(() {
                              selectedPhoto = (selectedPhoto + 1) % 5;
                            });
                          },
                          child: SizedBox(
                            height: 330,
                            width: double.infinity,
                            child: Image.asset(
                              image,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) {
                                return Container(
                                  color: const Color(0xFFE5EFE7),
                                  child: const Icon(
                                    Icons.pets,
                                    size: 90,
                                    color: green,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // TOMBOL KEMBALI
                        Positioned(
                          top: 14,
                          left: 16,
                          child: _roundIcon(
                            Icons.arrow_back,
                            () => Navigator.pop(context),
                          ),
                        ),

                        // FAVORIT DAN BAGIKAN
                        Positioned(
                          top: 14,
                          right: 16,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.favorite_border_rounded),
                                color: const Color(0xFFE53935), // Warna merah
                                onPressed: () {
                                  // Kode ini yang berfungsi memindahkan ke halaman Favorite
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const FavoritePage(),
                                    ),
                                  );
                                },
                              ),
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
                        ),

                        // NOMOR FOTO
                        Positioned(
                          right: 16,
                          bottom: 14,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${selectedPhoto + 1}/5',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // INFORMASI HEWAN DAN PENJUAL
                  SliverToBoxAdapter(
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // THUMBNAIL FOTO
                          SizedBox(
                            height: 64,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 8),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedPhoto = index;
                                    });
                                  },
                                  child: Container(
                                    width: 74,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      border: Border.all(
                                        color: selectedPhoto == index
                                            ? green
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(7),
                                      child: Image.asset(
                                        image,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            const Icon(Icons.pets),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 14),

                          // STATUS VERIFIKASI DAN RATING
                          Row(
                            children: [
                              const Icon(
                                Icons.verified,
                                size: 16,
                                color: green,
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                'Terverifikasi',
                                style: TextStyle(
                                  color: green,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.star,
                                size: 16,
                                color: Color(0xFFFFB300),
                              ),
                              const SizedBox(width: 3),
                              const Text(
                                '4.8 (120 ulasan)',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF555555),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // NAMA HEWAN
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF202020),
                            ),
                          ),

                          const SizedBox(height: 4),

                          // HARGA
                          Text(
                            price,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: green,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // INFORMASI PETERNAK
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 21,
                                backgroundColor: Color(0xFFE5F2E8),
                                child: Icon(Icons.agriculture, color: green),
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Peternakan Berkah',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 13,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          'Bogor, Jawa Barat',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              OutlinedButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Fitur chat penjual akan segera tersedia.',
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.chat_bubble_outline,
                                  size: 15,
                                ),
                                label: const Text('Chat'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: green,
                                  side: const BorderSide(color: green),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 10)),

                  // DETAIL HEWAN
                  SliverToBoxAdapter(
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Detail Hewan',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _detailRow(Icons.scale_outlined, 'Berat', weight),
                          _detailRow(Icons.access_time, 'Usia', age),
                          _detailRow(
                            Icons.health_and_safety_outlined,
                            'Kondisi',
                            'Sehat',
                          ),
                          _detailRow(
                            Icons.pets_outlined,
                            'Jenis',
                            category == 'Sapi' ? 'Sapi Limousin' : name,
                          ),
                          _detailRow(
                            Icons.location_on_outlined,
                            'Lokasi',
                            location,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // DESKRIPSI HEWAN
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      color: Colors.white,
                      padding: const EdgeInsets.all(16),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Deskripsi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Hewan kurban dalam kondisi sehat, '
                            'nafsu makan baik, dan perawatan rutin. '
                            'Cocok untuk ibadah kurban dengan kualitas '
                            'yang terjaga. Silakan hubungi peternak '
                            'untuk informasi lebih lanjut.',
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.6,
                              color: Color(0xFF555555),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 18)),
                ],
              ),
            ),

            // TOMBOL AKSI BAGIAN BAWAH
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 10,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(animal: animal),
                          ),
                        );
                      },
                      icon: const Icon(Icons.chat_outlined, size: 18),
                      label: const Text('Chat Penjual'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: green,
                        side: const BorderSide(color: green),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // atau onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TransactionPage(animal: animal),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                      label: const Text('Pesan Sekarang'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
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

  // TOMBOL IKON BULAT
  Widget _roundIcon(
    IconData icon,
    VoidCallback onTap, {
    Color color = const Color(0xFF222222),
  }) {
    return Material(
      color: Colors.white.withOpacity(0.95),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 20, color: color),
        ),
      ),
    );
  }

  // BARIS INFORMASI DETAIL HEWAN
  Widget _detailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Row(
        children: [
          Icon(icon, size: 17, color: const Color(0xFF777777)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: Color(0xFF666666)),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}
