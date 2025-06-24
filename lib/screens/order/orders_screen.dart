import 'package:flutter/material.dart';
import 'package:shop/screens/order/views/order_tab.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pesanan Saya"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Proses"),
              Tab(text: "Selesai"),
              Tab(text: "Dibatalkan"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            OrderTab(status: 'proses'),
            OrderTab(status: 'selesai'),
            OrderTab(status: 'dibatalkan'),
          ],
        ),
      ),
    );
  }
}
