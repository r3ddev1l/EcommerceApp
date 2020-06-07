import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;
  ProductCreatePage(this.addProduct);
  @override
  _ProductCreatePageState createState() => _ProductCreatePageState();
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String _titleValue;

  String _description;

  double _price;

  _buildTitleTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Title',
      ),
      onChanged: (value) {
        _titleValue = value;
      },
    );
  }

  _buildDescTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Product Description',
      ),
      maxLines: 4,
      onChanged: (value) {
        _description = value;
      },
    );
  }

  _buildPriceTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Product Price',
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        _price = double.parse(value);
      },
    );
  }

  void _submitForm() {
    final Map<String, dynamic> product = {
      'title': _titleValue,
      'description': _description,
      'price': _price,
      'image': 'assets/food.jpg'
    };
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          _buildTitleTextField(),
          _buildDescTextField(),
          _buildPriceTextField(),
          SizedBox(
            height: 8.0,
          ),
          RaisedButton(
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            onPressed: _submitForm,
            child: Text('Create'),
          )
        ],
      ),
    );
  }
}
