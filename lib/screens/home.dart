import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _showDialogBox() {
    return CupertinoAlertDialog(
      title: Text('dialog'),
      content: Text('this is content'),
      actions: [
        FlatButton(
          child: Text('ok'),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Center(
            child: RaisedButton(
                child: Text('show dialog box'),
                onPressed: () {
                  setState(() => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('this is dialog'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('This is a demo alert dialog.'),
                                Text(
                                    'Would you like to approve of this message?'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Okay'))
                          ],
                        );
                      },
                      barrierDismissible: true));
                }),
          ),
          Center(
            child: RaisedButton(
              child: Text('Sign out'),
              onPressed: () {
                AuthService().signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
