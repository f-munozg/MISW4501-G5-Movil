import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CCP Mobile App',
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}

