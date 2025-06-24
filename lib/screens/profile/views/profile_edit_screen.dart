import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shop/constants.dart';
import 'package:shop/helpers/user_session.dart';
import 'package:shop/models/customer_model.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();

  CustomerModel? user;
  File? imageFile;
  String? imageUrl;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final loggedInUser = await UserSession.getLoggedInUser();
    if (loggedInUser != null) {
      setState(() {
        user = loggedInUser;
        nameController.text = loggedInUser.fullName;
        emailController.text = loggedInUser.email;
        phoneController.text = loggedInUser.phone ?? '';
        addressController.text = loggedInUser.address ?? '';
        imageUrl = loggedInUser.imageUrl != null &&
                loggedInUser.imageUrl!.isNotEmpty
            ? "https://allend.site/lapak-siswa/img_user/${loggedInUser.imageUrl}"
            : null;
      });
    }
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  Future<void> saveProfile() async {
    final uri =
        Uri.parse("https://allend.site/lapak-siswa/API/update_profile.php");
    final request = http.MultipartRequest('POST', uri);

    request.fields['id'] = user!.id.toString();
    request.fields['name'] = nameController.text;
    request.fields['email'] = emailController.text;
    request.fields['phone'] = phoneController.text;
    request.fields['alamat'] = addressController.text;
    request.fields['password'] = passwordController.text;

    if (imageFile != null) {
      request.files
          .add(await http.MultipartFile.fromPath('foto', imageFile!.path));
    }

    final response = await request.send();
    final resBody = await response.stream.bytesToString();

    try {
      final data = jsonDecode(resBody);
      if (data['success'] == true) {
        final updatedUser = CustomerModel.fromJson(data['user']);
        await UserSession.setLoggedInUser(updatedUser); // ✅ update session
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profil berhasil diperbarui")),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? "Gagal update profil")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal memproses respons server")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: imageFile != null
                            ? FileImage(imageFile!)
                            : (imageUrl != null
                                    ? NetworkImage(imageUrl!)
                                    : const AssetImage(
                                        'assets/images/default_profile.png'))
                                as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: InkWell(
                          onTap: pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(0, 185, 142, 1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.edit,
                                size: 16, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildTextField("Full Name", Icons.person, nameController),
                  const SizedBox(height: 12),
                  buildTextField("Email", Icons.email, emailController),
                  const SizedBox(height: 12),
                  buildTextField("Phone", Icons.phone, phoneController),
                  const SizedBox(height: 12),
                  buildTextField("Address", Icons.home, addressController),
                  const SizedBox(height: 12),
                  buildTextField("Password (Kosongkan jika tidak diubah)",
                      Icons.lock, passwordController,
                      isPassword: true),
                  const SizedBox(height: 30),
                  isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: saveProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("Done",
                              style: TextStyle(color: Colors.white)),
                        )
                ],
              ),
            ),
    );
  }

  Widget buildTextField(
      String label, IconData icon, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
