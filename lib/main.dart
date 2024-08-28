import 'package:flutter/material.dart';
import 'package:flutter_rest_api/screens/products_screen.dart';
import 'package:flutter_rest_api/screens/second_api.dart';
import 'package:flutter_rest_api/screens/user_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: ProductsScreen(),
    );
  }
}
