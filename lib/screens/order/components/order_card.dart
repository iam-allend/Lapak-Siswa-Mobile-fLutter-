// lib/screens/order/components/order_card.dart
import 'package:flutter/material.dart';
import 'package:shop/models/order_model.dart';
import 'package:shop/service/order_service.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onCancelled;

  const OrderCard({
    super.key,
    required this.order,
    this.onCancelled,
  });

  @override
  Widget build(BuildContext context) {
    final firstItem = order.items.isNotEmpty ? order.items[0] : null;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ID Pesanan: ${order.idOrder}",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("Tanggal: ${order.createdAt}"),
            const SizedBox(height: 8),
            if (firstItem != null)
              ListTile(
                leading: Image.network(
                  firstItem.imageUrl ?? '',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image_not_supported),
                ),
                title: Text(
                    "${firstItem.name} "),
                subtitle: Text(
                    "Jumlah ${order.items.fold(0, (sum, item) => sum + item.quantity)}"),
                trailing: Text("Rp${order.total.toStringAsFixed(0)}"),
              ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: Rp${order.total.toStringAsFixed(0)}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (onCancelled != null)
                  TextButton(
                    onPressed: () async {
                      print("➡ Membatalkan pesanan ID: ${order.idOrder}");

                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Batalkan Pesanan"),
                          content: const Text("Yakin ingin membatalkan pesanan ini?"),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("Tidak")),
                            ElevatedButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text("Ya")),
                          ],
                        ),
                      );

                      if (confirmed == true) {
                        final success = await OrderService.cancelOrder(order.idOrder);
                        print("✅ cancelOrder result: $success");

                        if (success && onCancelled != null) {
                          onCancelled!(); // reload tab
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Pesanan dibatalkan")),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Gagal membatalkan pesanan")),
                          );
                        }
                      }
                    },
                    child: const Text("Batalkan", style: TextStyle(color: Colors.red)),
                  ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
