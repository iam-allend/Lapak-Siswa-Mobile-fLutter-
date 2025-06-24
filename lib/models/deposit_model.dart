
class DepositModel {
  final int id;
  final double amount;
  final String status;
  final String createdAt;
  final String bankName;
  final String? proofUrl;

  DepositModel({
    required this.id,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.bankName,
    this.proofUrl,
  });

  factory DepositModel.fromJson(Map<String, dynamic> json) {
    return DepositModel(
      id: int.parse(json['id_deposit'].toString()),
      amount: double.tryParse(json['jumlah_deposit'].toString()) ?? 0,
      status: json['status'],
      createdAt: json['created_at'],
      bankName: json['nama_bank'],
      proofUrl: json['bukti_transfer'] != null && json['bukti_transfer'] != ''
          ? "https://allend.site/lapak-siswa/${json['bukti_transfer']}"
          : null,
    );
  }
}
