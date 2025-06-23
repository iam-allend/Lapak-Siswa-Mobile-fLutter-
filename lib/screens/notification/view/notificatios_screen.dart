import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        "icon": Icons.local_shipping,
        "color": Colors.amber,
        "text": "Pesanan Anda sedang dikirim.",
        "time": "2 menit lalu",
        "isNew": true,
      },
      {
        "icon": Icons.check_circle,
        "color": Colors.green,
        "text": "Pesanan Anda telah diterima.",
        "time": "10 menit lalu",
        "isNew": true,
      },
      {
        "icon": Icons.discount,
        "color": Colors.purple,
        "text": "Diskon 20% untuk produk ramah lingkungan!",
        "time": "30 menit lalu",
        "isNew": true,
      },
      {
        "icon": Icons.receipt_long,
        "color": Colors.blueGrey,
        "text": "Tagihan Anda sudah tersedia.",
        "time": "1 jam lalu",
        "isNew": false,
      },
      {
        "icon": Icons.notifications_active,
        "color": Colors.deepOrange,
        "text": "Barang baru telah ditambahkan di kategori Kecantikan.",
        "time": "2 jam lalu",
        "isNew": false,
      },
      {
        "icon": Icons.feedback,
        "color": Colors.teal,
        "text": "Berikan ulasan untuk produk yang telah Anda beli.",
        "time": "Kemarin",
        "isNew": false,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return ListTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: item['color'],
                  child: Icon(
                    item['icon'],
                    color: Colors.white,
                  ),
                ),
                if (item['isNew'])
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.red,
                    ),
                  )
              ],
            ),
            title: Text(item['text']),
            subtitle: Text(item['time']),
          );
        },
      ),
    );
  }
}
