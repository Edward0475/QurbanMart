class FavoriteManager {
  // List global untuk menyimpan hewan-hewan yang difavoritkan
  static List<Map<String, dynamic>> favoriteList = [];

  // Fungsi untuk menambah atau menghapus dari favorit
  static void toggleFavorite(Map<String, dynamic> animal) {
    // Mengecek apakah hewan ini sudah ada di dalam list favorit berdasarkan namanya
    bool isExist = favoriteList.any((item) => item['name'] == animal['name']);

    if (isExist) {
      // Jika sudah ada, hapus dari favorit (Un-love)
      favoriteList.removeWhere((item) => item['name'] == animal['name']);
    } else {
      // Jika belum ada, tambahkan ke favorit (Love)
      favoriteList.add(animal);
    }
  }

  // Fungsi untuk mengecek status (apakah hewan ini sedang di-love atau tidak)
  static bool isFavorite(Map<String, dynamic> animal) {
    return favoriteList.any((item) => item['name'] == animal['name']);
  }
}
