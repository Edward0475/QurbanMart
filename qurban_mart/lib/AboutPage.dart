import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  static const Color _primaryGreen = Color(0xFF166036);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: _buildAppBar(context, 'Tentang QurbanMart'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HERO BANNER DENGAN BACKGROUND PUTIH/TRANSPARAN
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white, // Latar belakang putih bersih
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  // LOGO QURBANMART
                  Image.asset(
                    'Asset/image/QurbanMart.png',
                    height: 100, // Sesuaikan ukuran logo
                    fit: BoxFit.contain,
                    // Jika gambar gagal dimuat, akan muncul ikon alternatif
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.mosque,
                      color: _primaryGreen,
                      size: 80,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'QurbanMart',
                    style: TextStyle(
                      color: Color(
                        0xFF1E293B,
                      ), // Teks gelap agar terbaca di latar putih
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Platform Qurban Digital Terpercaya',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Versi 1.0.0',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // VISI & MISI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Visi Misi Kami',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'QurbanMart didirikan untuk memudahkan umat muslim dalam menunaikan ibadah Qurban maupun Aqiqah secara transparan, mudah, dan sesuai syariat. Kami menghubungkan peternak lokal langsung dengan Anda.',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Hubungi Kami',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  _buildContactCard(
                    Icons.language,
                    'Website',
                    'www.qurbanmart.id',
                  ),
                  _buildContactCard(
                    Icons.email_outlined,
                    'Email',
                    'support@qurbanmart.id',
                  ),
                  _buildContactCard(Icons.call, 'Telepon', '+62 812 3456 7890'),
                  const SizedBox(height: 40), // Ruang ekstra di bawah
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(IconData icon, String title, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Color(0xFFE6F4EA), // Hijau sangat pudar
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: _primaryGreen, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Color(0xFF1E293B),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
      ),
    );
  }

  // --- Fungsi Khusus AppBar ---
  AppBar _buildAppBar(BuildContext context, String title) {
    return AppBar(
      backgroundColor: Colors.white, // Menyesuaikan dengan latar belakang putih
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
