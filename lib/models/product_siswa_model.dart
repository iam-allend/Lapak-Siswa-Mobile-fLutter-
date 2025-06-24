class ProductSiswaModel {
  final String image;
  final String image2;

  final String brandName;
  final String title;
  final double price;
  final double priceAfetDiscount;
  final int dicountpercent;
  final List<String> imageList; // ✅ new
  final int idProduct; // ✅ Tambahan

  ProductSiswaModel({
    required this.idProduct,
    required this.image,
    required this.image2,
    required this.brandName,
    required this.title,
    required this.price,
    required this.priceAfetDiscount,
    required this.dicountpercent,
    required this.imageList, // ✅ new
  });

  factory ProductSiswaModel.fromJson(Map<String, dynamic> json) {
    final imageUrl = json['image_url'] ?? 'https://i.imgur.com/IXnwbLk.png';

    List<String> images = [];
    if (json['images'] != null && json['images'] is List) {
      images = List<String>.from(json['images'])
          .map((img) => 'https://allend.site/lapak-siswa/$img')
          .toList();
    }

    return ProductSiswaModel(
      image: json['url'] != null
          ? 'https://allend.site/lapak-siswa/${json['url']}'
          : 'https://i.imgur.com/IXnwbLk.png',

      brandName: json['product_name'] ?? 'Produk Siswa',
      title: json['description'] ?? '',
      price: double.tryParse(json['price'] ?? '') ?? 0,
      priceAfetDiscount: double.tryParse(json['price_final'] ?? '') ?? 0,
      dicountpercent: int.tryParse(json['discount'] ?? '') ?? 0,
      imageList: images, // ✅ assign list
      idProduct: int.parse(json['id_product'].toString()), // ✅ Tambahan
      image2: imageUrl,
    );
  }

  // Getter tambahan jika dibutuhkan oleh template
  String get description => title;
  int get discount => dicountpercent;
}
