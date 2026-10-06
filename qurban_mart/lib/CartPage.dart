// lib/CartPage.dart
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang Kurban')),
      body: const Center(child: Text('Keranjang Belanja Kosong')),
    );
  }
}

// lib/MenuPage.dart

class MenuPage extends StatelessWidget {
  final String restaurantName;
  final String imagePath;
  final bool isNetworkImage;
  final List<dynamic> menus;

  const MenuPage({
    super.key,
    required this.restaurantName,
    required this.imagePath,
    required this.isNetworkImage,
    required this.menus,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(restaurantName)),
      body: ListView.builder(
        itemCount: menus.length,
        itemBuilder: (context, index) {
          final menu = menus[index];
          return ListTile(
            title: Text(menu['name'] ?? ''),
            subtitle: Text(menu['price'] ?? ''),
          );
        },
      ),
    );
  }
}