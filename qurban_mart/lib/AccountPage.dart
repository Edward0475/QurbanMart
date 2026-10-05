import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'SearchPage.dart';
import 'Favorite.dart';
import 'OrderPage.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final Color _primaryGreen = const Color(0xFF0F5A38);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 60,
                    bottom: 40,
                    left: 24,
                    right: 24,
                  ),
                  decoration: BoxDecoration(
                    color: _primaryGreen,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=150&q=80',
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Edward Jeremy',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'edward@binus.ac.id',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Tabungan Kurban Feature Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Tabungan Kurban Saya',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Rp 4.500.000 / Rp 20.000.000',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: 0.225,
                          color: _primaryGreen,
                          backgroundColor: Colors.grey.shade200,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Cicilan rutin bulanan aktif. Target tercapai 22.5%',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomNavItem(
                    context,
                    Icons.home_outlined,
                    'Home',
                    false,
                    0,
                  ),
                  _buildBottomNavItem(
                    context,
                    Icons.search_outlined,
                    'Search',
                    false,
                    1,
                  ),
                  _buildBottomNavItem(
                    context,
                    Icons.favorite_border,
                    'Favorit',
                    false,
                    2,
                  ),
                  _buildBottomNavItem(
                    context,
                    Icons.receipt_long,
                    'Order',
                    false,
                    3,
                  ),
                  _buildBottomNavItem(
                    context,
                    Icons.person,
                    'Akun',
                    true,
                    4,
                  ), // Aktif
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(
    BuildContext context,
    IconData icon,
    String label,
    bool isSelected,
    int index,
  ) {
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
            nextScreen = const OrderPage();
            break;
          case 4:
            return;
          default:
            return;
        }
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => nextScreen,
            transitionDuration: Duration.zero,
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
//text
//sdwff
//Moonride
