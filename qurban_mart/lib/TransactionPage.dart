import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'OrderDetailPage.dart';
import 'OrderManager.dart';

class TransactionPage extends StatefulWidget {
  final Map<String, dynamic> animal;

  const TransactionPage({super.key, required this.animal});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  static const Color _primaryGreen = Color(0xFF166036);
  static const Color _lightGreen = Color(0xFFE6F4EA);
  static const Color _lightBg = Color(0xFFF8FAF8);

  int _selectedPenyaluran = 1; // 1: Kirim ke Rumah, 2: Titip Salurkan / Sedekah
  String _selectedPaymentMethod = '';

  // Data Alamat Pribadi
  int _selectedPersonalIndex = 0;
  final _personalAddresses = [
    {
      'label': 'Rumah Utama',
      'name': 'Ahmad Fauzi',
      'phone': '0812-8899-7766',
      'address': 'Jl. Melati Indah Blok B2 No. 14, Kel. Sukamaju, Kota Tangerang, Banten 15111',
    },
    {
      'label': 'Masjid Komplek',
      'name': 'Panitia Qurban Masjid Al-Muhajirin',
      'phone': '0813-4455-6677',
      'address': 'Jl. Bougenville Raya No. 8, Perumahan Griya Asri, Tangerang Selatan, Banten 15412',
    },
    {
      'label': 'Kantor',
      'name': 'Ahmad Fauzi (Resepsionis)',
      'phone': '0812-8899-7766',
      'address': 'Gedung Graha Kirana Lt. 5, Jl. Jend. Sudirman Kav. 21, Jakarta Selatan 12920',
    },
  ];

  // Data Tujuan Sedekah / Yayasan
  int _yayasanMode =
      0; // 0: Pilih Yayasan Mitra, 1: Tulis Alamat Yayasan Sendiri
  int _selectedYayasanIndex = 0;
  final _yayasanList = [
    {
      'label': 'Panti Asuhan Mitra',
      'name': 'Panti Asuhan Al-Falah',
      'pic': 'Ust. Ridwan',
      'phone': '0812-3456-7890',
      'address':
          'Jl. Raya Cibiru No. 45, Kec. Cibiru, Kota Bandung, Jawa Barat 40614',
      'quota': '120 Anak Asuh',
    },
    {
      'label': 'Yayasan Yatim Piatu',
      'name': 'Yayasan Yatim Piatu Nurul Iman',
      'pic': 'Hj. Siti Aminah',
      'phone': '0813-9876-5432',
      'address': 'Jl. KH. Ahmad Dahlan No. 18, Ciputat, Tangerang Selatan, Banten 15411',
      'quota': '85 Anak Asuh',
    },
    {
      'label': 'Pesantren Tahfidz',
      'name': 'Pesantren Tahfidz Darul Qur\'an',
      'pic': 'Ust. Fauzan',
      'phone': '0857-1122-3344',
      'address': 'Jl. Raya Puncak KM 72, Cisarua, Kab. Bogor, Jawa Barat 16750',
      'quota': '200 Santri',
    },
    {
      'label': 'Masjid & Dhuafa',
      'name': 'Masjid Jami Al-Ikhlas & Dhuafa',
      'pic': 'Bpk. Hendra',
      'phone': '0821-5566-7788',
      'address': 'Jl. Merdeka Selatan No. 102, Bekasi Barat, Kota Bekasi, Jawa Barat 17134',
      'quota': '150 Kepala Keluarga',
    },
  ];

  // Data input manual alamat yayasan
  String _customYayasanName = '';
  String _customYayasanPic = '';
  String _customYayasanPhone = '';
  String _customYayasanAddress = '';
  String _qurbanNote = 'Keluarga Besar H. Ahmad';

  // Getter tujuan aktif
  String get _activeBadgeLabel {
    if (_selectedPenyaluran == 1) {
      return _personalAddresses[_selectedPersonalIndex]['label'] ?? 'Alamat';
    }
    if (_yayasanMode == 1 && _customYayasanName.isNotEmpty) {
      return 'Yayasan Pilihan Sendiri';
    }
    return _yayasanList[_selectedYayasanIndex]['label'] ?? 'Yayasan Mitra';
  }

