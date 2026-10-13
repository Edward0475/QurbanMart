import 'package:flutter/material.dart';

class SaldoQurbanPage extends StatelessWidget {
  const SaldoQurbanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black87,
            size: 20,
          ),
          // PERBAIKAN: Menggunakan onPressed, bukan onTap
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Saldo Qurban',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            const Text(
              'Halaman Saldo Qurban\nSedang Dalam Tahap Pengembangan',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
