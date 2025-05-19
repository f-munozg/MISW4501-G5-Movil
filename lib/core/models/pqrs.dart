class Pqrs {
  final String? sellerId;
  final String? orderId;
  final String id;
  final String title;
  final String status;
  final String customerId;
  final DateTime createdAt;
  final String type;
  final String description;
  final DateTime updatedAt;
  final double? amount;

  Pqrs({
    this.orderId,
    required this.sellerId,
    required this.id,
    required this.title,
    required this.status,
    required this.customerId,
    required this.createdAt,
    required this.type,
    required this.description,
    required this.updatedAt,
    this.amount,
  });

  factory Pqrs.fromJson(Map<String, dynamic> json) {
    return Pqrs(
      orderId: json['order_id'],
      sellerId: json['seller_id'],
      id: json['id'],
      title: json['title'],
      status: json['status'],
      customerId: json['customer_id'],
      createdAt: DateTime.parse(json['created_at']),
      type: json['type'],
      description: json['description'],
      updatedAt: DateTime.parse(json['updated_at']),
      amount: json['amount'] != null ? double.parse(json['amount'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'seller_id': sellerId,
      'id': id,
      'title': title,
      'status': status,
      'customer_id': customerId,
      'created_at': createdAt.toIso8601String(),
      'type': type,
      'description': description,
      'updated_at': updatedAt.toIso8601String(),
      'amount': amount,
    };
  }
}

