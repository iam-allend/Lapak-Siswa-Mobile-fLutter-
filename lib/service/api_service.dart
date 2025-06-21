import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/customer_model.dart';

class ApiService {
  static const String baseUrl = "https://allend.site/lapak-siswa/API";

  static Future<CustomerModel?> loginCustomer(String username, String password) async {
  final url = Uri.parse("$baseUrl/login_customer.php");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      print("RESPON API: ${response.body}"); // DEBUG output

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          return CustomerModel.fromJson(data['data']);
        } else {
          print("Login gagal: ${data['message']}"); // DEBUG jika API sukses false
          return null;
        }
      } else {
        print("HTTP Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("EXCEPTION: $e");
      return null;
    }
  }

}
