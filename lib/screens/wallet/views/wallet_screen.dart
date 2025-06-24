import 'package:flutter/material.dart';
import 'package:shop/constants.dart';
import 'package:shop/helpers/user_session.dart';
import 'package:shop/models/customer_model.dart';
import 'package:shop/models/product_model.dart';
import 'components/wallet_balance_card.dart';
import 'components/wallet_history_card.dart';
import 'package:shop/models/deposit_model.dart';
import 'package:shop/service/deposit_service.dart';

List<DepositModel> deposits = [];
bool isLoading = true;

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double balance = 0.0;

  @override
  void initState() {
    super.initState();
    loadBalance();
  }

  Future<void> loadBalance() async {
    try {
      final userId = await UserSession.getUserId();
      if (userId != null) {
        final freshUser = await UserSession.fetchUserFromServer(userId);
        final depositList = await DepositService.getDeposits(userId);

        if (freshUser != null) {
          await UserSession.setLoggedInUser(freshUser);
          setState(() {
            balance = freshUser.saldo;
            deposits = depositList;
            isLoading = false;
          });
        } else {
          setState(() => isLoading = false);
        }
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Error saat loadBalance: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wallet")),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          children: [
            const SizedBox(height: defaultPadding),
            WalletBalanceCard(
              balance: balance,
              onTabChargeBalance: () async {
                final result = await Navigator.pushNamed(context, '/deposit');
                if (result == true) {
                  loadBalance(); // refresh saldo setelah deposit
                }
              },
            ),
            const SizedBox(height: defaultPadding),
            Text(
              "Wallet history",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: defaultPadding / 2),

            // contoh history statis
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : deposits.isEmpty
                    ? const Center(child: Text("Belum ada riwayat deposit"))
                    : Column(
                        children: deposits.map((d) {
                          return Card(
                            margin:
                                const EdgeInsets.only(bottom: defaultPadding),
                            child: ListTile(
                              title: Text(
                                  "Rp${d.amount.toStringAsFixed(0)} via ${d.bankName}"),
                              subtitle: Text("${d.createdAt} • ${d.status}"),
                              trailing: d.proofUrl != null
                                  ? Image.network(d.proofUrl!,
                                      width: 40, height: 40, fit: BoxFit.cover)
                                  : null,
                            ),
                          );
                        }).toList(),
                      ),

            const SizedBox(height: defaultPadding),
          ],
        ),
      ),
    );
  }
}
