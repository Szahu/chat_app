import 'package:chat_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/Utils/utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _inputeEmail;
  String _inputePassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 150.0),
              CenterHorizontal(
                Text(
                  'Sign in',
                  style: TextStyle(
                      color: Colors.blue[400],
                      fontSize: 40,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 55),
              Container(
                decoration: textInputBoxDecoration,
                child: TextFormField(
                  onChanged: (value) => _inputeEmail = value,
                  textAlign: TextAlign.center,
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                ),
              ),
              SizedBox(height: 35),
              Container(
                decoration: textInputBoxDecoration,
                child: TextFormField(
                  onChanged: (value) => _inputePassword = value,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Password'),
                ),
              ),
              SizedBox(height: 35),
              DecoratedRaisedButton(
                  label: 'Sign in',
                  onPressed: () {
                    print(_inputeEmail);
                    print(_inputePassword);
                  }),
              SizedBox(height: 20),
              Text(
                '- OR -',
                style: TextStyle(color: Colors.grey, fontSize: 15.0),
              ),
              SizedBox(height: 18),
              Row(
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
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Text(
                    '@NieStawho',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
