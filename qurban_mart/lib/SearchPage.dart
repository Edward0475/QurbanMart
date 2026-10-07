import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedCategory = 'Semua';

  final List<String> _categories = [
    'Semua',
    'Sapi',
    'Kambing',
    'Domba',
  ];

  final List<Map<String, dynamic>> _animals = [
    {
      'name': 'Sapi Limousin',
      'category': 'Sapi',
      'weight': '350 kg',
      'age': '2 tahun',
      'location': 'Bogor, Jawa Barat',
      'price': 'Rp 24.500.000',
      'image': 'Asset/image/Sapi.png',
      'favorite': false,
    },
    {
      'name': 'Sapi Simmental',
      'category': 'Sapi',
      'weight': '400 kg',
      'age': '3 tahun',
      'location': 'Depok, Jawa Barat',
      'price': 'Rp 28.000.000',
      'image': 'Asset/image/Bali.png',
      'favorite': false,
    },
    {
      'name': 'Kambing Boer',
      'category': 'Kambing',
      'weight': '38 kg',
      'age': '1 tahun',
      'location': 'Sleman, DI Yogyakarta',
      'price': 'Rp 3.200.000',
      'image': 'Asset/image/Boer.png',
      'favorite': false,
    },
    {
      'name': 'Kambing Etawa',
      'category': 'Kambing',
      'weight': '45 kg',
      'age': '1,5 tahun',
      'location': 'Bandung, Jawa Barat',
      'price': 'Rp 3.800.000',
      'image': 'Asset/image/Kambing.png',
      'favorite': false,
    },
    {
      'name': 'Domba Garut',
      'category': 'Domba',
      'weight': '35 kg',
      'age': '1 tahun',
      'location': 'Garut, Jawa Barat',
      'price': 'Rp 2.900.000',
      'image': 'Asset/image/Domba.png',
      'favorite': false,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredAnimals {
    final search = _searchController.text.toLowerCase().trim();

    return _animals.where((animal) {
      final matchesCategory = _selectedCategory == 'Semua' ||
          animal['category'] == _selectedCategory;

      final matchesSearch = search.isEmpty ||
          animal['name'].toString().toLowerCase().contains(search) ||
          animal['category'].toString().toLowerCase().contains(search) ||
          animal['location'].toString().toLowerCase().contains(search);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F7),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(),
                    const SizedBox(height: 14),
                    _buildCategoryFilter(),
                    const SizedBox(height: 12),
                    _buildAdditionalFilters(),
                    const SizedBox(height: 18),
                    _buildResultHeader(),
                    const SizedBox(height: 10),
                    _buildAnimalList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(20),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: Color(0xFF222222),
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'Jelajahi',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w700,
                color: Color(0xFF222222),
              ),
            ),
          ),
          InkWell(
            onTap: _showFilterSheet,
            borderRadius: BorderRadius.circular(20),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.tune,
                size: 24,
                color: Color(0xFF222222),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SEARCH BAR
  // ============================================================

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFE8E8E8),
        ),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (_) {
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: 'Cari hewan, lokasi, atau penjual...',
          hintStyle: const TextStyle(
            color: Color(0xFF999999),
            fontSize: 13,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFF8D8D8D),
            size: 22,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 19,
                    color: Color(0xFF888888),
                  ),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // CATEGORY FILTER
  // ============================================================

  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = _categories[index];
          final selected = category == _selectedCategory;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF079447)
                    : Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF079447)
                      : const Color(0xFFE8E8E8),
                ),
              ),
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight:
                      selected ? FontWeight.w600 : FontWeight.w500,
                  color: selected
                      ? Colors.white
                      : const Color(0xFF444444),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // ADDITIONAL FILTERS
  // ============================================================

  Widget _buildAdditionalFilters() {
    return Row(
      children: [
        Expanded(
          child: _filterButton(
            icon: Icons.location_on_outlined,
            title: 'Lokasi',
            onTap: () {
              _showSimpleFilter('Lokasi');
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _filterButton(
            icon: Icons.sell_outlined,
            title: 'Harga',
            onTap: () {
              _showSimpleFilter('Harga');
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _filterButton(
            icon: Icons.scale_outlined,
            title: 'Berat',
            onTap: () {
              _showSimpleFilter('Berat');
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _filterButton(
            icon: Icons.calendar_today_outlined,
            title: 'Usia',
            onTap: () {
              _showSimpleFilter('Usia');
            },
          ),
        ),
      ],
    );
  }

  Widget _filterButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE8E8E8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 15,
              color: const Color(0xFF555555),
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF444444),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // RESULT HEADER
  // ============================================================

  Widget _buildResultHeader() {
    return Row(
      children: [
        const Text(
          'Hewan Qurban',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF222222),
          ),
        ),
        const Spacer(),
        Text(
          '${_filteredAnimals.length} hewan',
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF888888),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ANIMAL LIST
  // ============================================================

  Widget _buildAnimalList() {
    if (_filteredAnimals.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 50,
        ),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 50,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 12),
            const Text(
              'Hewan tidak ditemukan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Coba gunakan kata kunci atau kategori lain.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF888888),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: _filteredAnimals.map((animal) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildAnimalCard(animal),
        );
      }).toList(),
    );
  }

  // ============================================================
  // ANIMAL CARD
  // ============================================================

  Widget _buildAnimalCard(Map<String, dynamic> animal) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFE9E9E9),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FOTO
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              animal['image'],
              width: 92,
              height: 92,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 92,
                  height: 92,
                  color: const Color(0xFFEFEFEF),
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 11),

          // DETAIL
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _verifiedBadge(),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          animal['favorite'] =
                              !(animal['favorite'] ?? false);
                        });
                      },
                      child: Icon(
                        animal['favorite'] == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 22,
                        color: animal['favorite'] == true
                            ? const Color(0xFFE53935)
                            : const Color(0xFF777777),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Text(
                  animal['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF222222),
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    const Icon(
                      Icons.scale_outlined,
                      size: 14,
                      color: Color(0xFF858585),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      animal['weight'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF777777),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: Color(0xFF858585),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      animal['age'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF777777),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Color(0xFF858585),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        animal['location'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF777777),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Text(
                  animal['price'],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF079447),
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
  // VERIFIED BADGE
  // ============================================================

  Widget _verifiedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE4F7EE),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified,
            size: 13,
            color: Color(0xFF079447),
          ),
          SizedBox(width: 3),
          Text(
            'Terverifikasi',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: Color(0xFF079447),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FILTER BOTTOM SHEET
  // ============================================================

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Filter Hewan',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              const Text(
                'Kategori',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _categories.map((category) {
                  final selected =
                      _selectedCategory == category;

                  return ChoiceChip(
                    label: Text(category),
                    selected: selected,
                    selectedColor: const Color(0xFF079447),
                    labelStyle: TextStyle(
                      color: selected
                          ? Colors.white
                          : Colors.black87,
                    ),
                    onSelected: (_) {
                      setState(() {
                        _selectedCategory = category;
                      });
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF079447),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Terapkan Filter',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // SIMPLE FILTER
  // ============================================================

  void _showSimpleFilter(String filterName) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (context) {
        List<String> options;

        switch (filterName) {
          case 'Lokasi':
            options = [
              'Semua Lokasi',
              'Jawa Barat',
              'Jawa Tengah',
              'DI Yogyakarta',
            ];
            break;

          case 'Harga':
            options = [
              'Semua Harga',
              'Di bawah Rp 5 juta',
              'Rp 5 - 15 juta',
              'Rp 15 - 30 juta',
              'Di atas Rp 30 juta',
            ];
            break;

          case 'Berat':
            options = [
              'Semua Berat',
              'Di bawah 50 kg',
              '50 - 100 kg',
              '100 - 300 kg',
              'Di atas 300 kg',
            ];
            break;

          default:
            options = [
              'Semua Usia',
              'Di bawah 1 tahun',
              '1 - 2 tahun',
              '2 - 3 tahun',
              'Di atas 3 tahun',
            ];
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter $filterName',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 15),

              ...options.map(
                (option) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    option,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}