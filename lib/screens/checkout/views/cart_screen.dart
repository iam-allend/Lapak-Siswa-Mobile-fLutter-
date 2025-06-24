import 'package:flutter/material.dart';
import 'package:shop/constants.dart';
import 'package:shop/helpers/user_session.dart';
import 'package:shop/models/cart_item_model.dart';
import 'package:shop/service/cart_service.dart';
import 'package:shop/screens/checkout/views/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItemModel> cartItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> _updateQuantity(CartItemModel item, int newQuantity) async {
    final success = await CartService.updateCartQuantity(
      cartId: item.cartId,
      quantity: newQuantity,
    );

    if (success) {
      setState(() {
        final index = cartItems.indexWhere((e) => e.cartId == item.cartId);
        if (index != -1) {
          cartItems[index] = CartItemModel(
            cartId: item.cartId,
            productId: item.productId,
            title: item.title,
            image: item.image,
            price: item.price,
            priceFinal: item.priceFinal,
            quantity: newQuantity,
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal update jumlah produk")),
      );
    }
  }

  Future<void> loadCart() async {
    final user = await UserSession.getLoggedInUser();
    if (user == null) return;

    final items = await CartService.getCartItems(user.id);
    setState(() {
      cartItems = items;
      isLoading = false;
    });
  }

  double get subtotal =>
      cartItems.fold(0, (sum, item) => sum + item.priceFinal * item.quantity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review your order'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartItems.isEmpty
              ? const Center(child: Text("Keranjang kamu kosong"))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...cartItems.map((item) => _buildProductItem(item)),
                      const SizedBox(height: 20),
                      const Text('Your Coupon code',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Type coupon code',
                          prefixIcon: const Icon(Icons.card_giftcard_outlined),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildOrderSummary(),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CheckoutScreen()),
                            );

                            if (result == true) {
                              loadCart(); // panggil ulang agar keranjang kosong ter-refresh
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Konfirmasi Pesanan',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildProductItem(CartItemModel item) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
          ),
        ),
        title: Text(item.title, style: const TextStyle(fontSize: 14)),
        subtitle: Row(
          children: [
            Text("Rp${item.priceFinal.toStringAsFixed(0)}",
                style: const TextStyle(
                    color: Colors.cyan, fontWeight: FontWeight.bold)),
            if (item.price > item.priceFinal) ...[
              const SizedBox(width: 8),
              Text(
                "Rp${item.price.toStringAsFixed(0)}",
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ]
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () async {
                if (item.quantity > 1) {
                  await _updateQuantity(item, item.quantity - 1);
                } else {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Hapus Item"),
                      content: const Text(
                          "Jumlah produk 1. Apakah ingin menghapus dari keranjang?"),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text("Batal")),
                        ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text("Hapus")),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    final success =
                        await CartService.deleteCartItem(item.cartId);
                    if (success) {
                      setState(() {
                        cartItems.removeWhere((e) => e.cartId == item.cartId);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Item berhasil dihapus")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Gagal menghapus item")),
                      );
                    }
                  }
                }
              },
            ),
            Text("x${item.quantity}", style: const TextStyle(fontSize: 12)),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () async {
                await _updateQuantity(item, item.quantity + 1);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    const vat = 3.0;
    const discount = 0.0;
    final total = subtotal + vat - discount;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Order Summary',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _summaryRow('Subtotal', "Rp${subtotal.toStringAsFixed(0)}"),
          _summaryRow('Shipping Fee', 'Free', isHighlighted: true),
          _summaryRow('Discount', "Rp${discount.toStringAsFixed(0)}"),
          const Divider(height: 24),
          _summaryRow('Total (Include of VAT)', "Rp${total.toStringAsFixed(0)}",
              isBold: true),
          _summaryRow('Estimated Pengiriman', "${vat.toStringAsFixed(0)} Hari"),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value,
      {bool isHighlighted = false, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: isHighlighted ? Colors.green : null,
              )),
          Text(value,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: isHighlighted ? Colors.green : null,
              )),
        ],
      ),
    );
  }
}