  String get _activeRecipientName {
    if (_selectedPenyaluran == 1) {
      return _personalAddresses[_selectedPersonalIndex]['name'] ?? '';
    }
    if (_yayasanMode == 1 && _customYayasanName.isNotEmpty) {
      return _customYayasanName;
    }
    return _yayasanList[_selectedYayasanIndex]['name'] ?? '';
  }

  String get _activeRecipientPhone {
    if (_selectedPenyaluran == 1) {
      return _personalAddresses[_selectedPersonalIndex]['phone'] ?? '';
    }
    if (_yayasanMode == 1 && _customYayasanName.isNotEmpty) {
      final pic = _customYayasanPic.isEmpty
          ? 'Pengurus Yayasan'
          : _customYayasanPic;
      final phone = _customYayasanPhone.isEmpty ? '-' : _customYayasanPhone;
      return '$pic • $phone';
    }
    final item = _yayasanList[_selectedYayasanIndex];
    return '${item['pic']} • ${item['phone']}';
  }

  String get _activeRecipientAddress {
    if (_selectedPenyaluran == 1) {
      return _personalAddresses[_selectedPersonalIndex]['address'] ?? '';
    }
    if (_yayasanMode == 1 && _customYayasanAddress.isNotEmpty) {
      return _customYayasanAddress;
    }
    return _yayasanList[_selectedYayasanIndex]['address'] ?? '';
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade700 : _primaryGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // =========================================================================
  // MODAL BOTTOM SHEET 1: UBAH / TAMBAH ALAMAT PRIBADI
  // =========================================================================
  void _showPersonalAddressSheet() {
    int tempIndex = _selectedPersonalIndex;
    bool isAddingNew = false;

    final labelCtrl = TextEditingController(text: 'Rumah Baru');
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final addressCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final bottomInset = MediaQuery.of(context).viewInsets.bottom;

            return Padding(
              padding: EdgeInsets.fromLTRB(20, 14, 20, bottomInset + 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 42,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Alamat Pengiriman Hewan',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        if (isAddingNew)
                          TextButton(
                            onPressed: () =>
                                setModalState(() => isAddingNew = false),
                            child: const Text(
                              'Pilih Tersimpan',
                              style: TextStyle(
                                color: _primaryGreen,
                                fontWeight: FontWeight.w700,
                                fontSize: 12.5,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isAddingNew
                          ? 'Masukkan detail alamat tujuan pengiriman hewan kurban.'
                          : 'Pilih alamat tujuan atau tambahkan alamat pengiriman baru.',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 16),

                    if (!isAddingNew) ...[
                      ...List.generate(_personalAddresses.length, (index) {
                        final addr = _personalAddresses[index];
                        final isChosen = tempIndex == index;
                        return GestureDetector(
                          onTap: () => setModalState(() => tempIndex = index),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(13),
                            decoration: BoxDecoration(
                              color: isChosen
                                  ? _lightGreen.withValues(alpha: 0.45)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isChosen
                                    ? _primaryGreen
                                    : Colors.grey.shade200,
                                width: isChosen ? 1.5 : 1,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  isChosen
                                      ? Icons.radio_button_checked_rounded
                                      : Icons.radio_button_off_rounded,
                                  color: isChosen
                                      ? _primaryGreen
                                      : Colors.grey.shade400,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _lightGreen,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              addr['label'] ?? 'Alamat',
                                              style: const TextStyle(
                                                fontSize: 10.5,
                                                fontWeight: FontWeight.w800,
                                                color: _primaryGreen,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              addr['name'] ?? '',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 13.5,
                                                color: Color(0xFF0F172A),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        addr['phone'] ?? '',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        addr['address'] ?? '',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                          height: 1.35,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 4),
                      OutlinedButton.icon(
                        onPressed: () =>
                            setModalState(() => isAddingNew = true),
                        icon: const Icon(
                          Icons.add_location_alt_outlined,
                          size: 18,
                        ),
                        label: const Text(
                          'Tulis / Tambah Alamat Baru',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _primaryGreen,
                          side: const BorderSide(color: _primaryGreen),
                          minimumSize: const Size(double.infinity, 44),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ] else ...[
                      _buildInputField(
                        controller: labelCtrl,
                        label: 'Label Alamat',
                        hint: 'Contoh: Rumah Orang Tua / Masjid Al-Ikhlas',
                        icon: Icons.bookmark_border_rounded,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _buildInputField(
                              controller: nameCtrl,
                              label: 'Nama Penerima',
                              hint: 'Nama lengkap',
                              icon: Icons.person_outline_rounded,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildInputField(
                              controller: phoneCtrl,
                              label: 'No. Telepon',
                              hint: '0812-xxxx-xxxx',
                              icon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildInputField(
                        controller: addressCtrl,
                        label: 'Alamat Lengkap',
                        hint: 'Jalan, nomor rumah, RT/RW, kecamatan, kota...',
                        icon: Icons.location_on_outlined,
                        maxLines: 3,
                      ),
                    ],

                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isAddingNew) {
                            if (nameCtrl.text.trim().isEmpty ||
                                addressCtrl.text.trim().isEmpty) {
                              _showSnackBar(
                                'Mohon lengkapi nama penerima dan alamat lengkap.',
                                isError: true,
                              );
                              return;
                            }
                            setState(() {
                              _personalAddresses.insert(0, {
                                'label': labelCtrl.text.trim().isEmpty
                                    ? 'Alamat Baru'
                                    : labelCtrl.text.trim(),
                                'name': nameCtrl.text.trim(),
                                'phone': phoneCtrl.text.trim().isEmpty
                                    ? '-'
                                    : phoneCtrl.text.trim(),
                                'address': addressCtrl.text.trim(),
                              });
                              _selectedPersonalIndex = 0;
                            });
                            Navigator.pop(context);
                            _showSnackBar('Alamat pengiriman baru disimpan!');
                          } else {
                            setState(() {
                              _selectedPersonalIndex = tempIndex;
                            });
                            Navigator.pop(context);
                            _showSnackBar('Alamat pengiriman diperbarui!');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryGreen,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          isAddingNew
                              ? 'Simpan & Gunakan Alamat'
                              : 'Gunakan Alamat Ini',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // =========================================================================
  // MODAL BOTTOM SHEET 2: PILIH YAYASAN MITRA ATAU TULIS ALAMAT YAYASAN
  // =========================================================================
  void _showYayasanSheet({int initialTab = 0}) {
    int tempMode = initialTab;
    int tempYayasanIndex = _selectedYayasanIndex;

    final yayasanNameCtrl = TextEditingController(text: _customYayasanName);
    final yayasanPicCtrl = TextEditingController(text: _customYayasanPic);
    final yayasanPhoneCtrl = TextEditingController(text: _customYayasanPhone);
    final yayasanAddrCtrl = TextEditingController(text: _customYayasanAddress);
    final noteCtrl = TextEditingController(text: _qurbanNote);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final bottomInset = MediaQuery.of(context).viewInsets.bottom;

            return Padding(
              padding: EdgeInsets.fromLTRB(20, 14, 20, bottomInset + 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 42,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Tujuan Sedekah Qurban',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Pilih yayasan mitra QurbanMart atau tulis alamat yayasan/masjid tujuan Anda sendiri.',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Segmented Tab: Pilih Yayasan vs Tulis Alamat Yayasan
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF3F0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setModalState(() => tempMode = 0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: tempMode == 0
                                      ? _primaryGreen
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Pilih Yayasan Mitra',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w700,
                                    color: tempMode == 0
                                        ? Colors.white
                                        : Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setModalState(() => tempMode = 1),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: tempMode == 1
                                      ? _primaryGreen
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Tulis Alamat Yayasan',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w700,
                                    color: tempMode == 1
                                        ? Colors.white
                                        : Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // TAB 0: DAFTAR YAYASAN MITRA
                    if (tempMode == 0) ...[
                      ...List.generate(_yayasanList.length, (index) {
                        final yayasan = _yayasanList[index];
                        final isChosen = tempYayasanIndex == index;
                        return GestureDetector(
                          onTap: () =>
                              setModalState(() => tempYayasanIndex = index),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isChosen
                                  ? _lightGreen.withValues(alpha: 0.45)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isChosen
                                    ? _primaryGreen
                                    : Colors.grey.shade200,
                                width: isChosen ? 1.5 : 1,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  isChosen
                                      ? Icons.radio_button_checked_rounded
                                      : Icons.radio_button_off_rounded,
                                  color: isChosen
                                      ? _primaryGreen
                                      : Colors.grey.shade400,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              yayasan['name'] ?? '',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 13.5,
                                                color: Color(0xFF0F172A),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 7,
                                              vertical: 3,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _lightGreen,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              yayasan['quota'] ?? '',
                                              style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                color: _primaryGreen,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        '${yayasan['pic']} • ${yayasan['phone']}',
                                        style: TextStyle(
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        yayasan['address'] ?? '',
                                        style: TextStyle(
                                          fontSize: 11.5,
                                          color: Colors.grey.shade600,
                                          height: 1.35,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],

                    // TAB 1: TULIS ALAMAT YAYASAN SENDIRI
                    if (tempMode == 1) ...[
                      _buildInputField(
                        controller: yayasanNameCtrl,
                        label: 'Nama Yayasan / Panti / Masjid',
                        hint: 'Contoh: Panti Asuhan Nurul Hidayah',
                        icon: Icons.mosque_outlined,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _buildInputField(
                              controller: yayasanPicCtrl,
                              label: 'Nama Pengurus (PIC)',
                              hint: 'Contoh: Ust. Salman',
                              icon: Icons.person_outline_rounded,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildInputField(
                              controller: yayasanPhoneCtrl,
                              label: 'No. HP Pengurus',
                              hint: '0812-xxxx-xxxx',
                              icon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildInputField(
                        controller: yayasanAddrCtrl,
                        label: 'Alamat Lengkap Yayasan',
                        hint: 'Masukkan jalan, RT/RW, kelurahan, kecamatan, kota...',
                        icon: Icons.location_on_outlined,
                        maxLines: 3,
                      ),
                    ],

                    const SizedBox(height: 10),
                    _buildInputField(
                      controller: noteCtrl,
                      label: 'Atas Nama Pekurban / Doa',
                      hint: 'Contoh: Keluarga Besar H. Ahmad',
                      icon: Icons.edit_note_rounded,
                    ),

                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (tempMode == 1) {
                            if (yayasanNameCtrl.text.trim().isEmpty ||
                                yayasanAddrCtrl.text.trim().isEmpty) {
                              _showSnackBar(
                                'Mohon isi nama yayasan dan alamat lengkapnya.',
                                isError: true,
                              );
                              return;
                            }
                          }

                          setState(() {
                            _yayasanMode = tempMode;
                            _selectedYayasanIndex = tempYayasanIndex;
                            _customYayasanName = yayasanNameCtrl.text.trim();
                            _customYayasanPic = yayasanPicCtrl.text.trim();
                            _customYayasanPhone = yayasanPhoneCtrl.text.trim();
                            _customYayasanAddress = yayasanAddrCtrl.text.trim();
                            _qurbanNote = noteCtrl.text.trim();
                          });

                          Navigator.pop(context);
                          _showSnackBar(
                            'Tujuan sedekah diperbarui ke $_activeRecipientName',
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryGreen,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Simpan Tujuan Sedekah',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
            prefixIcon: Icon(icon, size: 18, color: _primaryGreen),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 11,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _primaryGreen, width: 1.4),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isSedekah = _selectedPenyaluran == 2;

    return Scaffold(
      backgroundColor: _lightBg,
      appBar: AppBar(
        backgroundColor: _lightBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF1E293B),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _lightGreen,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified_user_rounded,
                  size: 14,
                  color: _primaryGreen,
                ),
                SizedBox(width: 4),
                Text(
                  'Amanah & Terjamin',
                  style: TextStyle(
                    color: _primaryGreen,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- 1. RINGKASAN HEWAN KURBAN ---
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.025),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            (widget.animal['image'] ?? 'Asset/image/Sapi.png')
                                .toString(),
                            width: 76,
                            height: 76,
                            fit: BoxFit.cover,
                            errorBuilder: (ctx, err, stack) => Container(
                              width: 76,
                              height: 76,
                              color: _lightGreen,
                              child: const Icon(
                                Icons.pets_rounded,
                                color: _primaryGreen,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2.5,
                                ),
                                decoration: BoxDecoration(
                                  color: _lightGreen,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  (widget.animal['seller'] ?? 'Berkah Farmer')
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    color: _primaryGreen,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                (widget.animal['name'] ?? 'Sapi Limousin')
                                    .toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15.5,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${widget.animal['weight'] ?? '350 kg'} • ${widget.animal['age'] ?? '2 tahun'}',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                (widget.animal['price'] ?? 'Rp 24.500.000')
                                    .toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
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
                  const SizedBox(height: 20),

                  // --- 2. METODE PENYALURAN ---
                  const Text(
                    'Metode Penyaluran',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 10),

                  _buildPenyaluranCard(
                    value: 1,
                    title: 'Kirim ke Rumah / Masjid Pribadi',
                    subtitle: 'Hewan dikirim hidup-hidup menggunakan mobil pikap ke alamat Anda.',
                    imagePath: 'Asset/image/Van.png',
                  ),
                  const SizedBox(height: 12),

                  _buildPenyaluranCard(
                    value: 2,
                    title: 'Titip Salurkan / Sedekah',
                    subtitle: 'Hewan disembelih oleh mitra peternak, dagingnya disalurkan ke Yayasan / Panti Asuhan.',
                    imagePath: 'Asset/image/Person.png',
                  ),
                  const SizedBox(height: 18),

                  // --- 3. KARTU ALAMAT PENGIRIMAN / TUJUAN YAYASAN SEDEKAH ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isSedekah
                            ? 'Tujuan Yayasan / Sedekah'
                            : 'Alamat Pengiriman',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          if (isSedekah) {
                            _showYayasanSheet(initialTab: _yayasanMode);
                          } else {
                            _showPersonalAddressSheet();
                          }
                        },
                        icon: const Icon(
                          Icons.edit_location_alt_rounded,
                          size: 16,
                          color: _primaryGreen,
                        ),
                        label: Text(
                          isSedekah ? 'Ubah Tujuan' : 'Ubah Alamat',
                          style: const TextStyle(
                            color: _primaryGreen,
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: _primaryGreen.withValues(alpha: 0.35),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.025),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _lightGreen,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isSedekah
                                        ? Icons.volunteer_activism_rounded
                                        : Icons.location_on_rounded,
                                    size: 14,
                                    color: _primaryGreen,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    _activeBadgeLabel,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                      color: _primaryGreen,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                if (isSedekah) {
                                  _showYayasanSheet(initialTab: _yayasanMode);
                                } else {
                                  _showPersonalAddressSheet();
                                }
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: _lightGreen.withValues(alpha: 0.6),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Ganti',
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w800,
                                    color: _primaryGreen,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _activeRecipientName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14.5,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _activeRecipientPhone,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Icon(
                                Icons.pin_drop_rounded,
                                size: 15,
                                color: _primaryGreen,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                _activeRecipientAddress,
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: Colors.grey.shade600,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Opsi Khusus Sedekah: Pilih Yayasan vs Tulis Alamat Yayasan
                        if (isSedekah) ...[
                          const SizedBox(height: 12),
                          Divider(height: 1, color: Colors.grey.shade200),
                          const SizedBox(height: 10),
                          if (_qurbanNote.isNotEmpty) ...[
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.volunteer_activism_outlined,
                                    size: 15,
                                    color: _primaryGreen,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      'Atas nama: $_qurbanNote',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () =>
                                      _showYayasanSheet(initialTab: 0),
                                  icon: const Icon(
                                    Icons.apartment_rounded,
                                    size: 16,
                                  ),
                                  label: const Text(
                                    'Pilih Yayasan',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: _yayasanMode == 0
                                        ? Colors.white
                                        : _primaryGreen,
                                    backgroundColor: _yayasanMode == 0
                                        ? _primaryGreen
                                        : Colors.white,
                                    side: const BorderSide(
                                      color: _primaryGreen,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 9,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () =>
                                      _showYayasanSheet(initialTab: 1),
                                  icon: const Icon(
                                    Icons.edit_note_rounded,
                                    size: 18,
                                  ),
                                  label: const Text(
                                    'Tulis Alamat',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: _yayasanMode == 1
                                        ? Colors.white
                                        : _primaryGreen,
                                    backgroundColor: _yayasanMode == 1
                                        ? _primaryGreen
                                        : Colors.white,
                                    side: const BorderSide(
                                      color: _primaryGreen,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 9,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  // --- 4. METODE PEMBAYARAN ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Metode Pembayaran',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      if (_selectedPaymentMethod.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: _lightGreen,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _selectedPaymentMethod,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: _primaryGreen,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: Column(
                        children: [
                          _buildPaymentExpansion(
                            icon: Icons.account_balance_outlined,
                            title: 'Transfer Bank',
                            options: const [
                              'BCA Virtual Account',
                              'Mandiri Virtual Account',
                              'BNI Virtual Account',
                              'BRI Virtual Account',
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Colors.grey.shade200,
                            indent: 16,
                            endIndent: 16,
                          ),
                          _buildPaymentExpansion(
                            icon: Icons.account_balance_wallet_outlined,
                            title: 'E-wallet',
                            subtitle: '(OVO, DANA, GoPay, ShopeePay)',
                            options: const [
                              'OVO',
                              'DANA',
                              'GoPay',
                              'ShopeePay',
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Colors.grey.shade200,
                            indent: 16,
                            endIndent: 16,
                          ),
                          _buildPaymentExpansion(
                            icon: Icons.credit_card_outlined,
                            title: 'Kartu Kredit/Debit',
                            options: const ['Visa / Mastercard', 'JCB'],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- 5. RINCIAN BIAYA ---
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Rincian Pembayaran',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14.5,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildCostRow(
                          'Harga Hewan Kurban',
                          (widget.animal['price'] ?? 'Rp 24.500.000')
                              .toString(),
                        ),
                        const SizedBox(height: 8),
                        _buildCostRow(
                          isSedekah
                              ? 'Biaya Penyembelihan & Distribusi'
                              : 'Ongkos Kirim Armada Pikap',
                          'Gratis',
                          valueColor: _primaryGreen,
                        ),
                        const SizedBox(height: 8),
                        _buildCostRow(
                          'Biaya Layanan Aplikasi',
                          'Rp 0',
                          valueColor: _primaryGreen,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Divider(
                            height: 1,
                            color: Colors.grey.shade200,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Tagihan',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              (widget.animal['price'] ?? 'Rp 24.500.000')
                                  .toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                color: _primaryGreen,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // --- BOTTOM BAR ---
          Container(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 26),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Pembayaran',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          isSedekah
                              ? 'Sedekah ke $_activeRecipientName'
                              : 'Kirim ke $_activeBadgeLabel',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: _primaryGreen,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      (widget.animal['price'] ?? 'Rp 24.500.000').toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: _primaryGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_selectedPaymentMethod.isEmpty) {
                        _showSnackBar(
                          'Silakan pilih metode pembayaran terlebih dahulu.',
                          isError: true,
                        );
                        return;
                      }

                      final enrichedOrder = {
                        ...widget.animal,
                        'penyaluran': isSedekah
                            ? 'Titip Salurkan / Sedekah'
                            : 'Kirim ke Rumah / Masjid Pribadi',
                        'recipientName': _activeRecipientName,
                        'recipientPhone': _activeRecipientPhone,
                        'recipientAddress': _activeRecipientAddress,
                        'qurbanNote': _qurbanNote,
                        'paymentMethod': _selectedPaymentMethod,
                      };

                      OrderManager.addOrder(enrichedOrder);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PaymentSuccessPage(animal: enrichedOrder),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Bayar Sekarang',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostRow(
    String label,
    String value, {
    Color valueColor = const Color(0xFF1E293B),
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPenyaluranCard({
    required int value,
    required String title,
    required String subtitle,
    required String imagePath,
  }) {
    final bool isSelected = _selectedPenyaluran == value;

    return GestureDetector(
      onTap: () => setState(() => _selectedPenyaluran = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected
              ? _lightGreen.withValues(alpha: 0.45)
              : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? _primaryGreen : Colors.grey.shade200,
            width: isSelected ? 1.6 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color: isSelected ? _primaryGreen : Colors.grey.shade400,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: isSelected
                          ? _primaryGreen
                          : const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: 64,
                height: 64,
                fit: BoxFit.contain,
                errorBuilder: (ctx, err, stack) => Container(
                  width: 64,
                  height: 64,
                  color: _lightGreen,
                  child: const Icon(
                    Icons.local_shipping_rounded,
                    size: 28,
                    color: _primaryGreen,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentExpansion({
    required IconData icon,
    required String title,
    String? subtitle,
    required List options,
  }) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _lightGreen.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: _primaryGreen, size: 20),
      ),
      title: RichText(
        text: TextSpan(
          text: title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Color(0xFF1E293B),
          ),
          children: [
            if (subtitle != null)
              TextSpan(
                text: ' $subtitle',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: Colors.grey.shade500,
                ),
              ),
          ],
        ),
      ),
      iconColor: _primaryGreen,
      children: options.map((option) {
        final String optionName = option.toString();
        final bool isSelected = _selectedPaymentMethod == optionName;

        return InkWell(
          onTap: () {
            setState(() {
              _selectedPaymentMethod = optionName;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            color: isSelected
                ? _lightGreen.withValues(alpha: 0.45)
                : Colors.transparent,
            child: Row(
              children: [
                Icon(
                  isSelected
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_off_rounded,
                  size: 20,
                  color: isSelected ? _primaryGreen : Colors.grey.shade400,
                ),
                const SizedBox(width: 14),
                Text(
                  optionName,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: isSelected
                        ? FontWeight.w700
                        : FontWeight.normal,
                    color: isSelected ? _primaryGreen : const Color(0xFF334155),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// =====================================================================
// HALAMAN STATUS PEMBAYARAN BERHASIL
// =====================================================================
class PaymentSuccessPage extends StatefulWidget {
  final Map<String, dynamic>? animal;

  const PaymentSuccessPage({super.key, this.animal});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  static const Color _primaryGreen = Color(0xFF166036);
  double _scale = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _scale = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderAnimal =
        widget.animal ??
        {
          'name': 'Sapi Limousin',
          'price': 'Rp 24.500.000',
          'weight': '350 kg',
          'age': '2 tahun',
          'image': 'Asset/image/Sapi.png',
        };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedScale(
                  scale: _scale,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.elasticOut,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F4EA),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _primaryGreen.withValues(alpha: 0.3),
                        width: 8,
                      ),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: _primaryGreen,
                      size: 80,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Pembayaran Berhasil!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Terima kasih. Transaksi Qurban Anda telah kami terima dan akan segera diproses.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 44),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Kembali ke Beranda',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OrderDetailPage(animal: orderAnimal),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _primaryGreen,
                      side: const BorderSide(color: _primaryGreen, width: 1.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Lihat Detail Pesanan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
