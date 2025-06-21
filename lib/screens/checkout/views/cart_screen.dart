import 'package:flutter/material.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key); // Add 'const'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Add functionality for sharing the cart details
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cart Item List
            Expanded(
              child: ListView(
                children: [
                  _cartItemWidget(
                    "Sleeveless Tiered Dobby...",
                    "\$299.43",
                    "\$534.33",
                    "Winter Huddi",
                  ),
                  _cartItemWidget(
                    "Printed Sleeveless Tiered...",
                    "\$299.43",
                    "\$534.33",
                    "Winter Huddi",
                  ),
                ],
              ),
            ),
            // Coupon and Order Summary Section
            SizedBox(height: 20),
            Text('Your Coupon code', style: TextStyle(fontSize: 16)),
            TextField(
              decoration: InputDecoration(
                hintText: 'Type coupon code',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text('Order Summary', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _orderSummary("Subtotal", "\$24"),
            _orderSummary("Shipping Fee", "Free"),
            _orderSummary("Total (Include of VAT)", "\$25"),
            _orderSummary("Estimated VAT", "\$1"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle checkout functionality
              },
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }

  // Cart item widget
  Widget _cartItemWidget(String title, String price, String originalPrice, String subtitle) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: Image.asset('assets/images/signUp_dark.png'), // Add your image here
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(price, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(originalPrice, style: TextStyle(fontSize: 14, decoration: TextDecoration.lineThrough)),
          ],
        ),
      ),
    );
  }

  // Order summary widget
  Widget _orderSummary(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 16)),
        Text(value, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
