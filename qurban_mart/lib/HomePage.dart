import 'package:flutter/material.dart';

import 'AccountPage.dart';
import 'CartPage.dart';
import 'OrderPage.dart';
import 'Favorite.dart';
import 'SearchPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color primaryGreen = Color(0xFF0F5A38);
  static const Color darkGreen = Color(0xFF123B2B);
  static const Color lightGreen = Color(0xFFE8F3ED);
  static const Color cream = Color(0xFFFFF7E6);

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF9),

      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =========================
                // HEADER
                // =========================
                _buildHeader(),

                const SizedBox(height: 10),

                // =========================
                // BANNER
                // =========================
                _buildHeroBanner(),

                const SizedBox(height: 20),

                // =========================
                // SEARCH
                // =========================
                _buildSearchBar(),

                const SizedBox(height: 28),

                // =========================
                // KATEGORI KURBAN
                // =========================
                _buildCategorySection(),

                const SizedBox(height: 30),

                // =========================
                // PILIHAN HEWAN
                // =========================
                _buildAnimalSection(),

                const SizedBox(height: 28),

                // =========================
                // TRUST BANNER
                // =========================
                _buildTrustBanner(),
              ],
            ),
          ),

          // =========================
          // BOTTOM NAVIGATION
          // =========================
          Positioned(
            left: 18,
            right: 18,
            bottom: 18,
            child: _buildBottomNavigation(),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
        child: Row(
          children: [
            // LOGO
            Container(
              height: 48,
              width: 48,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: lightGreen,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Image.asset(
                'Asset/image/QurbanMart.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.pets,
                    color: primaryGreen,
                    size: 28,
                  );
                },
              ),
            ),

            const SizedBox(width: 12),

            // TITLE
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'QurbanKu',
                    style: TextStyle(
                      color: darkGreen,
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Berkah untuk Semua',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // NOTIFICATION
            _headerButton(
              Icons.notifications_none_rounded,
              () {},
            ),

            const SizedBox(width: 8),

            // CART
            _headerButton(
              Icons.shopping_bag_outlined,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerButton(
    IconData icon,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(13),
        child: Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Icon(
            icon,
            color: darkGreen,
            size: 22,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HERO BANNER
  // ============================================================

  Widget _buildHeroBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(
          'Asset/image/QA.png',
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // ============================================================
  // SEARCH BAR
  // ============================================================

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchPage(),
            ),
          );
        },
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 17),

              Icon(
                Icons.search_rounded,
                color: Colors.grey.shade500,
                size: 23,
              ),

              const SizedBox(width: 11),

              Text(
                'Cari hewan, paket aqiqah, atau peternak...',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // CATEGORY
  // ============================================================

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Kategori Kurban',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: darkGreen,
            ),
          ),
        ),

        const SizedBox(height: 16),

        SizedBox(
          height: 125,
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            scrollDirection: Axis.horizontal,
            children: [
              // SAPI
              _categoryItem(
                'Asset/image/logoSapi.png',
                'Sapi',
              ),

              const SizedBox(width: 28),

              // KAMBING
              _categoryItem(
                'Asset/image/logoKambing.png',
                'Kambing',
              ),

              const SizedBox(width: 28),

              // DOMBA
              _categoryItem(
                'Asset/image/logoDomba.png',
                'Domba',
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // CATEGORY ITEM
  // ============================================================

  Widget _categoryItem(
    String imagePath,
    String title,
  ) {
    return SizedBox(
      width: 70,
      child: Column(
        children: [
          Container(
            height: 68,
            width: 68,
            decoration: BoxDecoration(
              color: cream,
              borderRadius: BorderRadius.circular(17),
            ),

            child: Center(
              child: Image.asset(
                imagePath,
                width: 40,
                height: 40,
                fit: BoxFit.contain,

                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.grey,
                    size: 30,
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 9),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: darkGreen,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PILIHAN HEWAN
  // ============================================================

  Widget _buildAnimalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pilihan Hewan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: darkGreen,
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchPage(),
                    ),
                  );
                },
                child: const Row(
                  children: [
                    Text(
                      'Lihat Semua',
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Icon(
                      Icons.chevron_right_rounded,
                      color: primaryGreen,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 15),

        SizedBox(
          height: 210,
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            scrollDirection: Axis.horizontal,
            children: [
              // ==========================
              // KAMBING
              // ==========================

              _animalCard(
                title: 'Kambing',
                subtitle: 'Kambing pilihan',
                image: 'Asset/image/Kambing.png',
                price: 'Mulai Rp2,5 jt',
              ),

              const SizedBox(width: 14),

              // ==========================
              // SAPI LIMOSIN
              // ==========================

              _animalCard(
                title: 'Sapi Limosin',
                subtitle: 'Sapi premium',
                image: 'Asset/image/Limosin.png',
                price: 'Mulai Rp18 jt',
              ),

              const SizedBox(width: 14),

              // ==========================
              // DOMBA
              // ==========================

              _animalCard(
                title: 'Domba',
                subtitle: 'Domba sehat',
                image: 'Asset/image/Domba.png',
                price: 'Mulai Rp2,8 jt',
              ),

              const SizedBox(width: 14),

              // ==========================
              // SAPI BALI
              // ==========================

              _animalCard(
                title: 'Sapi Bali',
                subtitle: 'Sapi pilihan',
                image: 'Asset/image/Bali.png',
                price: 'Mulai Rp15 jt',
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ANIMAL CARD
  // ============================================================

  Widget _animalCard({
    required String title,
    required String subtitle,
    required String image,
    required String price,
  }) {
    return Container(
      width: 185,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      clipBehavior: Clip.antiAlias,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FOTO
          Stack(
            children: [
              Container(
                height: 115,
                width: double.infinity,
                color: const Color(0xFFF2F5F3),

                child: Image.asset(
                  image,
                  fit: BoxFit.cover,

                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey,
                        size: 38,
                      ),
                    );
                  },
                ),
              ),

              // FAVORITE BUTTON
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  height: 30,
                  width: 30,

                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.92),
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.favorite_border_rounded,
                    color: primaryGreen,
                    size: 17,
                  ),
                ),
              ),
            ],
          ),

          // INFORMASI
          Padding(
            padding: const EdgeInsets.fromLTRB(
              12,
              9,
              12,
              10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: darkGreen,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: primaryGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TRUST BANNER
  // ============================================================

  Widget _buildTrustBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 14,
        ),

        decoration: BoxDecoration(
          color: lightGreen,
          borderRadius: BorderRadius.circular(17),
        ),

        child: Row(
          children: [
            Container(
              height: 42,
              width: 42,

              decoration: const BoxDecoration(
                color: primaryGreen,
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.verified_rounded,
                color: Colors.white,
                size: 23,
              ),
            ),

            const SizedBox(width: 13),

            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transparan • Sehat • Terpercaya',
                    style: TextStyle(
                      color: primaryGreen,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  SizedBox(height: 3),

                  Text(
                    'Hewan pilihan dengan sertifikat kesehatan',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right_rounded,
              color: primaryGreen,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _buildBottomNavigation() {
    return Container(
      height: 67,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(38),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.09),
            blurRadius: 22,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          _bottomItem(
            Icons.home_rounded,
            'Home',
            0,
          ),

          _bottomItem(
            Icons.search_rounded,
            'Search',
            1,
          ),

          _bottomItem(
            Icons.favorite_border_rounded,
            'Favorit',
            2,
          ),

          _bottomItem(
            Icons.receipt_long_rounded,
            'Order',
            3,
          ),

          _bottomItem(
            Icons.person_outline_rounded,
            'Akun',
            4,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BOTTOM NAV ITEM
  // ============================================================

  Widget _bottomItem(
    IconData icon,
    String title,
    int index,
  ) {
    bool active = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        if (active) return;

        Widget? page;

        switch (index) {
          case 1:
            page = const SearchPage();
            break;

          case 2:
            page = const FavoritePage();
            break;

          case 3:
            page = const OrderPage();
            break;

          case 4:
            page = const AccountPage();
            break;
        }
        if (page != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => page!,
            ),
          );
        }
      },

      child: SizedBox(
        width: 58,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(
              icon,
              color: active
                  ? primaryGreen
                  : Colors.grey.shade400,
              size: 25,
            ),

            const SizedBox(height: 4),

            Text(
              title,
              style: TextStyle(
                color: active
                    ? primaryGreen
                    : Colors.grey.shade400,
                fontSize: 9.5,
                fontWeight: active
                    ? FontWeight.w800
                    : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}