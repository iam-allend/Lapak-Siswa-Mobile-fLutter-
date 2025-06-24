class CartItemModel {
  final int cartId;
  final int productId;
  final String title;
  final String image;
  final double price;
  final double priceFinal;
  final int quantity;

  CartItemModel({
    required this.cartId,
    required this.productId,
    required this.title,
    required this.image,
    required this.price,
    required this.priceFinal,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      cartId: int.parse(json['cart_id'].toString()),
      productId: int.parse(json['id_product'].toString()),
      title: json['product_name'] ?? '',
      image: "https://allend.site/lapak-siswa/${json['url'] ?? ''}",
      price: double.tryParse(json['price'].toString()) ?? 0,
      priceFinal: double.tryParse(json['price_final'].toString()) ?? 0,
      quantity: int.tryParse(json['quantity'].toString()) ?? 1,
    );
  }
}
