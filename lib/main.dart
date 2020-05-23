import 'package:flutter/material.dart';
import 'package:max_flutter_project/pages/products.dart';
import 'package:max_flutter_project/pages/products_admin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (BuildContext context) => ProductsPage(),
        '/admin': (BuildContext context) => ProductsAdminPage(),
      },
      theme: ThemeData(
          primarySwatch: Colors.deepOrange, accentColor: Colors.deepPurple),
//      home: AuthPage(),
    );
  }
}
