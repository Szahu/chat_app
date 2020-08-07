import 'package:chat_app/Utils/constants.dart';
import 'package:chat_app/Utils/utils.dart';
import 'package:chat_app/screens/home/pick_image.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/dataBase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _editing = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    Widget _buildAppBar(String title) {
      return AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.blue[400]),
        ),
        actions: <Widget>[
          RawMaterialButton(
              child: Icon(
                Icons.exit_to_app,
                color: Colors.blue[400],
              ),
              onPressed: () {
                AuthService().signOut();
              })
        ],
        elevation: 0.0,
        backgroundColor: Colors.white,
      );
    }

    Widget _buildNameRow(String name) {
      if (_editing) {
        String value;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  decoration: textInputDecoration.copyWith(
                      hintText: 'enter new name here',
                      contentPadding: EdgeInsets.only(left: 10.0),
                      fillColor: Colors.grey[200]),
                  onChanged: (val) => value = val,
                ),
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.blue[400],
                ),
                onPressed: () {
                  if (value != null) {
                    DataBaseService()
                        .updateUserName(user.uid, name: value.trimRight());
                    setState(() {
                      _editing = false;
                    });
                  } else {
                    showDialogBox(context, 'Error',
                        'Name must have at least one character');
                  }
                }),
            IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    _editing = false;
                  });
                })
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Text(
              name,
              style: TextStyle(fontSize: 45.0, color: Colors.blue[400]),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                  icon: Icon(Icons.edit),
                  color: Colors.grey,
                  onPressed: () {
                    setState(() {
                      _editing = true;
                    });
                  },
                  padding: EdgeInsets.only(top: 5.0),
                  iconSize: 20.0,
                ),
              ),
            ),
          ],
        );
      }
    }

    return Container(
      child: FutureBuilder(
          future: DataBaseService().getUserData(user.uid),
          builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
            if (snapshot.hasError) {
              showDialogBox(context, 'Error', 'Couldnt fetch user data');
              return Container();
            } else if (snapshot.hasData) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: _buildAppBar('My Profile'),
                body: Column(
                  children: <Widget>[
                    SizedBox(height: 50),
                    CenterHorizontal(
                      CircleAvatar(
                        radius: 90,
                      ),
                    ),
                    SizedBox(height: 40.0),
                    _buildNameRow(snapshot.data.name),
                    RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return MyHomePage();
                            }),
                          );
                        },
                        child: Text('button')),
                  ],
                ),
              );
            } else {
              return Loading();
            }
          }),
    );
  }
}
