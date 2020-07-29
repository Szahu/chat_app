import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  Widget _loginScreen;
  Widget _registerScreen;
  _AuthenticateState() {
    _loginScreen = LoginScreen(toggleView: toggleView);
    _registerScreen = RegisterScreen(toggleView: toggleView);
  }
  void toggleView(BuildContext context) {
    Widget nextPage = showSignIn ? _registerScreen : _loginScreen;
    if (showSignIn) {
      showSignIn = !showSignIn;

      Navigator.of(context).push(_createRoute(context, nextPage, showSignIn));
    } else {
      showSignIn = !showSignIn;

      Navigator.of(context).pop();
    }
  }

  Route _createRoute(BuildContext context, Widget nextPage, bool up) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => nextPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = up ? Offset(0.0, 1.0) : Offset(0.0, -1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Container(child: _loginScreen);
    } else {
      return Container(child: _registerScreen);
    }
  }
}
