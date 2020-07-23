import 'dart:ui';

import 'package:chat_app/Utils/constants.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/Utils/utils.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleView;
  LoginScreen({this.toggleView});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _inputEmail;
  String _inputPassword;
  final _formKey = GlobalKey<FormState>();
  bool _applyBlur = false;
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    Widget _buildTitleText() {
      return CenterHorizontal(
        Text(
          'Sign in',
          style: TextStyle(
              color: Colors.blue[400],
              fontSize: 40,
              fontWeight: FontWeight.w500),
        ),
      );
    }

    Widget _buildEmailInputField() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 6.0),
        decoration: textInputBoxDecoration,
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

    Future<void> _showDialogBox(String dialogText) async {
      setState(() {
        _applyBlur = true;
      });
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error!'),
            content: Text(dialogText),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _applyBlur = false;
                  },
                  child: Text('Okay'))
            ],
          );
        },
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
              style: TextStyle(fontSize: 23.0, color: Colors.white),
            ),
            padding: EdgeInsets.symmetric(horizontal: 37.0, vertical: 10.0),
            color: Colors.blue,
            onPressed: () async {
              FocusScope.of(context).unfocus();
              setState(() {
                _loading = true;
                _applyBlur = true;
              });
              if (_inputEmail != null && _inputPassword != null) {
                dynamic result = await AuthService()
                    .signInWithEmailAndPassword(_inputEmail, _inputPassword);

                switch (result) {
                  case 1:
                    {
                      print('invalid email');
                      _showDialogBox('invalid email');
                    }
                    break;
                  case 2:
                    {
                      print('invalid password');
                      _showDialogBox('invalid password');
                    }
                    break;
                  case 3:
                    {
                      print('user not found');
                      _showDialogBox('user not found');
                    }
                    break;
                  case 4:
                    {
                      print('too many requesst');
                      _showDialogBox('too many requesst');
                    }
                    break;
                  default:
                    {
                      print('somehing went wrong');
                      _showDialogBox('somehing went wrong');
                    }
                    break;
                }
              }
              setState(() {
                _loading = false;
                _applyBlur = false;
              });
            }),
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
              'Register',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
            color: Colors.blue,
            onPressed: () {
              widget.toggleView();
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
                    _buildSignInButton(),
                    SizedBox(height: 20),
                    Text(
                      '- OR -',
                      style: TextStyle(color: Colors.grey, fontSize: 15.0),
                    ),
                    SizedBox(height: 18),
                    _buildLogInIcons(),
                    SizedBox(height: 20.0),
                    _buildRegisterButton(),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        color: Colors.black.withOpacity(0.0),
                      ),
                    ),
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
