import 'package:flutter/material.dart';

import 'FavoriteManager.dart'; // <-- Penting untuk mengambil data
import 'AnimalPageDetail.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  static const Color _primaryGreen = Color(0xFF1B5E20);

  @override
  Widget build(BuildContext context) {
    // Mengambil data hewan yang sudah di-love
    final List<Map<String, dynamic>> favList = FavoriteManager.favoriteList;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F7),
      appBar: AppBar(
        title: const Text(
          'Hewan Favorit',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: _primaryGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: favList.isEmpty
          ? _buildEmptyState() // Jika kosong, tampilkan gambar/text kosong
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favList.length,
              itemBuilder: (context, index) {
                final animal = favList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildFavoriteCard(animal),
                );
              },
            ),
    );
  }

  // Tampilan Jika Belum Ada Favorit
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          const Text(
            'Belum ada hewan favorit',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

  // Desain Kartu Hewan di Halaman Favorit
  Widget _buildFavoriteCard(Map<String, dynamic> animal) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimalDetailPage(animal: animal),
          ),
        ).then((_) => setState(() {})); // Refresh setelah kembali dari detail
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFE9E9E9)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Gambar Hewan
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                animal['image'] ?? '',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, stack) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Detail Hewan
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    animal['name'] ?? 'Hewan',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
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
            // Tombol Hapus dari Favorit (Un-Love)
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
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
  }
}
