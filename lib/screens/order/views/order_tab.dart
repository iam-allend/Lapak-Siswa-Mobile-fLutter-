import 'package:flutter/material.dart';
import 'package:shop/models/order_model.dart';
import 'package:shop/service/order_service.dart';
import 'package:shop/screens/order/components/order_card.dart';
import 'package:shop/helpers/user_session.dart';

class OrderTab extends StatefulWidget {
  final String status;
  const OrderTab({super.key, required this.status});

  @override
  State<OrderTab> createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab> {
  List<OrderModel> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  Future<void> loadOrders() async {
    final user = await UserSession.getLoggedInUser();
    if (user == null) return;

    final result = await OrderService.getOrders(userId: user.id, status: widget.status);
    setState(() {
      orders = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (orders.isEmpty) {
      return const Center(child: Text("Belum ada pesanan"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderCard(
          order: orders[index],
          onCancelled: widget.status == 'proses'
              ? () => loadOrders() // refresh setelah batal
              : null,
        );
      },
    );
  }
}
