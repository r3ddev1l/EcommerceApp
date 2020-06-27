import 'package:flutter/material.dart';
import 'package:max_flutter_project/models/auth.dart';
import 'package:max_flutter_project/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

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
      onSaved: (value) {
        _formData['email'] = value;
      },
    );
  }

  TextFormField _buildPasswordTextField() {
    return TextFormField(
      controller: _passwordTextController,
      obscureText: true,
      validator: (String value) {
        if (value.length < 6) {
          return 'Invalid Password';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      onSaved: (value) {
        _formData['password'] = value;
      },
    );
  }

  TextFormField _buildPasswordConfirmTextField() {
    return TextFormField(
      validator: (String value) {
        if (_passwordTextController.text != value) {
          return 'Passwords do not match.';
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Confirm Password', filled: true, fillColor: Colors.white),
    );
  }

  SwitchListTile _buildAcceptSwitch() {
    return SwitchListTile(
        title: Text('Accept Terms'),
        value: _formData['acceptTerms'],
        onChanged: (value) {
          setState(() {
            _formData['acceptTerms'] = value;
          });
        });
  }

  void _submitForm(Function authenticate) async {
    if (!_formkey.currentState.validate() || !_formData['acceptTerms']) {
      return;
    }
    _formkey.currentState.save();
    Map<String, dynamic> successInformation;

    successInformation = await authenticate(
        _formData['email'], _formData['password'], _authMode);

    if (successInformation['success']) {
      Navigator.pushReplacementNamed(context, '/products');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('An Error Occurred!'),
              content: Text(successInformation['message']),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Okay'))
              ],
            );
          });
    }
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
                      _authMode == AuthMode.Signup
                          ? _buildPasswordConfirmTextField()
                          : Container(),
                      SizedBox(
                        height: 8.0,
                      ),
                      _buildAcceptSwitch(),
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              _authMode = _authMode == AuthMode.Login
                                  ? AuthMode.Signup
                                  : AuthMode.Login;
                            });
                          },
                          child: Text(
                              'Switch to ${_authMode == AuthMode.Login ? 'Sign Up' : 'Login'}')),
                      ScopedModelDescendant<MainModel>(builder:
                          (BuildContext context, Widget child,
                              MainModel model) {
                        return model.isLoading
                            ? CircularProgressIndicator()
                            : RaisedButton(
                                textColor: Colors.white,
                                onPressed: () =>
                                    _submitForm(model.authenticate),
                                child: Text(_authMode == AuthMode.Login
                                    ? 'Login'
                                    : 'Signup'),
                              );
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
