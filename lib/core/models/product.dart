class Product {
  final String product;
  final String sku;
  final double unitValue;
  final String photo; // base64
  final String category;
  final int quantity;
  final DateTime estimatedDeliveryTime;
  final DateTime dateUpdate;

  Product({
    required this.product,
    required this.sku,
    required this.unitValue,
    required this.photo,
    required this.category,
    required this.quantity,
    required this.estimatedDeliveryTime,
    required this.dateUpdate,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      product: json['product'],
      sku: json['sku'],
      unitValue: (json['unit_value'] as num).toDouble(),
      photo: json['photo'],
      category: json['category'],
      quantity: json['quantity'],
      estimatedDeliveryTime: DateTime.parse(json['estimated_delivery_time']),
      dateUpdate: DateTime.parse(json['date_update']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'sku': sku,
      'unit_value': unitValue,
      'photo': photo,
      'category': category,
      'quantity': quantity,
      'estimated_delivery_time': estimatedDeliveryTime.toIso8601String(),
      'date_update': dateUpdate.toIso8601String(),
    };
  }
}