import 'package:flutter/material.dart';

import '../features/login/views/login_view.dart';
import '../features/products/views/product_view.dart';

class AppRoutes {

  static const String login = '/login';
  static const String products = '/products';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginView(),
    products: (context) => const ProductView(),
  };


}