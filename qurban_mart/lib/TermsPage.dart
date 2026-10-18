import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});
  static const Color _primaryGreen = Color(0xFF166036);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: _buildAppBar(context, 'Syarat & Ketentuan'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildHeader(
            'Syarat & Ketentuan Layanan',
            'Pembaruan Terakhir: 18 Oktober 2026\nHarap baca ketentuan ini dengan seksama sebelum menggunakan layanan kami.',
          ),
          const SizedBox(height: 24),
          _buildTermCard(
            Icons.shopping_bag_outlined,
            'Pemesanan & Transaksi',
            'Semua transaksi yang dilakukan bersifat final. Hewan yang sudah dipesan dan dibayar tidak dapat dibatalkan secara sepihak kecuali terdapat cacat fisik pada hewan yang tidak sesuai syariat.',
          ),
          _buildTermCard(
            Icons.local_shipping_outlined,
            'Pengiriman Hewan',
            'Pengiriman dilakukan mulai dari H-3 hingga H-1 Idul Adha. Segala bentuk keterlambatan akibat cuaca atau hal tak terduga (Force Majeure) akan kami informasikan.',
          ),
          _buildTermCard(
            Icons.gavel_outlined,
            'Hukum & Syariat',
            'Kami menjamin penuh bahwa seluruh proses mulai dari pengadaan hewan, pemeliharaan, hingga penyembelihan (untuk opsi titip salurkan) dilakukan 100% mengikuti Syariat Islam.',
          ),
        ],
      ),
    );
  }

  Widget _buildTermCard(IconData icon, String title, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE6F4EA),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: _primaryGreen, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  desc,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
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
