import 'package:flutter/material.dart';
import 'package:max_flutter_project/pages/auth.dart';
import 'package:max_flutter_project/pages/product.dart';
import 'package:max_flutter_project/pages/products.dart';
import 'package:max_flutter_project/pages/products_admin.dart';
import 'package:max_flutter_project/scoped_models/products.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ProductsModel>(
        model: ProductsModel(),
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.red,
            accentColor: Colors.deepPurple,
            buttonColor: Colors.red,
          ),
          routes: {
            '/': (BuildContext context) => AuthPage(),
            '/products': (BuildContext context) => ProductsPage(),
            '/admin': (BuildContext context) => ProductsAdminPage(),
          },
          onGenerateRoute: (RouteSettings settings) {
            final List<String> pathElements = settings.name.split('/');
            if (pathElements[0] != '') {
              return null;
            }
            if (pathElements[1] == 'product') {
              final int index = int.parse(pathElements[2]);
              return MaterialPageRoute<bool>(
                builder: (BuildContext context) => ProductPage(index),
              );
            }
            return null;
          },
          onUnknownRoute: (RouteSettings settings) {
            return MaterialPageRoute(
              builder: (BuildContext context) => ProductsPage(),
            );
          },
        ));
  }
}
