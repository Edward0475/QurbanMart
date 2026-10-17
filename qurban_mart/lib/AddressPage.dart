import 'package:flutter/material.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  static const Color _primaryGreen = Color(0xFF166036);
  static const Color _lightBg = Color(0xFFFAFAFA);

  // Data dummy (sementara) alamat
  List<Map<String, dynamic>> addresses = [
    {
      'label': 'Rumah',
      'name': 'Edward Jeremy',
      'phone': '0812-3456-7890',
      'address': 'Jl. Melati No. 12, RT.01/RW.02, Cilandak, Jakarta Selatan, DKI Jakarta 12430',
      'isPrimary': true,
    },
    {
      'label': 'Kantor',
      'name': 'Edward Jeremy',
      'phone': '0812-3456-7890',
      'address': 'Gedung QurbanMart Tower Lt. 5, Jl. Jend. Sudirman Kav. 21, Setiabudi, Jakarta Selatan, DKI Jakarta 12920',
      'isPrimary': false,
    },
  ];

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
          'Alamat Saya',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          // DAFTAR ALAMAT
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                return _buildAddressCard(addresses[index], index);
              },
            ),
          ),

          // TOMBOL TAMBAH ALAMAT BARU
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Aksi tambah alamat
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  'Tambah Alamat Baru',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Desain Kartu Alamat
  Widget _buildAddressCard(Map<String, dynamic> addr, int index) {
    bool isPrimary = addr['isPrimary'];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPrimary ? _primaryGreen : Colors.grey.shade200,
          width: isPrimary ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                addr['label'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(width: 8),
              if (isPrimary)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F4EA),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Utama',
                    style: TextStyle(
                      color: _primaryGreen,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            addr['name'],
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            addr['phone'],
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Text(
            addr['address'],
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Ubah Alamat',
                    style: TextStyle(color: Color(0xFF334155), fontSize: 13),
                  ),
                ),
              ),
              if (!isPrimary) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // Mengubah alamat yang dipilih menjadi utama
                        for (var a in addresses) {
                          a['isPrimary'] = false;
                        }
                        addresses[index]['isPrimary'] = true;

                        // Memindahkan alamat utama ke urutan paling atas
                        final primary = addresses.removeAt(index);
                        addresses.insert(0, primary);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: _primaryGreen,
                      elevation: 0,
                      side: const BorderSide(color: _primaryGreen),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Jadikan Utama',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
