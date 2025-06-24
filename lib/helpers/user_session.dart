import 'package:shared_preferences/shared_preferences.dart';
import '../models/customer_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/customer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyId = 'id';
  static const String _keyName = 'name';
  static const String _keyUsername = 'username';
  static const String _keyEmail = 'email';
  static const String _keyImage = 'image';
  static const String _keyAddress = 'address';
  static const String _keyPhone = 'phone';
  static const String _keySaldo = 'saldo';

  static Future<CustomerModel?> fetchUserFromServer(int userId) async {
    final url = Uri.parse(
        "https://allend.site/lapak-siswa/API/get_user_by_id.php?id=$userId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        final userJson = data['user'];
        return CustomerModel.fromJson(userJson);
      }
    }
    return null;
  }

  /// Simpan data user setelah login
  static Future<void> setLoggedInUser(CustomerModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setInt(_keyId, user.id);
    await prefs.setString(_keyName, user.fullName);
    await prefs.setString(_keyUsername, user.username);
    await prefs.setString(_keyEmail, user.email);
    await prefs.setString(_keyImage, user.imageUrl ?? '');
    await prefs.setString(_keyAddress, user.address ?? '');
    await prefs.setString(_keyPhone, user.phone ?? '');
    await prefs.setDouble(_keySaldo, user.saldo); // ✅ simpan saldo
  }

  /// Ambil ID user
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyId);
  }

  /// Ambil data lengkap user
  static Future<CustomerModel?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();

    final id = prefs.getInt(_keyId);
    final name = prefs.getString(_keyName);
    final username = prefs.getString(_keyUsername);
    final email = prefs.getString(_keyEmail);
    final saldo = prefs.getDouble(_keySaldo) ?? 0.0;

    if (id != null && name != null && username != null && email != null) {
      return CustomerModel(
        id: id,
        fullName: name,
        username: username,
        email: email,
        saldo: saldo, // ✅ sudah benar
        phone: prefs.getString(_keyPhone),
        gender: null,
        imageUrl: prefs.getString(_keyImage),
        address: prefs.getString(_keyAddress),
      );
    }

    return null;
  }

  /// Cek apakah user sudah login
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  /// Logout / hapus session
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> updateSaldo(double newSaldo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_keySaldo, newSaldo);
  }
}
