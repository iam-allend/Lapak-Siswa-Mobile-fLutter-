class ProductSiswaModel {
  final String image;
  final String brandName;
  final String title;
  final double price;
  final double priceAfetDiscount;
  final int dicountpercent;

  ProductSiswaModel({
    required this.image,
    required this.brandName,
    required this.title,
    required this.price,
    required this.priceAfetDiscount,
    required this.dicountpercent,
  });

  factory ProductSiswaModel.fromJson(Map<String, dynamic> json) {
    return ProductSiswaModel(
      image: json['url'] != null
    ? 'https://allend.site/lapak-siswa/${json['url']}'
    : 'https://i.imgur.com/IXnwbLk.png',

      brandName: json['product_name'] ?? 'Produk Siswa',
      title: json['description'] ?? '',
      price: double.tryParse(json['price'] ?? '') ?? 0,
      priceAfetDiscount: double.tryParse(json['price_final'] ?? '') ?? 0,
      dicountpercent: int.tryParse(json['discount'] ?? '') ?? 0,
    );
  }
}
