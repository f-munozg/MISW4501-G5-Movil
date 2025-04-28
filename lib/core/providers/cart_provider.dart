import 'package:ccp_mobile/core/models/cart_item.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  String? _selectedClient; 
  List<CartItem> get items => _items;

  void addToCart(Product product) {
    final index = _items.indexWhere((item) => item.product.sku == product.sku);
    if (index >= 0) {
      _items[index].quantity += 1;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _items.removeWhere((item) => item.product.sku == product.sku);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

    void removeProduct(Product product) {
    _items.removeWhere((item) => item.product.sku == product.sku);
    notifyListeners();
  }

  void setClient(String client) {
    _selectedClient = client;
    notifyListeners();
  }
  String? get selectedClient => _selectedClient;
  int get itemCount => _items.fold(0, (total, item) => total + item.quantity);
}