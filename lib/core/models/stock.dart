import 'package:ccp_mobile/core/models/product.dart';

class Stock {
  final int total;
  final int limit;
  final int offset;
  final List<Product> results;

  Stock({
    required this.total,
    required this.limit,
    required this.offset,
    required this.results,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      total: json['total'],
      limit: json['limit'],
      offset: json['offset'],
      results: (json['results'] as List)
          .map((item) => Product.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'limit': limit,
      'offset': offset,
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}