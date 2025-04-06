class Customer {
  final String? assignedSeller;
  final String? observations;
  final String userId;
  final String? name;
  final String id;
  final String? identificationNumber;

  Customer({
    required this.assignedSeller,
    required this.observations,
    required this.userId,
    required this.name,
    required this.id,
    required this.identificationNumber,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      assignedSeller: json['assigned_seller'],
      observations: json['observations'],
      userId: json['user_id'],
      name: json['name'],
      id: json['id'],
      identificationNumber: json['identification_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assigned_seller': assignedSeller,
      'observations': observations,
      'user_id': userId,
      'name': name,
      'id': id,
      'identification_number': identificationNumber,
    };
  }
}




