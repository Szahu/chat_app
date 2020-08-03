import 'package:chat_app/Utils/utils.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/dataBase_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Spacer(),
                        Text(
                          snapshot.data.name,
                          style: TextStyle(
                              fontSize: 45.0, color: Colors.blue[400]),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              color: Colors.grey,
                              onPressed: () {},
                              padding: EdgeInsets.only(top: 5.0),
                              iconSize: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
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
