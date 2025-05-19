import 'package:ccp_mobile/core/models/cart_item.dart';

class Order {
  final String id;
  final String customerId;
  final String? sellerId;
  final DateTime dateOrder;
  final DateTime dateDelivery;
  final String status;
  final List<CartItem> products;

  Order({
    required this.id,
    required this.customerId,
    this.sellerId,
    required this.dateOrder,
    required this.dateDelivery,
    required this.status,
    this.products = const [],
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      customerId: json['customer_id'] as String,
      sellerId: json['seller_id'] as String?,
      dateOrder: DateTime.parse(json['date_order'] as String),
      dateDelivery: DateTime.parse(json['date_delivery'] as String),
      status: json['status'] as String,
      products: (json['products'] as List<dynamic>?)
              ?.map<CartItem>(
                  (item) => CartItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'seller_id': sellerId,
      'date_order': dateOrder.toIso8601String(),
      'date_delivery': dateDelivery.toIso8601String(),
      'status': status,
      'products': products.map((item) => item.toJson()).toList(),
    };
  }
}
