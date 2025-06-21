import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;

  const OrderDetailScreen({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: BackButton(),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(Icons.inventory_2),
              title: Text(item['name']),
              subtitle: Text("Qty: ${item['quantity']} • ${item['status']}"),
              trailing: Text("Rp${item['price']}"),
            ),
          );
        },
      ),
    );
  }
}

