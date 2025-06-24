import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shop/route/route_constants.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool agreeTerms = false;

  Future<void> register() async {
    if (!_formKey.currentState!.validate() || !agreeTerms) return;

    setState(() => isLoading = true);

    final url = Uri.parse("https://allend.site/lapak-siswa/API/register.php");
    final response = await http.post(url, body: {
      "name": nameController.text,
      "username": usernameController.text,
      "email": emailController.text,
      "password": passwordController.text,
    });

    final data = jsonDecode(response.body);
    setState(() => isLoading = false);

    if (data['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'] ?? 'Registrasi berhasil!')),
      );
      Navigator.pushReplacementNamed(context, logInScreenRoute);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'] ?? 'Registrasi gagal!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/login_dark_lapak.png",
              height: MediaQuery.of(context).size.height * 0.40,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to Lapak Siswa",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text("Buat."),
                  const SizedBox(height: defaultPadding),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(labelText: "Nama Lengkap"),
                          validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                        ),
                        const SizedBox(height: defaultPadding),
                        TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(labelText: "Username"),
                          validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                        ),
                        const SizedBox(height: defaultPadding),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(labelText: "Email"),
                          validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                        ),
                        const SizedBox(height: defaultPadding),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(labelText: "Password"),
                          validator: (value) => value!.length < 6 ? 'Minimal 6 karakter' : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (value) => setState(() => agreeTerms = value ?? false),
                        value: agreeTerms,
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: "I agree with the",
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                        context, termsOfServicesScreenRoute);
                                  },
                                text: " Terms of service ",
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const TextSpan(
                                text: "& privacy policy.",
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: defaultPadding * 2),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: register,
                          child: const Text("Continue"),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Do you have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, logInScreenRoute);
                        },
                        child: const Text("Log in"),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
