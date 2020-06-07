import 'package:flutter/material.dart';
import 'package:max_flutter_project/widgets/products/products.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  ProductsPage(
    this.products,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Choose'),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Manage Product'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite), onPressed: () {})
        ],
        title: Text('EasyList'),
      ),
      body: Products(products),
    );
  }
}
