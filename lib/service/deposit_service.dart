import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/deposit_model.dart';

class DepositService {
  static const baseUrl = 'https://allend.site/lapak-siswa/API';

  static Future<List<DepositModel>> getDeposits(int userId) async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/get_deposits.php?user_id=$userId'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data['success'] == true) {
          final List list = data['deposits'];
          return list.map((e) => DepositModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      print('getDeposits error: $e');
    }
    return [];
  }
}
