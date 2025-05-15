class Pqrs {
  final String identificationNumber;
  final String name;
  final String address;
  final List<String> countries;
  final String identificationNumberContact;
  final String nameContact;
  final String phoneContact;
  final String addressContact;

  Pqrs({
    required this.identificationNumber,
    required this.name,
    required this.address,
    required this.countries,
    required this.identificationNumberContact,
    required this.nameContact,
    required this.phoneContact,
    required this.addressContact,
  });

  factory Pqrs.fromJson(Map<String, dynamic> json) {
    return Pqrs(
      identificationNumber: json['identification_number'],
      name: json['name'],
      address: json['address'],
      countries: List<String>.from(json['countries']),
      identificationNumberContact: json['identification_number_contact'],
      nameContact: json['name_contact'],
      phoneContact: json['phone_contact'],
      addressContact: json['address_contact'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identification_number': identificationNumber,
      'name': name,
      'address': address,
      'countries': countries,
      'identification_number_contact': identificationNumberContact,
      'name_contact': nameContact,
      'phone_contact': phoneContact,
      'address_contact': addressContact,
    };
  }
}