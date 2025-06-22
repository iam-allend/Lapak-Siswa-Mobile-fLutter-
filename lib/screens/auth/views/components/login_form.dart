import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/route/route_constants.dart'; // pastikan ini ada di atas
import '../../../../models/customer_model.dart';
import '../../../../service/api_service.dart';
import '../../../home/views/home_screen.dart';

class LogInForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const LogInForm({super.key, required this.formKey});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  Future<void> _handleLogin() async {
    setState(() {
      _loading = true;
    });

    final user = await ApiService.loginCustomer(
      _usernameController.text.trim(),
      _passwordController.text.trim(),
    );

    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
      await prefs.setInt('id', user.id);
      await prefs.setString('name', user.fullName);
      await prefs.setString('username', user.username);
      await prefs.setString('email', user.email);
      await prefs.setString('image', user.imageUrl ?? '');
      await prefs.setString('address', user.address ?? '');
      await prefs.setString('phone', user.phone ?? '');

      Navigator.pushNamedAndRemoveUntil(
        context,
        entryPointScreenRoute,
        (route) => false,
      );

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login gagal. Periksa username dan password.")),
      );
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: "Username / Email",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Username tidak boleh kosong";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password tidak boleh kosong";
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          _loading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    if (widget.formKey.currentState!.validate()) {
                      _handleLogin();
                    }
                  },
                  child: const Text("Log in"),
                ),
        ],
      ),
    );
  }
}
