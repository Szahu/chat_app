import 'package:chat_app/Utils/constants.dart';
import 'package:chat_app/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/Utils/utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _inputEmail;
  String _inputPassword;
  final _formKey = GlobalKey<FormState>();

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
        decoration: textInputBoxDecoration,
        child: TextFormField(
          onChanged: (value) => _inputEmail = value,
          textAlign: TextAlign.center,
          decoration: textInputDecoration.copyWith(hintText: 'Email'),
        ),
      );
    }

    Widget _buildPasswordInputField() {
      return Container(
        decoration: textInputBoxDecoration,
        child: TextFormField(
          onChanged: (value) => _inputPassword = value,
          textAlign: TextAlign.center,
          obscureText: true,
          decoration: textInputDecoration.copyWith(hintText: 'Password'),
        ),
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
              'Sign In',
              style: TextStyle(fontSize: 23.0, color: Colors.white),
            ),
            padding: EdgeInsets.symmetric(horizontal: 37.0, vertical: 10.0),
            color: Colors.blue,
            onPressed: () {
              //AuthService().registerWithEmailAndPassword(
              //    _inputeEmail, _inputePassword);
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

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
