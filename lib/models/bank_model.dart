// lib/models/bank_model.dart
class BankModel {
  final int id;
  final String namaBank;
  final String noRekening;
  final String atasNama;

  BankModel({
    required this.id,
    required this.namaBank,
    required this.noRekening,
    required this.atasNama,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      id: int.parse(json['id_bank'].toString()),
      namaBank: json['nama_bank'] ?? '',
      noRekening: json['no_rekening'] ?? '',
      atasNama: json['atas_nama'] ?? '',
    );
  }
}
