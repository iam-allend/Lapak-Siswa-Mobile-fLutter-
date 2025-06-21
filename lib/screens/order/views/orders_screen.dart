import 'package:flutter/material.dart';
import 'order_detail_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Orders history",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),

          _orderItem(
            context: context,
            icon: Icons.payment,
            label: "Awaiting Payment",
            count: 0,
            color: Colors.orange,
            progress: 0.0,
            items: [],
          ),

          _orderItem(
            context: context,
            icon: Icons.work,
            label: "Processing",
            count: 1,
            color: Colors.purple,
            progress: 0.5,
            items: [
              {
                "name": "Aroma Terapi",
                "quantity": 1,
                "price": 120000,
                "status": "Processing",
              },
            ],
          ),

          _orderItem(
            context: context,
            icon: Icons.local_shipping,
            label: "Delivered",
            count: 5,
            color: Colors.green,
            progress: 1.0,
            items: [
              {
                "name": "Boneka Beruang",
                "quantity": 2,
                "price": 150000,
                "status": "Delivered",
              },
            ],
          ),

          _orderItem(
            context: context,
            icon: Icons.assignment_return,
            label: "Returned",
            count: 2,
            color: Colors.deepOrange,
            progress: 0.25,
            items: [
              {
                "name": "Puzzle Anak",
                "quantity": 1,
                "price": 80000,
                "status": "Returned",
              },
            ],
          ),

          _orderItem(
            context: context,
            icon: Icons.cancel,
            label: "Canceled",
            count: 2,
            color: Colors.red,
            progress: 0.5,
            items: [
              {
                "name": "Lego Mini",
                "quantity": 1,
                "price": 100000,
                "status": "Canceled",
              },
            ],
          ),
        ],
      ),
    );
  }

  Widget _orderItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int count,
    required Color color,
    required double progress,
    required List<Map<String, dynamic>> items,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailScreen(
                title: label,
                items: items,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(icon, color: Colors.black),
                title: Text(label),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        count.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: color,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade200,
                color: color,
                minHeight: 6,
                borderRadius: BorderRadius.circular(8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
