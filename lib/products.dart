import 'package:flutter/material.dart';
import 'package:max_flutter_project/pages/product.dart';

class Products extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function deleteProduct;

  Products(this.products, {this.deleteProduct});

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          Text(products[index]['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Product(
                            products[index]['title'], products[index]['image']),
                      ),
                    ).then((bool value) {
                      if (value) {
                        deleteProduct(index);
                      }
                    });
                  },
                  child: Text('Details'))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProductList() {
    Widget productCards;
    products.length != 0
        ? productCards = ListView.builder(
            itemBuilder: _buildProductItem,
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
