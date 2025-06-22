import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shoplon"),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.notifications_none),
          SizedBox(width: 16),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Review your order",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _cartItem(
            image: "https://i.imgur.com/XSHo3UK.png",
            title: "Mountain Warehouse for Women",
            brand: "LIPSY LONDON",
            price: "\$420",
            oldPrice: "\$540",
          ),
          _cartItem(
            image: "https://i.imgur.com/DZlYdhR.png",
            title: "Mountain Beta Warehouse",
            brand: "LIPSY LONDON",
            price: "\$800",
          ),
          _cartItem(
            image: "https://i.imgur.com/tL3b5sZ.png",
            title: "FS – Nike Air Max 270 Really React",
            brand: "LIPSY LONDON",
            price: "\$390.36",
            oldPrice: "\$650.62",
          ),
          const SizedBox(height: 24),
          const Text(
            "Your Coupon code",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              hintText: "Type coupon code",
              prefixIcon: const Icon(Icons.confirmation_num_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
            ),
          ),
          const SizedBox(height: 24),
          _orderSummary(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: ''),
        ],
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {},
      ),
    );
  }

  Widget _cartItem({
    required String image,
    required String title,
    required String brand,
    required String price,
    String? oldPrice,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Image.network(image, width: 56, height: 56, fit: BoxFit.cover),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(brand,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 4),
            Text(title,
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(price,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.teal)),
                if (oldPrice != null) ...[
                  const SizedBox(width: 6),
                  Text(
                    oldPrice,
                    style: const TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _orderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Order Summary",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          _summaryRow(label: "Subtotal", value: "\$169"),
          _summaryRow(label: "Shipping Fee", value: "Free", valueColor: Colors.green),
          _summaryRow(label: "Discount", value: "\$10"),
          Divider(),
          _summaryRow(label: "Total (Include of VAT)", value: "\$185"),
          _summaryRow(label: "Estimated VAT", value: "\$5"),
        ],
      ),
    );
  }
}

class _summaryRow extends StatelessWidget {
  const _summaryRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}