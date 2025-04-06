import 'dart:convert';

import 'package:ccp_mobile/core/constants/app_config.dart';
import 'package:ccp_mobile/core/models/product.dart';
import 'package:http/http.dart' as http;

class StockService {
  Future<List<Product>> getProducts() async {
    final url = Uri.parse('${AppConfig.apiBackStock}/stock/get');
    final response = await http.get(url);

    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List products = data['results'];
      return products.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar productos');
    }
  }
}
