import 'package:flutter/material.dart';

import 'EditProfilePage.dart';
import 'SecurityPage.dart';
import 'PaymentCardsPage.dart';
import 'FaqPage.dart';
import 'TermsPage.dart';
import 'PrivacyPage.dart';
import 'AboutPage.dart';
import 'Login.dart'; // Ganti dengan nama file Login Anda jika berbeda

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static const Color _primaryGreen = Color(0xFF166036);
  static const Color _lightBg = Color(0xFFFAFAFA);

  // State untuk sakelar (toggle)
  bool _isNotifEnabled = true;
  bool _isPromoEnabled = false;
  bool _isFaceIdEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _lightBg,
      appBar: AppBar(
        backgroundColor: _lightBg,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF1E293B),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pengaturan',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- BAGIAN 1: AKUN ---
            _buildSectionTitle('Akun'),
            _buildSettingCard([
              _buildListTile(
                Icons.person_outline,
                'Edit Profil',
                onTap: () {
                  Navigator.push(
                    context,
                    // HAPUS kata const sebelum EditProfilePage()
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                },
              ),
              _buildDivider(),
              _buildListTile(
                Icons.shield_outlined,
                'Keamanan & Kata Sandi',
                onTap: () {
                  Navigator.push(
                    context,
                    // HAPUS kata const sebelum SecurityPage()
                    MaterialPageRoute(builder: (context) => SecurityPage()),
                  );
                },
              ),
              _buildDivider(),
              _buildListTile(
                Icons.credit_card_outlined,
                'Kartu & Rekening Tersimpan',
                onTap: () {
                  Navigator.push(
                    context,
                    // HAPUS kata const sebelum PaymentCardsPage()
                    MaterialPageRoute(builder: (context) => PaymentCardsPage()),
                  );
                },
              ),
            ]),
            const SizedBox(height: 24),

            // --- BAGIAN 2: PREFERENSI & NOTIFIKASI ---
            _buildSectionTitle('Preferensi'),
            _buildSettingCard([
              _buildSwitchTile(
                icon: Icons.notifications_active_outlined,
                title: 'Notifikasi Pesanan',
                value: _isNotifEnabled,
                onChanged: (val) => setState(() => _isNotifEnabled = val),
              ),
              _buildDivider(),
              _buildSwitchTile(
                icon: Icons.local_offer_outlined,
                title: 'Info Promo & Diskon',
                value: _isPromoEnabled,
                onChanged: (val) => setState(() => _isPromoEnabled = val),
              ),
              _buildDivider(),
              _buildSwitchTile(
                icon: Icons.face_retouching_natural,
                title: 'Login dengan Face ID / Sidik Jari',
                value: _isFaceIdEnabled,
                onChanged: (val) => setState(() => _isFaceIdEnabled = val),
              ),
              _buildDivider(),
              _buildListTile(
                Icons.language,
                'Bahasa',
                trailingText: 'Indonesia',
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 24),

            // --- BAGIAN 3: BANTUAN & INFO ---
            _buildSectionTitle('Pusat Bantuan & Info'),
            _buildSettingCard([
              _buildListTile(
                Icons.help_outline,
                'Pusat Bantuan (FAQ)',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FaqPage()),
                  );
                },
              ),
              _buildDivider(),
              _buildListTile(
                Icons.article_outlined,
                'Syarat & Ketentuan',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TermsPage()),
                  );
                },
              ),
              _buildDivider(),
              _buildListTile(
                Icons.privacy_tip_outlined,
                'Kebijakan Privasi',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PrivacyPage()),
                  );
                },
              ),
              _buildDivider(),
              _buildListTile(
                Icons.info_outline,
                'Tentang QurbanMart',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
              ),
            ]),
            const SizedBox(height: 30),

            // --- BAGIAN 4: KELUAR / LOGOUT ---
            // --- BAGIAN 4: KELUAR / LOGOUT ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Munculkan dialog konfirmasi sebelum benar-benar keluar
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          'Keluar Akun',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: const Text(
                          'Apakah Anda yakin ingin keluar dari aplikasi QurbanMart?',
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context), // Batal
                            child: const Text(
                              'Batal',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Hapus semua rute sebelumnya dan ke Halaman Login
                              Navigator.pushAndRemoveUntil(
                                context,
                                // Ganti LoginPage() sesuai dengan class Login Anda
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Keluar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade50,
                  foregroundColor: const Color.fromARGB(255, 27, 99, 5),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.red.shade100),
                  ),
                ),
                child: const Text(
                  'Keluar Akun',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- VERSI APLIKASI ---
            Center(
              child: Text(
                'QurbanMart v1.0.0',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER ---

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xFF64748B), // Warna abu-abu kebiruan
        ),
      ),
    );
  }

  Widget _buildSettingCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.015),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListTile(
    IconData icon,
    String title, {
    String? trailingText,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
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
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1E293B),
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null) ...[
            Text(
              trailingText,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
            ),
            const SizedBox(width: 8),
          ],
          const Icon(Icons.chevron_right, color: Color(0xFFCBD5E1), size: 20),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
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
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1E293B),
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,
        activeTrackColor: _primaryGreen,
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: Colors.grey.shade300,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Colors.grey.shade100,
      indent: 56,
      endIndent: 16,
    );
  }
}
