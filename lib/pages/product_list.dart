import 'package:flutter/material.dart';
import 'package:max_flutter_project/pages/product_edit.dart';
import 'package:max_flutter_project/scoped_models/products.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatelessWidget {
  Widget _buildEditButton(
      BuildContext context, int index, ProductsModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(index);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductEditPage();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            background: Container(
              color: Colors.red,
            ),
            key: Key(model.products[index].title),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                model.selectProduct(index);
                model.deleteProduct();
              }
            },
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                      backgroundImage: AssetImage(model.products[index].image)),
                  title: Text(model.products[index].title),
                  subtitle: Text('\$' + model.products[index].price.toString()),
                  trailing: _buildEditButton(context, index, model),
                ),
                Divider()
              ],
            ),
          );
        },
        itemCount: model.products.length,
      );
    });
  }
}
