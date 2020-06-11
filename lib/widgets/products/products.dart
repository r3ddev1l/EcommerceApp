import 'package:flutter/material.dart';
import 'package:max_flutter_project/models/product.dart';
import 'package:max_flutter_project/widgets/products/product_card.dart';

class Products extends StatelessWidget {
  final List<Product> products;

  Products(this.products);

  Widget _buildProductList() {
    Widget productCards;
    products.length != 0
        ? productCards = ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                ProductCard(products[index], index),
            itemCount: products.length,
          )
        : productCards = Center(
            child: Text('Please enter a product.'),
          );
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }
}
