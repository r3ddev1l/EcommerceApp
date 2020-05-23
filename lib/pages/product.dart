import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Product extends StatelessWidget {
  final String title;
  final String imageUrl;

  Product(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('object');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(imageUrl),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('Delete'),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
