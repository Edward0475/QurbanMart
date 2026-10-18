import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});
  static const Color _primaryGreen = Color(0xFF166036);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: _buildAppBar(context, 'Pusat Bantuan (FAQ)'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildHeader(
            'Punya Pertanyaan?',
            'Temukan jawaban untuk pertanyaan yang paling sering ditanyakan seputar layanan QurbanMart.',
          ),
          const SizedBox(height: 24),
          _buildFaqItem(
            'Bagaimana cara memesan hewan Qurban?',
            'Anda dapat mencari hewan melalui halaman Beranda, pilih hewan yang sesuai, klik "Pesan Sekarang", lalu ikuti langkah pembayaran yang tersedia.',
          ),
          _buildFaqItem(
            'Apakah hewan dijamin sehat?',
            'Tentu! Semua hewan ternak di QurbanMart telah melewati pemeriksaan ketat oleh dokter hewan dan dipastikan memenuhi syarat syariat Islam.',
          ),
          _buildFaqItem(
            'Bagaimana sistem pengirimannya?',
            'Hewan bisa dikirimkan langsung ke rumah atau masjid Anda menggunakan mobil pikap khusus, atau Anda bisa memilih opsi "Titip Salurkan" ke panti asuhan.',
          ),
          _buildFaqItem(
            'Metode pembayaran apa saja yang didukung?',
            'Kami mendukung Transfer Bank (BCA, BNI, Mandiri, BRI), E-Wallet (OVO, GoPay, DANA, ShopeePay), dan Kartu Kredit/Debit.',
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: _primaryGreen,
          collapsedIconColor: Colors.grey.shade500,
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          title: Text(
            question,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF1E293B),
            ),
          ),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Text(
                answer,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
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
