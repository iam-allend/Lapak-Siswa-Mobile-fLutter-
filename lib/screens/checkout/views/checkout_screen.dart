import 'package:flutter/material.dart';
import 'package:shop/constants.dart';
import 'package:shop/helpers/user_session.dart';
import 'package:shop/models/cart_item_model.dart';
import 'package:shop/models/customer_model.dart';
import 'package:shop/service/cart_service.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  CustomerModel? currentUser;
  List<CartItemModel> cartItems = [];
  bool isLoading = true;

  double get subtotal =>
      cartItems.fold(0, (sum, item) => sum + item.priceFinal * item.quantity);
  double get vat => 3.0;
  double get total => subtotal + vat;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final user = await UserSession.getLoggedInUser();
    if (user == null) return;
    final items = await CartService.getCartItems(user.id);

    setState(() {
      currentUser = user;
      cartItems = items;
      isLoading = false;
    });
  }

  Future<void> handleCheckout() async {
    if (currentUser == null) return;

    if (currentUser!.saldo < total) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Saldo tidak mencukupi untuk checkout.")),
      );
      return;
    }

    final success = await CartService.checkout(userId: currentUser!.id);
    if (success) {
      final newSaldo = currentUser!.saldo - total;

      await UserSession.updateSaldo(newSaldo);
      final updatedUser = await UserSession
          .getLoggedInUser(); // ✅ Ambil ulang data user terbaru

      setState(() {
        cartItems.clear();
        currentUser = updatedUser;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Checkout berhasil!")),
      );

      Navigator.pop(context, true); // beri sinyal balik ke cart
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Checkout gagal!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Saldo Anda: Rp${currentUser!.saldo.toStringAsFixed(0)}",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return ListTile(
                          leading: Image.network(item.image,
                              width: 40, height: 40, fit: BoxFit.cover),
                          title: Text(item.title),
                          subtitle: Text(
                              "x${item.quantity}  -  Rp${item.priceFinal.toStringAsFixed(0)}"),
                          trailing: Text(
                            "Rp${(item.priceFinal * item.quantity).toStringAsFixed(0)}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  _buildSummaryRow("Subtotal", subtotal),
                  _buildSummaryRow("Shipping", 0),
                  _buildSummaryRow("VAT (Est.)", vat),
                  const Divider(),
                  _buildSummaryRow("Total", total, bold: true),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: handleCheckout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("Bayar Sekarang",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSummaryRow(String label, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text("${value.toStringAsFixed(0)} Hari",
              style: TextStyle(
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
