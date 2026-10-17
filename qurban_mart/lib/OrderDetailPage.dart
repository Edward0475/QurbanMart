import 'package:flutter/material.dart';

class OrderDetailPage extends StatefulWidget {
  final Map<String, dynamic> animal;

  const OrderDetailPage({super.key, required this.animal});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage>
    with SingleTickerProviderStateMixin {
  static const Color _primaryGreen = Color(0xFF166036);
  static const Color _lightBg = Color(0xFFFAFAFA);
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 2 Tab: Pelacakan & Laporan
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _lightBg,
      appBar: AppBar(
        backgroundColor: _lightBg,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF1E293B),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detail Pesanan',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          // --- HEADER: INFO PESANAN & HEWAN ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '#QM20250612',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F4EA),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.share_location,
                            size: 14,
                            color: _primaryGreen,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Dalam Proses',
                            style: TextStyle(
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
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          widget.animal['image'] ?? 'Asset/image/Sapi.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, err, stack) => Container(
                            width: 80,
                            height: 80,
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
                              widget.animal['name'] ?? 'Sapi Limousin',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${widget.animal['weight'] ?? '350 kg'} • ${widget.animal['age'] ?? '2 tahun'}',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.animal['price'] ?? 'Rp 24.500.000',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: _primaryGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // --- TAB MENU (PELACAKAN & LAPORAN) ---
          TabBar(
            controller: _tabController,
            labelColor: _primaryGreen,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: _primaryGreen,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            tabs: const [
              Tab(text: 'Status Pelacakan'),
              Tab(text: 'Laporan Qurban'),
            ],
          ),

          // --- KONTEN TAB ---
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTrackingTab(), // Tab 1: Kiri (Peta & Timeline)
                _buildReportTab(), // Tab 2: Kanan (Video & Foto)
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // TAB 1: STATUS PELACAKAN (Gambar Kiri)
  // ==========================================
  Widget _buildTrackingTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // TIMELINE
        _buildTimelineItem(
          title: 'Pesanan Diterima',
          time: '12 Jun 2025 • 10:24',
          desc: 'Pesanan Anda telah diterima.',
          isDone: true,
        ),
        _buildTimelineItem(
          title: 'Pemeriksaan Kesehatan Hewan',
          time: '12 Jun 2025 • 13:50',
          desc: 'Hewan sedang diperiksa oleh dokter hewan.',
          isDone: true,
        ),
        _buildTimelineItem(
          title: 'Hewan Sedang Dikirim',
          time: '13 Jun 2025 • 08:00',
          desc: 'Hewan dalam perjalanan ke lokasi Anda.',
          isDone: true,
        ),
        _buildTimelineItem(
          title: 'Selesai',
          time: 'Akan diinformasikan setelah proses selesai.',
          desc: '',
          isDone: false,
          isLast: true,
        ),
        const SizedBox(height: 24),

        // LOKASI TERKINI (MAPS DUMMY)
        const Text(
          'Lokasi Terkini',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blue.shade100),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, size: 40, color: _primaryGreen),
                Text(
                  'Peta Pengiriman (Ilustrasi)',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.check_circle, color: _primaryGreen),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dalam perjalanan',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  'Estimasi tiba: 13 Jun 2025 • 15:00',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String time,
    required String desc,
    required bool isDone,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              isDone ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isDone ? _primaryGreen : Colors.grey.shade400,
              size: 24,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isDone ? _primaryGreen : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: isDone ? Colors.black : Colors.grey,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                time,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
              if (desc.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================
  // TAB 2: LAPORAN QURBAN (Gambar Kanan)
  // ==========================================
  Widget _buildReportTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Laporan Penyaluran',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),

        // VIDEO THUMBNAIL
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: AssetImage(
                'Asset/image/Person.png',
              ), // Ganti dengan asset panti asuhan jika ada
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 36,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // DESKRIPSI LAPORAN
        const Text(
          'Penyaluran daging ke Panti Asuhan Al-Falah',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '13 Jun 2025 • 14:20',
          style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
        ),
        const SizedBox(height: 8),
        Text(
          'Daging telah diterima oleh pihak panti asuhan dan sudah didistribusikan kepada anak-anak. Proses berjalan lancar dan transparan.',
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 13,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),

        // DOKUMENTASI (FOTO KECIL)
        const Text(
          'Dokumentasi',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDocPhoto('Asset/image/Sapi.png'), // Gunakan placeholder
            _buildDocPhoto('Asset/image/Van.png'),
            _buildDocPhoto('Asset/image/Person.png'),
          ],
        ),
        const SizedBox(height: 16),

        // TOMBOL LIHAT SEMUA
        SizedBox(
          width: double.infinity,
          height: 45,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: _primaryGreen),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Lihat Semua Foto & Video',
              style: TextStyle(
                color: _primaryGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // BANNER TERIMA KASIH
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE6F4EA),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            children: [
              Icon(Icons.verified_user, color: _primaryGreen, size: 30),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Terima kasih telah berkurban bersama kami. Semoga menjadi amal jariyah.',
                  style: TextStyle(
                    color: _primaryGreen,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDocPhoto(String path) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        path,
        width: 100,
        height: 80,
        fit: BoxFit.cover,
        errorBuilder: (ctx, err, stack) => Container(
          width: 100,
          height: 80,
          color: Colors.grey.shade200,
          child: const Icon(Icons.image),
        ),
      ),
    );
  }
}
