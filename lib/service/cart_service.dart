import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cart_item_model.dart';

class CartService {
  static const String baseUrl = 'https://allend.site/lapak-siswa/API';

  /// Menambahkan produk ke keranjang user
  static Future<bool> addToCart({
    required int userId,
    required int productId,
    int quantity = 1,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add_to_cart.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "user_id": userId,
          "product_id": productId,
          "quantity": quantity,
        }),
      );

      final data = jsonDecode(response.body);
      return data['success'] == true;
    } catch (e) {
      print('Error addToCart: $e');
      return false;
    }
  }

  /// Mengambil daftar item di keranjang user
  static Future<List<CartItemModel>> getCartItems(int userId) async {
    try {
      final url = Uri.parse('$baseUrl/get_cart.php?user_id=$userId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);

        if (jsonBody['success'] == true) {
          final List data = jsonBody['cart'];
          return data.map((e) => CartItemModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      print('Error getCartItems: $e');
    }

    return [];
  }

  static Future<bool> updateCartQuantity({
    required int cartId,
    required int quantity,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update_cart.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "cart_id": cartId,
          "quantity": quantity,
        }),
      );

      final data = jsonDecode(response.body);
      return data['success'] == true;
    } catch (e) {
      print('Error updateCartQuantity: $e');
      return false;
    }
  }

  static Future<bool> deleteCartItem(int cartId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/delete_cart_item.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"cart_id": cartId}),
      );

      final data = jsonDecode(response.body);
      return data['success'] == true;
    } catch (e) {
      print('Error deleteCartItem: $e');
      return false;
    }
  }

  /// Checkout transaksi siswa
  static Future<bool> checkout({required int userId}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/checkout_siswa.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"user_id": userId}),
      );

      final data = jsonDecode(response.body);
      return data['success'] == true;
    } catch (e) {
      print('Error during checkout: $e');
      return false;
    }
  }
}
