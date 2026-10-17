import 'package:flutter/material.dart';

import 'HomePage.dart'; // Digunakan untuk kembali ke beranda setelah bayar
import 'OrderDetailPage.dart';
import 'OrderManager.dart';

class TransactionPage extends StatefulWidget {
  final Map<String, dynamic> animal;

  const TransactionPage({super.key, required this.animal});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  static const Color _primaryGreen = Color(0xFF166036);
  static const Color _lightBg = Color(0xFFFAFAFA);

  int _selectedPenyaluran = 1; // 1: Kirim ke Rumah, 2: Titip Salurkan
  String _selectedPaymentMethod = ''; // Menyimpan metode pembayaran spesifik

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _lightBg,
      appBar: AppBar(
        backgroundColor: _lightBg,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF1E293B),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- METODE PENYALURAN ---
                  const Text(
                    'Metode Penyaluran',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Opsi 1: Kirim ke Rumah
                  _buildPenyaluranCard(
                    value: 1,
                    title: 'Kirim ke Rumah / Masjid Pribadi',
                    subtitle:
                        'Hewan dikirim hidup-hidup menggunakan mobil pikap.',
                    imagePath: 'Asset/image/Van.png',
                  ),
                  const SizedBox(height: 12),

                  // Opsi 2: Titip Salurkan
                  _buildPenyaluranCard(
                    value: 2,
                    title: 'Titip Salurkan / Sedekah',
                    subtitle: 'Hewan disembelih oleh mitra peternak, dagingnya disalurkan ke Panti Asuhan / Desa Pelosok.',
                    imagePath: 'Asset/image/Person.png',
                  ),
                  const SizedBox(height: 24),

                  // --- METODE PEMBAYARAN ---
                  const Text(
                    'Metode Pembayaran',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    // Theme digunakan untuk menghilangkan garis (divider) bawaan ExpansionTile
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: Column(
                        children: [
                          // 1. TRANSFER BANK
                          _buildPaymentExpansion(
                            icon: Icons.account_balance_outlined,
                            title: 'Transfer Bank',
                            options: [
                              'BCA Virtual Account',
                              'Mandiri Virtual Account',
                              'BNI Virtual Account',
                              'BRI Virtual Account',
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Colors.grey.shade200,
                            indent: 16,
                            endIndent: 16,
                          ),

                          // 2. E-WALLET
                          _buildPaymentExpansion(
                            icon: Icons.account_balance_wallet_outlined,
                            title: 'E-wallet',
                            subtitle: '(OVO, DANA, GoPay, ShopeePay)',
                            options: ['OVO', 'DANA', 'GoPay', 'ShopeePay'],
                          ),
                          Divider(
                            height: 1,
                            color: Colors.grey.shade200,
                            indent: 16,
                            endIndent: 16,
                          ),

                          // 3. KARTU KREDIT/DEBIT
                          _buildPaymentExpansion(
                            icon: Icons.credit_card_outlined,
                            title: 'Kartu Kredit/Debit',
                            options: ['Visa / Mastercard', 'JCB'],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // --- BOTTOM BAR ---
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Pembayaran',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF475569),
                      ),
                    ),
                    Text(
                      widget.animal['price'] ?? 'Rp 24.500.000',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: _primaryGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_selectedPaymentMethod.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Silakan pilih metode pembayaran terlebih dahulu.',
                            ),
                          ),
                        );
                        return;
                      }
                      OrderManager.addOrder(widget.animal);
                      // Pindah ke halaman sukses jika sudah memilih
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaymentSuccessPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Bayar Sekarang',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
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

  // Komponen Kartu Metode Penyaluran (Desain Khusus)
  Widget _buildPenyaluranCard({
    required int value,
    required String title,
    required String subtitle,
    required String imagePath,
  }) {
    bool isSelected = _selectedPenyaluran == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedPenyaluran = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFF0FDF4)
              : Colors.white, // Hijau sangat pudar jika dipilih
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? _primaryGreen : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: isSelected ? _primaryGreen : Colors.grey.shade400,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: isSelected
                              ? _primaryGreen
                              : const Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Gambar Van / Orang
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                imagePath,
                height: 80,
                fit: BoxFit.contain,
                errorBuilder: (ctx, err, stack) =>
                    const Icon(Icons.image, size: 50, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Komponen Akordeon Metode Pembayaran (Bisa Buka Tutup)
  Widget _buildPaymentExpansion({
    required IconData icon,
    required String title,
    String? subtitle,
    required List<String> options,
  }) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: const Color(0xFF334155), size: 20),
      ),
      title: RichText(
        text: TextSpan(
          text: title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF334155),
          ),
          children: [
            if (subtitle != null)
              TextSpan(
                text: ' $subtitle',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: Colors.grey.shade500,
                ),
              ),
          ],
        ),
      ),
      iconColor: _primaryGreen,
      children: options.map((option) {
        bool isSelected = _selectedPaymentMethod == option;
        return Container(
          color: isSelected ? const Color(0xFFF0FDF4) : Colors.transparent,
          child: RadioListTile<String>(
            title: Text(option, style: const TextStyle(fontSize: 14)),
            value: option,
            groupValue: _selectedPaymentMethod,
            activeColor: _primaryGreen,
            onChanged: (value) {
              setState(() {
                _selectedPaymentMethod = value!;
              });
            },
          ),
        );
      }).toList(),
    );
  }
}

// =====================================================================
// HALAMAN STATUS PEMBAYARAN BERHASIL (MUNCUL SETELAH TEKAN BAYAR SEKARANG)
// =====================================================================
class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  static const Color _primaryGreen = Color(0xFF166036);
  double _scale = 0.0;

  @override
  void initState() {
    super.initState();
    // Memulai animasi muncul (*pop up*)
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _scale = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animasi Centang
                AnimatedScale(
                  scale: _scale,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.elasticOut,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F4EA), // Hijau pudar
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _primaryGreen.withOpacity(0.3),
                        width: 8,
                      ),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: _primaryGreen,
                      size: 80,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Teks
                const Text(
                  'Pembayaran Berhasil!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Terima kasih. Transaksi Qurban Anda telah kami terima dan akan segera diproses.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 48),

                // Tombol Kembali
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Menghapus semua riwayat halaman (stack) dan kembali ke Home
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Kembali ke Beranda',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: // Jangan lupa tambahkan ini di baris paling atas TransactionPage.dart:
                      // import 'OrderDetailPage.dart';
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetailPage(
                                animal: {
                                  'name': 'Sapi Limousin',
                                  'price': 'Rp 24.500.000',
                                  'weight': '350 kg',
                                  'age': '2 tahun',
                                  'image': 'Asset/image/Sapi.png',
                                },
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Lihat Detail Pesanan',
                          style: TextStyle(
                            color: _primaryGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
