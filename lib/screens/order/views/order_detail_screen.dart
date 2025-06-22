import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;

  const OrderDetailScreen({
    super.key,
    required this.title,
    required this.items,
  });

  double _getProgress(String status) {
    switch (status) {
      case "Processing":
        return 0.5;
      case "Delivered":
        return 1.0;
      case "Returned":
        return 0.2;
      case "Canceled":
        return 0.4;
      default:
        return 0.0;
    }
  }

  Color _getProgressColor(String status) {
    switch (status) {
      case "Processing":
        return Colors.orange;
      case "Delivered":
        return Colors.green;
      case "Returned":
        return Colors.blueGrey;
      case "Canceled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final String status = item['status'];
          final double progress = _getProgress(status);
          final Color progressColor = _getProgressColor(status);

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gambar lokal (sementara)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/images/SabunAromaterapi.png",
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Detail produk
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['category'] ?? "Kategori tidak diketahui",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['description'] ?? "Tidak ada deskripsi.",
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Harga: Rp${item['price']}"),
                            Text("Qty: ${item['quantity']}"),
                          ],
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: progress,
                          color: progressColor,
                          backgroundColor: progressColor.withOpacity(0.2),
                          minHeight: 6,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Status: $status",
                          style: TextStyle(
                            fontSize: 13,
                            color: progressColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
