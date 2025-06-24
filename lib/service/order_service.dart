import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order_model.dart';

class OrderService {
  static const String baseUrl = 'https://allend.site/lapak-siswa/API';

  /// Ambil daftar pesanan berdasarkan user_id dan status (diproses, dikirim, selesai, dibatalkan)
  static Future<List<OrderModel>> getOrders({
    required int userId,
    required String status,
  }) async {
    try {
      final response = await http.get(Uri.parse(
          '$baseUrl/get_orders_by_status.php?user_id=$userId&status=$status'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List orders = data['orders'];
          return orders.map((e) => OrderModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      print('Error getOrders: $e');
    }
    return [];
  }

  /// Batalkan pesanan berdasarkan id_order
  static Future<bool> cancelOrder(int orderId) async {
    
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/cancel_order.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id_transaksi": orderId, // ✅ sesuai dengan yang backend minta
        }),
        
      );

      final data = jsonDecode(response.body);
      return data['success'] == true;
    } catch (e) {
      print('Error cancelOrder: $e');
      return false;
    }
  }
}
