class Product {
  final String sku;
  final String name;
  final double unitValue;
  final String conditionsStorage;
  final String productFeatures;
  final String providerId;
  final DateTime timeDeliveryDear;
  final String photo;
  final String description;

  Product({
    required this.sku,
    required this.name,
    required this.unitValue,
    required this.conditionsStorage,
    required this.productFeatures,
    required this.providerId,
    required this.timeDeliveryDear,
    required this.photo,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      sku: json['sku'],
      name: json['name'],
      unitValue: (json['unit_value'] as num).toDouble(),
      conditionsStorage: json['conditions_storage'],
      productFeatures: json['product_features'],
      providerId: json['provider_id'],
      timeDeliveryDear: DateTime.parse(json['time_delivery_dear']),
      photo: json['photo'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sku': sku,
      'name': name,
      'unit_value': unitValue,
      'conditions_storage': conditionsStorage,
      'product_features': productFeatures,
      'provider_id': providerId,
      'time_delivery_dear': timeDeliveryDear.toIso8601String(),
      'photo': photo,
      'description': description,
    };
  }
}