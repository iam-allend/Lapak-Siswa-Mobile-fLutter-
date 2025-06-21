class CustomerModel {
  final int id;
  final String fullName;
  final String username;
  final String email;
  final String? phone;
  final String? gender;
  final String? imageUrl;
  final String? address;

  CustomerModel({
    required this.id,
    required this.fullName,
    required this.username,
    required this.email,
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
    };
  }
}
