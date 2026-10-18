import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});
  static const Color _primaryGreen = Color(0xFF166036);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: _buildAppBar(context, 'Kebijakan Privasi'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.security,
                size: 80,
                color: _primaryGreen.withOpacity(0.2),
              ),
            ),
            const SizedBox(height: 16),
            _buildHeader(
              'Privasi Anda Sangat Penting',
              'QurbanMart berkomitmen untuk menjaga keamanan dan kerahasiaan data pribadi Anda sesuai dengan hukum yang berlaku di Indonesia.',
            ),
            const SizedBox(height: 24),
            const Text(
              'Data Apa yang Kami Kumpulkan?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 12),
            _buildPoint('Informasi Akun (Nama, Email, No. HP).'),
            _buildPoint('Alamat Pengiriman (Titik lokasi rumah / masjid).'),
            _buildPoint('Riwayat Transaksi dan Metode Pembayaran.'),
            const SizedBox(height: 24),
            const Text(
              'Bagaimana Kami Menggunakan Data Anda?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 12),
            _buildPoint('Untuk memproses pesanan dan pengiriman hewan.'),
            _buildPoint('Mengirimkan laporan dan dokumentasi penyembelihan.'),
            _buildPoint('Meningkatkan kualitas layanan aplikasi QurbanMart.'),
          ],
        ),
      ),
    );
  }

  Widget _buildPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: _primaryGreen, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, String title) {
    return AppBar(
      backgroundColor: const Color(0xFFFAFAFA),
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

  Widget _buildHeader(String title, String desc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 22,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          desc,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
