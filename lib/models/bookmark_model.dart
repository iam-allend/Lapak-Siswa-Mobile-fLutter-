class BookmarkModel {
  final int id;
  final String title;
  final String brandName;
  final String image;
  final double price;

  BookmarkModel({
    required this.id,
    required this.title,
    required this.brandName,
    required this.image,
    required this.price,
  });

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      id: int.parse(json['product_id']),
      title: json['title'],
      brandName: json['brand_name'],
      image: json['image'],
      price: double.parse(json['price'].toString()),
    );
  }
}
