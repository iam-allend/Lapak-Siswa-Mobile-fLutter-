import 'package:flutter/material.dart';
import 'package:shop/constants.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: "Sepide Moqadasi");
    final emailController = TextEditingController(text: "theflutterway@gmail.com");
    final dobController = TextEditingController(text: "01/3/1999");
    final phoneController = TextEditingController(text: "+1–202–555–0162");

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage("https://i.imgur.com/IXnwbLk.png"),
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color:  Color.fromRGBO(0, 185, 142, 1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, size: 16, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Text("Edit photo", style: TextStyle(color: primaryColor)),
            const SizedBox(height: 30),
            buildTextField(label: "Full Name", icon: Icons.person, controller: nameController),
            const SizedBox(height: 16),
            buildTextField(label: "Email", icon: Icons.email, controller: emailController),
            const SizedBox(height: 16),
            buildTextField(label: "Date of Birth", icon: Icons.calendar_today, controller: dobController),
            const SizedBox(height: 16),
            buildPhoneField(controller: phoneController),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Done", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget buildPhoneField({required TextEditingController controller}) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(width: 15),
            Icon(Icons.phone),
            SizedBox(width: 8),
            Text("+1", style: TextStyle(fontWeight: FontWeight.w600)),
            VerticalDivider(width: 20),
          ],
        ),
        labelText: "Phone Number",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
