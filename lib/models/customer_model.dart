class CustomerModel {
  final int id;
  final String fullName;
  final String username;
  final String email;
  final String? phone;
  final String? gender;
  final String? imageUrl;
  final String? address;
  final double saldo;

  CustomerModel({
    required this.id,
    required this.fullName,
    required this.username,
    required this.email,
    required this.saldo,
    this.phone,
    this.gender,
    this.imageUrl,
    this.address,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: int.parse(json['id_customer'].toString()),
      fullName: json['full_name'],
      username: json['username'],
      email: json['email'],
      saldo: double.tryParse(json['saldo'].toString()) ?? 0.0,
      phone: json['no_telp'],
      gender: json['gender'],
      imageUrl: json['url_image'],
      address: json['alamat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_customer": id,
      "full_name": fullName,
      "username": username,
      "email": email,
      "no_telp": phone,
      "gender": gender,
      "url_image": imageUrl,
      "alamat": address,
      "saldo": saldo.toStringAsFixed(0),
    };
  }

  CustomerModel copyWith({double? saldo}) {
    return CustomerModel(
      id: id,
      fullName: fullName,
      username: username,
      email: email,
      saldo: saldo ?? this.saldo,
      phone: phone,
      gender: gender,
      imageUrl: imageUrl,
      address: address,
    );
  }
}
