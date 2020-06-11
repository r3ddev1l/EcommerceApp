import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _emailValue, _passwordValue;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _isAcceptTerms = false;

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage('assets/background.jpg'),
    );
  }

  TextFormField _buildEmailTextField() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Enter a valid email address';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: 'E-mail', filled: true, fillColor: Colors.white),
      onChanged: (value) {
        _emailValue = value;
      },
    );
  }

  TextFormField _buildPasswordTextField() {
    return TextFormField(
      obscureText: true,
      validator: (String value) {
        if (value.length < 5) {
          return 'Password length must be greater than 5';
        }
        return null;
      },
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
    if (_formkey.currentState.validate() && _isAcceptTerms)
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
                child: Form(
                  key: _formkey,
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
          ),
        ));
  }
}
