import 'package:flutter/material.dart';

class SaldoQurbanPage extends StatefulWidget {
  const SaldoQurbanPage({super.key});

  @override
  State<SaldoQurbanPage> createState() => _SaldoQurbanPageState();
}

class _SaldoQurbanPageState extends State<SaldoQurbanPage> {
  // Warna Utama
  static const Color _primaryGreen = Color(0xFF1B5E20);
  static const Color _lightGreen = Color(0xFF2E7D32);
  static const Color _backgroundColor = Color(0xFFF8F9F7);

  // Contoh data riwayat transaksi statis
  final List<Map<String, dynamic>> _transactions = [
    {
      'title': 'Isi Saldo (Top Up)',
      'date': '12 Okt 2026, 14:30',
      'amount': '+ Rp 5.000.000',
      'isIncome': true,
      'icon': Icons.account_balance_wallet,
    },
    {
      'title': 'Pembayaran Sapi Limousin',
      'date': '10 Okt 2026, 09:15',
      'amount': '- Rp 24.500.000',
      'isIncome': false,
      'icon': Icons.shopping_bag_outlined,
    },
    {
      'title': 'Isi Saldo (Top Up)',
      'date': '01 Okt 2026, 10:00',
      'amount': '+ Rp 20.000.000',
      'isIncome': true,
      'icon': Icons.account_balance_wallet,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Color(0xFF222222),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Saldo Qurban',
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. KARTU SALDO UTAMA
              _buildBalanceCard(),
              const SizedBox(height: 24),

              // 2. TOMBOL AKSI (Top Up, Transfer, dll)
              _buildActionButtons(),
              const SizedBox(height: 32),

              // 3. RIWAYAT TRANSAKSI
              const Text(
                'Transaksi Terakhir',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF222222),
                ),
              ),
              const SizedBox(height: 16),
              _buildTransactionHistory(),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // KOMPONEN UI KARTU SALDO
  // ============================================================
  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_primaryGreen, _lightGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _primaryGreen.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Saldo Anda',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.shield_outlined, size: 14, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'Aman',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Rp 2.500.000',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Text(
                '0 Poin QurbanMart',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
                size: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // KOMPONEN TOMBOL AKSI
  // ============================================================
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _actionButtonIcon(icon: Icons.add, label: 'Isi Saldo', onTap: () {}),
        _actionButtonIcon(
          icon: Icons.arrow_upward_rounded,
          label: 'Tarik Tunai',
          onTap: () {},
        ),
        _actionButtonIcon(icon: Icons.history, label: 'Riwayat', onTap: () {}),
        _actionButtonIcon(
          icon: Icons.help_outline,
          label: 'Bantuan',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _actionButtonIcon({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: _primaryGreen, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF444444),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // KOMPONEN RIWAYAT TRANSAKSI
  // ============================================================
  Widget _buildTransactionHistory() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _transactions.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final tx = _transactions[index];
        final bool isIncome = tx['isIncome'];

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon Status
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isIncome
                      ? const Color(0xFFE8F5E9)
                      : const Color(0xFFFFEBEE),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  tx['icon'],
                  size: 20,
                  color: isIncome ? _primaryGreen : Colors.red.shade700,
                ),
              ),
              const SizedBox(width: 16),
              // Detail
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx['title'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF222222),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tx['date'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF888888),
                      ),
                    ),
                  ],
                ),
              ),
              // Nominal
              Text(
                tx['amount'],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isIncome ? _primaryGreen : Colors.red.shade700,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
