import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'SearchPage.dart';
import 'Favorite.dart'; // Sesuaikan jika nama file Anda FavoritePage.dart
import 'AccountPage.dart';
import 'OrderDetailPage.dart';
import 'OrderManager.dart'; // <-- Penting untuk mengambil data pesanan

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  static const Color _primaryGreen = Color(0xFF166036);
  static const Color _backgroundColor = Color(0xFFFAFAFA);

  final int _selectedIndex = 3; // Index 3 Aktif untuk halaman Order

  @override
  Widget build(BuildContext context) {
    // Mengambil daftar pesanan dari Global State
    final orders = OrderManager.myOrders;

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Text(
                    'Riwayat Pesanan',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF222222),
                    ),
                  ),
                ),

                // DAFTAR PESANAN
                Expanded(
                  child: orders.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(
                            20,
                            10,
                            20,
                            120,
                          ), // Padding bawah agar tidak tertutup nav bar
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            return _buildOrderCard(orders[index]);
                          },
                        ),
                ),
              ],
            ),

            // --- BOTTOM NAVIGATION BAR MENGAMBANG ---
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBottomNavItem(Icons.home_outlined, 'Home', 0),
                    _buildBottomNavItem(Icons.search_outlined, 'Search', 1),
                    _buildBottomNavItem(Icons.favorite_border, 'Favorit', 2),
                    _buildBottomNavItem(
                      Icons.receipt_long,
                      'Order',
                      3,
                    ), // Aktif
                    _buildBottomNavItem(Icons.person_outline, 'Akun', 4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tampilan jika belum ada pesanan sama sekali
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum Ada Pesanan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ayo cari hewan Qurban terbaik untukmu!',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  // Kartu Pesanan Individual
  Widget _buildOrderCard(Map<String, dynamic> orderData) {
    final animal = orderData['animal']; // Ekstrak data hewan dari orderData

    return GestureDetector(
      onTap: () {
        // Jika ditekan, buka halaman OrderDetailPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailPage(animal: animal),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // BARIS ATAS: Order ID & Status Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  orderData['orderId'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade500,
                    fontSize: 13,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F4EA), // Latar Hijau Pudar
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.sync, size: 12, color: _primaryGreen),
                      const SizedBox(width: 4),
                      Text(
                        orderData['status'], // Teks "Dalam Proses"
                        style: const TextStyle(
                          color: _primaryGreen,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24, thickness: 1, color: Color(0xFFF1F5F9)),

            // BARIS TENGAH: Foto & Info Hewan
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    animal['image'] ?? 'Asset/image/Sapi.png',
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stack) => Container(
                      width: 70,
                      height: 70,
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        animal['name'] ?? 'Hewan Qurban',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${animal['weight'] ?? '-'} • ${animal['age'] ?? '-'}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // BARIS BAWAH: Total Harga
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Belanja',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
                Text(
                  animal['price'] ?? 'Rp 0',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: _primaryGreen,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // NAVIGATION BOTTOM NAV (TIDAK DIRUBAH)
  // ============================================================
  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        if (isSelected) return;
        Widget nextScreen;
        switch (index) {
          case 0:
            nextScreen = const HomePage();
            break;
          case 1:
            nextScreen = const SearchPage();
            break;
          case 2:
            nextScreen = const FavoritePage();
            break;
          case 3:
            return; // Sudah di halaman Order
          case 4:
            nextScreen = const AccountPage();
            break;
          default:
            return;
        }
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      child: Container(
        color: Colors.transparent,
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? _primaryGreen : Colors.grey.shade400,
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? _primaryGreen : Colors.grey.shade400,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
