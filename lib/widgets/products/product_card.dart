import 'package:flutter/material.dart';
import 'package:max_flutter_project/models/product.dart';
import 'package:max_flutter_project/scoped_models/main.dart';
import 'package:max_flutter_project/widgets/products/address_tag.dart';
import 'package:max_flutter_project/widgets/products/price_tag.dart';
import 'package:max_flutter_project/widgets/ui_elements/title_default.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  Widget _buildTitlePriceRow() {
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleDefault(product.title),
          SizedBox(
            width: 8.0,
          ),
          PriceTag(
            product.price.toString(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsButton(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          onPressed: () => Navigator.pushNamed<bool>(
            context,
            '/product/' + productIndex.toString(),
          ),
          color: Theme.of(context).accentColor,
        ),
        ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
          return IconButton(
            icon: Icon(model.products[productIndex].isFavorite
                ? Icons.favorite
                : Icons.favorite_border),
            onPressed: () {
              model.selectProduct(productIndex);
              model.toggleProductFavoriteStatus();
            },
            color: Colors.red,
          );
        })
      ],
    );
  }

  ProductCard(this.product, this.productIndex);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product.image),
          _buildTitlePriceRow(),
          AddressTag('KTM, Old Baneshower'),
          _buildActionsButton(context)
        ],
      ),
    );
  }
}
