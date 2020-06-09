import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _emailValue, _passwordValue;

  bool _isAcceptTerms = false;

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage('assets/background.jpg'),
    );
  }

  TextField _buildEmailTextField() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: 'E-mail', filled: true, fillColor: Colors.white),
      onChanged: (value) {
        _emailValue = value;
      },
    );
  }

  TextField _buildPasswordTextField() {
    return TextField(
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      onChanged: (value) {
        _passwordValue = value;
      },
    );
  }

  SwitchListTile _buildAcceptSwitch() {
    return SwitchListTile(
        title: Text('Accept Terms'),
        value: _isAcceptTerms,
        onChanged: (value) {
          setState(() {
            _isAcceptTerms = value;
          });
        });
  }

  void _submitForm() {
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * .95;
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Container(
          decoration: BoxDecoration(image: _buildBackgroundImage()),
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: targetWidth,
                child: Column(
                  children: <Widget>[
                    _buildEmailTextField(),
                    SizedBox(
                      height: 8.0,
                    ),
                    _buildPasswordTextField(),
                    SizedBox(
                      height: 8.0,
                    ),
                    _buildAcceptSwitch(),
                    RaisedButton(
                      textColor: Colors.white,
                      onPressed: _submitForm,
                      child: Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
