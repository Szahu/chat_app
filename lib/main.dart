import 'package:chat_app/screens/auth_wrapper.dart';
import 'package:chat_app/screens/main_wrapper.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().getUser,
      child: MaterialApp(home: MainWrapper()),
    );
  }
}
