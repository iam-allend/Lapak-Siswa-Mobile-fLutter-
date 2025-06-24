import 'package:flutter/material.dart';
import 'package:shop/route/route_constants.dart';
import 'package:shop/helpers/user_session.dart';
import 'package:shop/service/api_service.dart';
import '../../../../models/customer_model.dart';

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
      await UserSession.setLoggedInUser(user); // ✅ Gunakan helper ini

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
