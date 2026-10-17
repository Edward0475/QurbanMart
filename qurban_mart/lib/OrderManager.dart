class OrderManager {
  static List<Map<String, dynamic>> myOrders = [];

  static void addOrder(Map<String, dynamic> animal) {
    String orderId =
        '#QM${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    Map<String, dynamic> newOrder = {
      'animal': animal,
      'orderId': orderId,
      'status': 'Dalam Proses',
      'date': '18 Okt 2026',
    };
    myOrders.insert(0, newOrder);
  }
}
