import 'package:flutter/material.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});
  static const Color _primaryGreen = Color(0xFF166036);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
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
        title: const Text(
          'Keamanan',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSecurityCard([
            _buildSecurityItem(
              Icons.lock_outline,
              'Ganti Kata Sandi',
              'Terakhir diubah 2 bulan lalu',
              true,
            ),
            const Divider(height: 1, indent: 56),
            _buildSecurityItem(
              Icons.security,
              'Autentikasi 2 Faktor (2FA)',
              'Aktif (Kirim kode via SMS)',
              false,
            ),
          ]),
          const SizedBox(height: 24),
          const Text(
            'Riwayat Login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          _buildSecurityCard([
            _buildDeviceItem(
              'MacBook Pro (Chrome)',
              'Jakarta, Indonesia • Sedang aktif',
              true,
            ),
            const Divider(height: 1, indent: 56),
            _buildDeviceItem(
              'iPhone 13 Pro',
              'Tangerang, Banten • 2 hari lalu',
              false,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSecurityCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSecurityItem(
    IconData icon,
    String title,
    String subtitle,
    bool isArrow,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: const Color(0xFF334155), size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
      ),
      trailing: isArrow
          ? const Icon(Icons.chevron_right, color: Colors.grey)
          : const Switch(
              value: true,
              onChanged: null,
              activeColor: _primaryGreen,
            ),
      onTap: () {},
    );
  }

  Widget _buildDeviceItem(String device, String location, bool isActive) {
    return ListTile(
      leading: Icon(
        isActive ? Icons.laptop_mac : Icons.phone_iphone,
        color: isActive ? _primaryGreen : Colors.grey,
      ),
      title: Text(
        device,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      subtitle: Text(
        location,
        style: TextStyle(
          fontSize: 12,
          color: isActive ? _primaryGreen : Colors.grey.shade500,
        ),
      ),
      trailing: isActive
          ? null
          : TextButton(
              onPressed: () {},
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
            ),
    );
  }
}
