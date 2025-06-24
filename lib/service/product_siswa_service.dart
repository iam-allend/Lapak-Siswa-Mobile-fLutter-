import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_siswa_model.dart';

class ProductSiswaService {
  static Future<List<ProductSiswaModel>> getAllProducts() async {
    final response = await http.get(
      Uri.parse("https://allend.site/lapak-siswa/API/get_product_siswa.php"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return (data['products'] as List)
            .map((json) => ProductSiswaModel.fromJson(json))
            .toList();
      }
    }

    return [];
  }
}
