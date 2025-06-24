import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/constants.dart';
import 'package:shop/components/network_image_with_loader.dart';
import 'package:shop/route/screen_export.dart'; // pastikan file ini sudah punya route profileEditScreenRoute
import 'package:shop/models/customer_model.dart';
import 'package:shop/helpers/user_session.dart';

class ProfileViewScreen extends StatefulWidget {
  const ProfileViewScreen({super.key});

  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  CustomerModel? user;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final u = await UserSession.getLoggedInUser();
    setState(() {
      user = u;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Info"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, profileEditScreenRoute);
            },
            child: const Text(
              "Edit",
              style: TextStyle(
                color: Color.fromRGBO(0, 185, 142, 1),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[200],
                child: ClipOval(
                  child: NetworkImageWithLoader(
                    "https://allend.site/lapak-siswa/img_user/${user!.imageUrl}",
                    radius: 100,
                  ),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            Text(
              user!.fullName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              user!.email,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: defaultPadding * 2),
            ListTile(
              leading: SvgPicture.asset("assets/icons/Order.svg", height: 24),
              title: const Text("My Orders"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pushNamed(context, ordersScreenRoute);
              },
            ),
            ListTile(
              leading: SvgPicture.asset("assets/icons/card.svg", height: 24),
              title: const Text("Payment Methods"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pushNamed(context, emptyPaymentScreenRoute);
              },
            ),
            ListTile(
              leading:
                  SvgPicture.asset("assets/icons/Location.svg", height: 24),
              title: const Text("Addresses"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pushNamed(context, addressesScreenRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
