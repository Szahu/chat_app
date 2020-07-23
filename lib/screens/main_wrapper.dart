import 'package:chat_app/screens/auth_wrapper.dart';
import 'package:chat_app/screens/home.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      print(user.uid);
      return Home();
    }
  }
}
