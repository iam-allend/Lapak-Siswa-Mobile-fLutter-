import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_siswa_model.dart';

class BookmarkService {
  static Future<bool> addBookmark(int userId, int productId) async {
    final url = Uri.parse(
        "https://allend.site/lapak-siswa/API/add_bookmark.php"); // ✅ FIXED HERE

    final response = await http.post(url, body: {
      'user_id': userId.toString(), // bisa juga 'id_customer'
      'product_id': productId.toString(),
    });

    print("Response add bookmark: ${response.body}");

    return response.statusCode == 200 &&
        response.body.contains('"success":true');
  }

  static Future<List<ProductSiswaModel>> getBookmarks(int userId) async {
    final url = Uri.parse(
        "https://allend.site/lapak-siswa/API/get_bookmark.php?id_customer=$userId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data['products'] is List) {
        return (data['products'] as List)
            .map((json) => ProductSiswaModel.fromJson(json))
            .toList();
      }
    }
    return [];
  }
}
