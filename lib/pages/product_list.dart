import 'package:flutter/material.dart';
import 'package:max_flutter_project/models/product.dart';
import 'package:max_flutter_project/pages/product_edit.dart';

class ProductListPage extends StatelessWidget {
  final List<Product> products;
  final Function updateProduct;
  final Function deleteProduct;

  ProductListPage(this.products, this.updateProduct, this.deleteProduct);

  Widget _buildListTile(BuildContext context, int index) {
    return ListTile(
        leading:
            CircleAvatar(backgroundImage: AssetImage(products[index].image)),
        title: Text(products[index].title),
        subtitle: Text('\$' + products[index].price.toString()),
        trailing: _buildEditButton(context, index));
  }

  Widget _buildEditButton(BuildContext context, int index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext contex) {
              return ProductEditPage(
                product: products[index],
                updateProduct: updateProduct,
                productIndex: index,
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          background: Container(
            color: Colors.red,
            child: Icon(
              Icons.delete_forever,
              color: Colors.white,
            ),
          ),
          key: Key(products[index].title),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              deleteProduct(index);
            }
          },
          child: Column(
            children: <Widget>[_buildListTile(context, index), Divider()],
          ),
        );
      },
      itemCount: products.length,
    );
  }
}
