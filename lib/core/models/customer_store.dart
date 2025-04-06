import 'package:ccp_mobile/core/models/customer.dart';
import 'package:ccp_mobile/core/models/store.dart';

class CustomerWithStore {
  final Customer customer;
  final Store store;

  CustomerWithStore({
    required this.customer,
    required this.store,
  });

  factory CustomerWithStore.fromJson(Map<String, dynamic> json) {
    return CustomerWithStore(
      customer: Customer.fromJson(json['customer']),
      store: Store.fromJson(json['store']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer': customer.toJson(),
      'store': store.toJson(),
    };
  }
}