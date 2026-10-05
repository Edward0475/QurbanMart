import 'package:flutter/material.dart';
import 'LoginPage.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'Asset/image/Onboarding1.png',
      'title': 'Pilih Hewan\nQurban Terbaik',
      'description':
          'Berbagai pilihan sapi, kambing,\ndan domba dari peternakan\nterpercaya.',
    },
    {
      'image': 'Asset/image/Onboarding2.png',
      'title': 'Transaksi Aman\ndan Terpercaya',
      'description':
          'Informasi lengkap, harga jelas,\ndan penjual terverifikasi.',
    },
    {
      'image': 'Asset/image/Onboarding3.png',
      'title': 'Pengiriman Hingga\nLokasi Tujuan',
      'description':
          'Tersedia layanan pengiriman\natau pembelian langsung\ndi peternakan.',
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToLogin();
    }
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EA),
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          itemCount: onboardingData.length,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            return _buildOnboardingPage(
              onboardingData[index],
              index,
            );
          },
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(
    Map<String, String> data,
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // =========================
          // TOP BAR
          // =========================
          SizedBox(
            height: 40,
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: _goToLogin,
                child: const Text(
                  'Lewati',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF0F5A38),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          // =========================
          // MAIN CARD
          // =========================
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.fromLTRB(
                10,
                15,
                10,
                14,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFEFA),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // =========================
                  // ILUSTRASI
                  // =========================
                  Expanded(
                    flex: 6,
                    child: Center(
                      child: Image.asset(
                        data['image']!,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // =========================
                  // TEXT
                  // =========================
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['title']!,
                              style: const TextStyle(
                                fontSize: 20,
                                height: 1.05,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF202520),
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              data['description']!,
                              style: TextStyle(
                                fontSize: 11,
                                height: 1.35,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // =========================
                  // BOTTOM CONTROL
                  // =========================
                  Row(
                    children: [
                      // INDICATOR
                      Expanded(
                        child: Row(
                          children: List.generate(
                            onboardingData.length,
                            (dotIndex) {
                              final bool active =
                                  dotIndex == _currentPage;

                              return AnimatedContainer(
                                duration: const Duration(
                                  milliseconds: 200,
                                ),
                                margin: const EdgeInsets.only(
                                  right: 4,
                                ),
                                width: active ? 13 : 4,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: active
                                      ? const Color(0xFF087A4B)
                                      : const Color(0xFFBFC9C2),
                                  borderRadius:
                                      BorderRadius.circular(5),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // BUTTON
                      if (index < 2)
                        GestureDetector(
                          onTap: _nextPage,
                          child: Container(
                            width: 43,
                            height: 43,
                            decoration: const BoxDecoration(
                              color: Color(0xFF087A4B),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 21,
                            ),
                          ),
                        ),
                    ],
                  ),

                  // =========================
                  // MULAI SEKARANG
                  // =========================
                  if (index == 2) ...[
                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: ElevatedButton(
                        onPressed: _goToLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF087A4B),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Mulai Sekarang',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}