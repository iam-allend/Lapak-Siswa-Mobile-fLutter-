import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Metode Pembayaran"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Transfer Bank",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _paymentMethodTile(
            context: context,
            iconPath: "../assets/images/bca.png",
            label: "Bank BCA",
            accountName: "Zikry Dwi Maulana",
            accountNumber: "1234567890",
          ),
          _paymentMethodTile(
            context: context,
            iconPath: "../assets/images/bri.png",
            label: "Bank BRI",
            accountName: "Zikry Dwi Maulana",
            accountNumber: "0246813579",
          ),
          _paymentMethodTile(
            context: context,
            iconPath: "../assets/images/bni.png",
            label: "Bank BNI",
            accountName: "Zikry Dwi Maulana",
            accountNumber: "1029384756",
          ),
          const SizedBox(height: 24),
          const Text(
            "Dompet Digital (E-Wallet)",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _paymentMethodTile(
            context: context,
            iconPath: "../assets/images/gopay.png",
            label: "GoPay",
            accountName: "Zikry Dwi",
            accountNumber: "0812 3456 7890",
          ),
          _paymentMethodTile(
            context: context,
            iconPath: "../assets/images/ovo.png",
            label: "OVO",
            accountName: "Zikry Maulana",
            accountNumber: "0812 8765 4321",
          ),
          _paymentMethodTile(
            context: context,
            iconPath: "../assets/images/dana.png",
            label: "DANA",
            accountName: "Zikry D.M",
            accountNumber: "0813 2233 4455",
          ),
        ],
      ),
    );
  }

  Widget _paymentMethodTile({
    required BuildContext context,
    required String iconPath,
    required String label,
    required String accountName,
    required String accountNumber,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Image.asset(
          iconPath,
          height: 36,
          width: 36,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.account_balance_wallet),
        ),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("a/n $accountName"),
            Text("No: $accountNumber"),
          ],
        ),
        trailing: const Icon(Icons.copy, size: 20),
        onTap: () {
          Clipboard.setData(ClipboardData(text: accountNumber));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Nomor $label telah disalin'),
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}
