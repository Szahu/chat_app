import 'dart:ui';

import 'package:chat_app/Utils/constants.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/Utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  final Function toggleView;
  RegisterScreen({this.toggleView});
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _inputEmail;
  String _inputPassword;
  String _inputPasswordConfrim;
  final _formKey = GlobalKey<FormState>();
  bool _applyBlur = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    Widget _buildTitleText() {
      return CenterHorizontal(
        Text(
          'Sign up',
          style: TextStyle(
              color: Colors.blue[400],
              fontSize: 40,
              fontWeight: FontWeight.w500),
        ),
      );
    }

    Widget _buildEmailInputField() {
      return Container(
        decoration: textInputBoxDecoration,
        margin: EdgeInsets.symmetric(horizontal: 6.0),
        child: TextFormField(
          onChanged: (value) => _inputEmail = value.trimRight(),
          textAlign: TextAlign.center,
          decoration: textInputDecoration.copyWith(hintText: 'Email'),
        ),
      );
    }

    Widget _buildPasswordInputField() {
      return Container(
        decoration: textInputBoxDecoration,
        margin: EdgeInsets.symmetric(horizontal: 6.0),
        child: TextFormField(
          onChanged: (value) => _inputPassword = value.trimRight(),
          textAlign: TextAlign.center,
          obscureText: true,
          decoration: textInputDecoration.copyWith(hintText: 'Password'),
        ),
      );
    }

    Widget _buildPasswordRepeatInputField() {
      return Container(
        decoration: textInputBoxDecoration,
        margin: EdgeInsets.symmetric(horizontal: 6.0),
        child: TextFormField(
          onChanged: (value) => _inputPasswordConfrim = value.trimRight(),
          textAlign: TextAlign.center,
          obscureText: true,
          decoration:
              textInputDecoration.copyWith(hintText: 'Confirm Password'),
        ),
      );
    }

    Widget _buildRegisterButton() {
      return Container(
        decoration: textInputBoxDecoration.copyWith(color: Colors.transparent),
        child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
              side: BorderSide(color: Colors.blue, width: 3.0),
            ),
            child: Text(
              'Sign up!',
              style: TextStyle(fontSize: 23.0, color: Colors.white),
            ),
            padding: EdgeInsets.symmetric(horizontal: 37.0, vertical: 10.0),
            color: Colors.blue,
            onPressed: () async {
              if (_inputEmail != null &&
                  _inputPassword != null &&
                  _inputPasswordConfrim != null) {
                setState(() {
                  _loading = true;
                  _applyBlur = true;
                });
                if (_inputPassword == _inputPasswordConfrim) {
                  dynamic result = await AuthService()
                      .registerWithEmailAndPassword(
                          _inputEmail, _inputPasswordConfrim);
                  if (result is! int) {
                    widget.toggleView(context);
                  }
                  if (result is int) {
                    switch (result) {
                      case 1:
                        {
                          print('invalid email');
                          showDialogBox(context, 'Error - Invalid email!',
                              'The email is wrongly formatted.');
                        }
                        break;
                      case 2:
                        {
                          print('weak password');
                          showDialogBox(context, 'Error - Weak password!',
                              'Provided password is too weak.');
                        }
                        break;
                      case 3:
                        {
                          print('Email already in use');
                          showDialogBox(
                              context,
                              'Error - Email already in use!',
                              'This email is already assigned to another account.');
                        }
                        break;
                      default:
                        {
                          print('somehing went wrong');
                          showDialogBox(context, 'Error - Unexpected error',
                              'Something went wrong :(');
                        }
                        break;
                    }
                  }
                } else {
                  print('Passwords must match!');
                  showDialogBox(context, 'Error - Passwords no match!',
                      'Given passwords doesn\'t match');
                }
              } else {
                print('No field can be empty!');
              }
              setState(() {
                _loading = false;
                _applyBlur = false;
              });
            }),
      );
    }

    Widget _buildSignInButton() {
      return Container(
        decoration: textInputBoxDecoration.copyWith(color: Colors.transparent),
        child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
              side: BorderSide(color: Colors.blue, width: 3.0),
            ),
            child: Text(
              'Sign in',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
            color: Colors.blue,
            onPressed: () {
              widget.toggleView(context);
            }),
      );
    }

    Widget _buildLogInIcons() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {},
            elevation: 3.0,
            fillColor: Colors.white,
            child: Center(
              child: Image(
                image: AssetImage('assets/google_icon.png'),
                width: 35,
                height: 35,
              ),
            ),
            padding: EdgeInsets.all(10.0),
            shape: CircleBorder(),
          ),
          RawMaterialButton(
            onPressed: () {},
            elevation: 3.0,
            fillColor: Colors.white,
            child: Center(
              child: Image(
                image: AssetImage('assets/facebook_icon.png'),
                width: 35,
                height: 35,
              ),
            ),
            padding: EdgeInsets.all(10.0),
            shape: CircleBorder(),
          )
        ],
      );
    }

    Widget _blurFilter() {
      return !_applyBlur
          ? Container()
          : BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 2,
                sigmaY: 2,
              ),
              child: Container(
                color: Colors.black.withOpacity(0),
              ),
            );
    }

    Widget _buildLoadingIcon() {
      return _loading ? Loading() : Container();
    }

    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 44.0),
          child: Form(
            key: _formKey,
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    _buildTitleText(),
                    SizedBox(height: 55),
                    _buildEmailInputField(),
                    SizedBox(height: 35),
                    _buildPasswordInputField(),
                    SizedBox(height: 35),
                    _buildPasswordRepeatInputField(),
                    SizedBox(height: 35),
                    _buildRegisterButton(),
                    SizedBox(height: 20),
                    Text(
                      '- OR -',
                      style: TextStyle(color: Colors.grey, fontSize: 15.0),
                    ),
                    SizedBox(height: 18),
                    _buildLogInIcons(),
                    SizedBox(height: 20.0),
                    _buildSignInButton(),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
        ),
        _blurFilter(),
        _buildLoadingIcon(),
      ]),
    );
  }
}
