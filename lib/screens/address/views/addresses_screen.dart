import 'package:flutter/material.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Addresses"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {}, // optional action
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            OutlinedButton.icon(
              onPressed: () {
                // Navigasi ke AddNewAddressScreen
              },
              icon: const Icon(Icons.location_on_outlined),
              label: const Text("Add new address"),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 20),
              _addressCard(
                context,
                isSelected: true,
                title: "Rumah",
                name: "Zikry Dwi Maulana",
                address: "Jl. Gajahmada No. 123, Semarang Tengah, Kota Semarang",
                phone: "+62 813 4567 8910",
                iconColor: Colors.purple,
                borderColor: Colors.purple,
              ),
              const SizedBox(height: 12),
              _addressCard(
                context,
                isSelected: false,
                title: "Kantor",
                name: "Anur Mustakim",
                address: "Jl. Sisingamangaraja No. 45, Banyumanik, Semarang",
                phone: "+62 812 3344 5566",
                iconColor: Colors.black54,
                borderColor: Colors.grey.shade300,
              ),

          ],
        ),
      ),
    );
  }

  Widget _addressCard(
    BuildContext context, {
    required bool isSelected,
    required String title,
    required String name,
    required String address,
    required String phone,
    required Color iconColor,
    required Color borderColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? Colors.purple.shade50 : Colors.white,
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.1),
            child: Icon(Icons.location_on, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: iconColor,
                    )),
                const SizedBox(height: 4),
                Text(
                  "$name, $address",
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  phone,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
