import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review your order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductItem(
              imageUrl: 'assets/images/MaskerWajahAlami.png',
              title: 'Masker Wajah Alami',
              price: '\$100',             
            ),
            _buildProductItem(
              imageUrl: 'assets/images/SabunAromaterapi.png',
              title: 'Sabun Aromaterapi',
              price: '\$390.36',
              oldPrice: '\$650.62',
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Coupon code',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Type coupon code',
                prefixIcon: Icon(Icons.card_giftcard_outlined),
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem({
    required String imageUrl,
    required String title,
    required String price,
    String? oldPrice,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(imageUrl, width: 60, height: 60, fit: BoxFit.cover),
        ),
        title: Text(title, style: const TextStyle(fontSize: 14)),
        subtitle: Row(
          children: [
            Text(
              price,
              style: const TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (oldPrice != null) ...[
              const SizedBox(width: 8),
              Text(
                oldPrice,
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Order Summary',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          _summaryRow('Subtotal', '\$169'),
          _summaryRow('Shipping Fee', 'Free', isHighlighted: true),
          _summaryRow('Discount', '\$10'),
          Divider(height: 24),
          _summaryRow('Total (Include of VAT)', '\$185', isBold: true),
          _summaryRow('Estimated VAT', '\$5'),
        ],
      ),
    );
  }
}

class _summaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlighted;
  final bool isBold;

  const _summaryRow(this.label, this.value, {
    this.isHighlighted = false,
    this.isBold = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isHighlighted ? Colors.green : null,
          )),
          Text(value, style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isHighlighted ? Colors.green : null,
          )),
        ],
      ),
    );
  }
}
