
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'SearchPage.dart';
import 'OrderPage.dart';
import 'Favorite.dart';
import 'AccountPage.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() =>
      _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  static const Color primaryGreen = Color(0xFF078A4B);
  static const Color backgroundColor = Color(0xFFF8F9F7);

  // Data contoh notifikasi.
  // Nantinya bisa diganti dengan data dari backend.
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Pembayaran berhasil',
      'message':
          'Pembayaran pesanan Sapi Limosin berhasil dikonfirmasi.',
      'time': 'Baru saja',
      'type': 'payment',
      'read': false,
    },
    {
      'title': 'Pesanan sedang dikirim',
      'message':
          'Pesananmu sedang dalam proses pengiriman ke lokasi tujuan.',
      'time': '2 jam lalu',
      'type': 'shipping',
      'read': false,
    },
    {
      'title': 'Pesanan selesai',
      'message':
          'Pesanan Kambing Boer telah selesai. Terima kasih telah '
          'mempercayai QurbanMart!',
      'time': 'Kemarin',
      'type': 'success',
      'read': true,
    },
    {
      'title': 'Pengingat pembayaran',
      'message':
          'Jangan lupa menyelesaikan pembayaran pesananmu sebelum '
          'batas waktu berakhir.',
      'time': '2 hari lalu',
      'type': 'reminder',
      'read': true,
    },
  ];

  int get unreadCount =>
      notifications.where((item) => item['read'] == false).length;

  void markAllAsRead() {
    setState(() {
      for (final item in notifications) {
        item['read'] = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Semua notifikasi sudah dibaca.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void markAsRead(int index) {
    if (notifications[index]['read'] == true) return;

    setState(() {
      notifications[index]['read'] = true;
    });
  }

  void deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  IconData getIcon(String type) {
    switch (type) {
      case 'payment':
        return Icons.account_balance_wallet_outlined;
      case 'shipping':
        return Icons.local_shipping_outlined;
      case 'success':
        return Icons.check_circle_outline;
      case 'reminder':
        return Icons.access_time_rounded;
      default:
        return Icons.notifications_outlined;
    }
  }

  Color getIconColor(String type) {
    switch (type) {
      case 'payment':
        return const Color(0xFF078A4B);
      case 'shipping':
        return const Color(0xFF2563EB);
      case 'success':
        return const Color(0xFF078A4B);
      case 'reminder':
        return const Color(0xFFD97706);
      default:
        return Colors.grey;
    }
  }

  Color getIconBackground(String type) {
    switch (type) {
      case 'payment':
        return const Color(0xFFE3F5E9);
      case 'shipping':
        return const Color(0xFFE4EEFF);
      case 'success':
        return const Color(0xFFE3F5E9);
      case 'reminder':
        return const Color(0xFFFFF0D7);
      default:
        return const Color(0xFFF0F0F0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Notifikasi',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ),
                  if (unreadCount > 0)
                    TextButton(
                      onPressed: markAllAsRead,
                      style: TextButton.styleFrom(
                        foregroundColor: primaryGreen,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                      ),
                      child: const Text(
                        'Tandai semua dibaca',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const Divider(
              height: 1,
              color: Color(0xFFEEEEEE),
            ),

            // DAFTAR NOTIFIKASI / EMPTY STATE
            Expanded(
              child: notifications.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        16, 12, 16, 20,
                      ),
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final item = notifications[index];
                        final type = item['type'] as String;
                        final isRead = item['read'] as bool;

                        return Dismissible(
                          key: ValueKey(
                            '${item['title']}_${item['time']}',
                          ),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.only(right: 20),
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                              color: Colors.red.shade500,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                          onDismissed: (_) {
                            deleteNotification(index);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Notifikasi dihapus.',
                                ),
                              ),
                            );
                          },
                          child: InkWell(
                            onTap: () => markAsRead(index),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              margin: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: isRead
                                    ? Colors.white
                                    : const Color(0xFFF0F8F2),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isRead
                                      ? const Color(0xFFEEEEEE)
                                      : const Color(0xFFD5EBDD),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 46,
                                    height: 46,
                                    decoration: BoxDecoration(
                                      color: getIconBackground(type),
                                      borderRadius:
                                          BorderRadius.circular(14),
                                    ),
                                    child: Icon(
                                      getIcon(type),
                                      color: getIconColor(type),
                                      size: 24,
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                item['title'] as String,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: isRead
                                                      ? FontWeight.w600
                                                      : FontWeight.w800,
                                                  color: const Color(
                                                    0xFF222222,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (!isRead) ...[
                                              const SizedBox(width: 6),
                                              Container(
                                                width: 8,
                                                height: 8,
                                                margin:
                                                    const EdgeInsets.only(
                                                  top: 5,
                                                ),
                                                decoration:
                                                    const BoxDecoration(
                                                  color: primaryGreen,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),

                                        const SizedBox(height: 6),

                                        Text(
                                          item['message'] as String,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            height: 1.5,
                                            color: Color(0xFF666666),
                                          ),
                                        ),

                                        const SizedBox(height: 9),

                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.access_time,
                                              size: 13,
                                              color: Color(0xFF999999),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              item['time'] as String,
                                              style: const TextStyle(
                                                fontSize: 11,
                                                color: Color(0xFF999999),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // NAVIGASI BAWAH
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Color(0xFFE7F5EB),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_off_outlined,
                size: 76,
                color: Color(0xFF078A4B),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Belum ada notifikasi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF222222),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Notifikasi pesanan dan informasi terbaru '
              'akan muncul di sini.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.6,
                color: Color(0xFF777777),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 0.7,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          child: Row(
            children: [
              _navItem(
                icon: Icons.home_outlined,
                label: 'Beranda',
                onTap: () => _navigate(
                  context,
                  const HomePage(),
                ),
              ),
              _navItem(
                icon: Icons.search,
                label: 'Jelajahi',
                onTap: () => _navigate(
                  context,
                  const SearchPage(),
                ),
              ),
              _navItem(
                icon: Icons.receipt_long_outlined,
                label: 'Pesanan',
                onTap: () => _navigate(
                  context,
                  const OrderPage(),
                ),
              ),
              _navItem(
                icon: Icons.notifications,
                label: 'Notifikasi',
                selected: true,
                onTap: () {},
              ),
              _navItem(
                icon: Icons.person_outline,
                label: 'Profil',
                onTap: () => _navigate(
                  context,
                  const AccountPage(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigate(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool selected = false,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 23,
                color: selected
                    ? primaryGreen
                    : const Color(0xFF888888),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: selected
                      ? FontWeight.w700
                      : FontWeight.w500,
                  color: selected
                      ? primaryGreen
                      : const Color(0xFF888888),
                ),
              ),
              if (selected) ...[
                const SizedBox(height: 3),
                Container(
                  width: 18,
                  height: 3,
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
