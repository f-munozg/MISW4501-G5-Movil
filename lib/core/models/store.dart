class Store {
  final String id;
  final String? identificationNumber;
  final String? address;
  final String? phone;
  final String? country;
  final String? city;

  Store({
    required this.id,
    this.identificationNumber,
    this.address,
    this.phone,
    this.country,
    this.city,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      identificationNumber: json['identification_number'],
      address: json['address'],
      phone: json['phone'],
      country: json['country'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'identification_number': identificationNumber,
      'address': address,
      'phone': phone,
      'country': country,
      'city': city,
    };
  }
}