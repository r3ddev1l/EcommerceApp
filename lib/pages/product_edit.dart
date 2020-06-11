import 'package:flutter/material.dart';
import 'package:max_flutter_project/models/product.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Product product;
  final int productIndex;

  ProductEditPage(
      {this.addProduct, this.updateProduct, this.product, this.productIndex});
  @override
  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };

  _buildTitleTextField() {
    return TextFormField(
      initialValue: widget.product == null ? '' : widget.product.title,
      decoration: InputDecoration(
        labelText: 'Title',
      ),
      onSaved: (String value) {
        _formData['title'] = value;
      },
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'Title must not be empty and must be 10+ characters long';
        }
        return null;
      },
    );
  }

  _buildDescTextField() {
    return TextFormField(
      initialValue: widget.product == null ? '' : widget.product.description,
      decoration: InputDecoration(
        labelText: 'Product Description',
      ),
      maxLines: 4,
      onSaved: (String value) {
        _formData['description'] = value;
      },
      validator: (String value) {
        if (value.isEmpty || value.length < 20) {
          return 'Description must not be empty and must be 20+ characters long';
        }
        return null;
      },
    );
  }

  _buildPriceTextField() {
    return TextFormField(
      initialValue:
          widget.product == null ? '' : widget.product.price.toString(),
      decoration: InputDecoration(
        labelText: 'Product Price',
      ),
      keyboardType: TextInputType.number,
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price must not be empty and must be a number';
        }
        return null;
      },
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (widget.product == null) {
      widget.addProduct(Product(
          title: _formData['title'],
          description: _formData['description'],
          image: _formData['image'],
          price: _formData['price']));
    } else {
      widget.updateProduct(
          widget.productIndex,
          Product(
              title: _formData['title'],
              description: _formData['description'],
              image: _formData['image'],
              price: _formData['price']));
    }

    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildPageContent(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 500 : deviceWidth * .95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(),
              _buildDescTextField(),
              _buildPriceTextField(),
              SizedBox(
                height: 8.0,
              ),
              RaisedButton(
                textColor: Colors.white,
                onPressed: _submitForm,
                child: Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget pageContent = _buildPageContent(context);
    return widget.product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Product'),
            ),
            body: pageContent,
          );
  }
}
