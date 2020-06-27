import 'package:flutter/material.dart';
import 'package:max_flutter_project/models/product.dart';
import 'package:max_flutter_project/pages/auth.dart';
import 'package:max_flutter_project/pages/product.dart';
import 'package:max_flutter_project/pages/products.dart';
import 'package:max_flutter_project/pages/products_admin.dart';
import 'package:max_flutter_project/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  @override
  void initState() {
    _model.autoAuthenticate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
        model: _model,
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.red,
            accentColor: Colors.deepPurple,
            buttonColor: Colors.red,
          ),
          routes: {
            '/': (BuildContext context) =>
                _model.user == null ? AuthPage() : ProductsPage(_model),
            '/products': (BuildContext context) => ProductsPage(_model),
            '/admin': (BuildContext context) => ProductsAdminPage(_model),
          },
          onGenerateRoute: (RouteSettings settings) {
            final List<String> pathElements = settings.name.split('/');
            if (pathElements[0] != '') {
              return null;
            }
            if (pathElements[1] == 'product') {
              final String productId = pathElements[2];
              final Product product =
                  _model.allProducts.firstWhere((Product product) {
                return product.id == productId;
              });
              return MaterialPageRoute<bool>(
                builder: (BuildContext context) => ProductPage(product),
              );
            }
            return null;
          },
          onUnknownRoute: (RouteSettings settings) {
            return MaterialPageRoute(
              builder: (BuildContext context) => ProductsPage(_model),
            );
          },
        ));
  }
}
