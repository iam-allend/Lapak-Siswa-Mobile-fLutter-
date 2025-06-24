class OrderModel {
  final int idOrder;
  final String status;
  final double total;
  final String createdAt;
  final List<OrderItem> items;

  OrderModel({
    required this.idOrder,
    required this.status,
    required this.total,
    required this.createdAt,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      idOrder: int.parse(json['id_transaksi'].toString()), // ✅ fix di sini
      status: json['status'],
      total: double.tryParse(json['total_bayar'].toString()) ?? 0,
      createdAt: json['created_at'] ?? '',
      items: (json['items'] as List).map((e) => OrderItem.fromJson(e)).toList(),
    );
  }
}

class OrderItem {
  final String name;
  final double price;
  final int quantity;
  final String? imageUrl;

  OrderItem({
    required this.name,
    required this.price,
    required this.quantity,
    this.imageUrl,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      name: json['product_name'] ?? '',
      price: double.tryParse(json['price_final'].toString()) ?? 0,
      quantity: int.tryParse(json['quantity'].toString()) ?? 1,
      imageUrl: json['image_url'] != null && json['image_url'] != ''
          ? 'https://allend.site/lapak-siswa/${json['image_url']}'
          : null,
    );
  }
}
