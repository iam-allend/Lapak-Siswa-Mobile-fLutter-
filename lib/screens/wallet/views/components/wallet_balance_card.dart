import 'package:flutter/material.dart';
import '../../../../constants.dart';

class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({
    super.key,
    required this.balance,
    required this.onTabChargeBalance,
  });

  final double balance;
  final VoidCallback onTabChargeBalance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: defaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultBorderRadious),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          // Bagian atas (saldo)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(defaultPadding),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(defaultBorderRadious),
                topRight: Radius.circular(defaultBorderRadious),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Your current balance",
                  style: TextStyle(
                    color: whileColor80,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: defaultPadding / 2),
                Text(
                  "Rp${balance.toStringAsFixed(0)}",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),

          // Tombol bawah
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTabChargeBalance,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9581FF),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(defaultBorderRadious),
                    bottomRight: Radius.circular(defaultBorderRadious),
                  ),
                ),
              ),
              child: const Text("+ Charge Balance"),
            ),
          ),
        ],
      ),
    );
  }
}
