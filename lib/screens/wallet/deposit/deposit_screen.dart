import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shop/helpers/user_session.dart';
import 'package:shop/models/customer_model.dart';

Map<String, dynamic>? selectedBankInfo;

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final TextEditingController _amountController = TextEditingController();
  List<Map<String, dynamic>> banks = [];
  String? selectedBankId;
  File? proofImage;
  Uint8List? proofImageBytes; // ✅ Tambahkan ini
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadBanks();
  }

  Future<void> loadBanks() async {
    final response = await http
        .get(Uri.parse("https://allend.site/lapak-siswa/API/get_banks.php"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        setState(() {
          banks = List<Map<String, dynamic>>.from(data['banks']);
        });
      }
    }
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes(); // ← baca bytes
      setState(() {
        proofImage = File(picked.path); // tetap digunakan untuk upload
        proofImageBytes = bytes; // digunakan untuk preview
      });
    }
  }

  Future<void> submitDeposit() async {
    final user = await UserSession.getLoggedInUser();
    if (user == null ||
        selectedBankId == null ||
        _amountController.text.isEmpty ||
        proofImage == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Lengkapi semua data")));
      return;
    }

    setState(() => isLoading = true);

    final request = http.MultipartRequest(
      'POST',
      Uri.parse("https://allend.site/lapak-siswa/API/submit_deposit.php"),
    );

    request.fields['user_id'] = user.id.toString(); // ✅ cocok
    request.fields['bank_id'] = selectedBankId!; // ✅ cocok
    request.fields['jumlah'] = _amountController.text;
    request.files.add(
        await http.MultipartFile.fromPath('bukti_transfer', proofImage!.path));

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    print("RESPONSE BODY:\n$responseBody"); // ✅ tambahkan ini
    final data = jsonDecode(responseBody);

    setState(() => isLoading = false);

    if (data['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? "Deposit berhasil!")));
      Navigator.pop(context, true); // kirim sinyal ke WalletScreen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? "Gagal mengirim deposit")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Deposit Saldo")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: selectedBankId,
                items: banks
                    .map((bank) => DropdownMenuItem(
                          value: bank['id_bank'].toString(),
                          child: Text(bank['nama_bank']),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBankId = value;
                    selectedBankInfo = banks.firstWhere(
                        (bank) => bank['id_bank'].toString() == value);
                  });
                },
                decoration:
                    const InputDecoration(labelText: "Pilih Bank Tujuan"),
              ),
              if (selectedBankInfo != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "No. Rekening: ${selectedBankInfo!['nomor_rekening']}"),
                      Text("Atas Nama: ${selectedBankInfo!['atas_nama']}"),
                    ],
                  ),
                ),
              const SizedBox(height: 12),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: "Jumlah Deposit (Rp)"),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: pickImage,
                icon: const Icon(Icons.upload_file),
                label: const Text("Upload Bukti Transfer"),
              ),
              const SizedBox(height: 8),
              if (proofImage != null)
                Center(
                  child: Image.file(
                    proofImage!,
                    height: 150,
                  ),
                ),
              const SizedBox(height: 24),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: submitDeposit,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: const Text("Kirim Deposit"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
