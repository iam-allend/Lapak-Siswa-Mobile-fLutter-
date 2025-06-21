import 'package:flutter/material.dart';

class OrderDeliveredScreen extends StatelessWidget {
  const OrderDeliveredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> deliveredOrders = [
      {
        "title": "Wireless Headphones",
        "orderId": "#ORD20240621",
        "date": "21 Jun 2025",
        "status": "Delivered",
      },
      {
        "title": "Smartwatch Pro X",
        "orderId": "#ORD20240619",
        "date": "19 Jun 2025",
        "status": "Delivered",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivered Orders"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: deliveredOrders.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final order = deliveredOrders[index];
          return ListTile(
            leading: const Icon(Icons.local_shipping, color: Colors.green),
            title: Text(order["title"]),
            subtitle: Text("Order ID: ${order["orderId"]}\nDate: ${order["date"]}"),
            isThreeLine: true,
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Delivered",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            onTap: () {
              // Navigasi ke detail jika ingin
            },
          );
        },
      ),
    );
  }
}
