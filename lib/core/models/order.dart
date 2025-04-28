class Order {
  final String id;
  final String customerId;
  final String? sellerId;
  final DateTime dateOrder;
  final DateTime dateDelivery;
  final String status;

  Order({
    required this.id,
    required this.customerId,
    this.sellerId,
    required this.dateOrder,
    required this.dateDelivery,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      customerId: json['customer_id'],
      sellerId: json['seller_id'],
      dateOrder: DateTime.parse(json['date_order']),
      dateDelivery: DateTime.parse(json['date_delivery']),
      status: json['status'],
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
    };
  }
}