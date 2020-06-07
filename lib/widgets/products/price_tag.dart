import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  String price;

  PriceTag(this.price);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        '\$ $price',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
