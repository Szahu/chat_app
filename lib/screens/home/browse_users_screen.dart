import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/Utils/constants.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:provider/provider.dart';
import "package:chat_app/services/dataBase_service.dart";

class UserTile extends StatefulWidget {
  UserTile({this.userData});
  @override
  _UserTileState createState() => _UserTileState();
  final userData;
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return widget.userData.uid == user.uid
        ? Container()
        : ListTile(
            leading: CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.blue[100],
            ),
            title: Text(widget.userData.name),
            trailing: RawMaterialButton(
                child: Icon(
                  Iconic.pencil,
                  size: 20.0,
                ),
                shape: CircleBorder(),
                onPressed: () async {
                  DataBaseService().createChatRoom(List.from(
                      {User(uid: user.uid), User(uid: widget.userData.uid)}));
                }),
          );
  }
}

class BrowseUsersScreen extends StatefulWidget {
  @override
  _BrowseUsersScreenState createState() => _BrowseUsersScreenState();
}

class _BrowseUsersScreenState extends State<BrowseUsersScreen> {
  @override
  Widget build(BuildContext context) {
    final _searchButton = new Container(
        margin: EdgeInsets.all(10.0),
        child: RawMaterialButton(
          child: Icon(
            Icons.search,
            color: Colors.blue[400],
          ),
          onPressed: () {},
          shape: CircleBorder(),
          elevation: 2.0,
        ));
    final usersData = Provider.of<List<UserData>>(context);

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title:
              Text('Browse Users!', style: TextStyle(color: Colors.blue[400])),
          actions: <Widget>[_searchButton],
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: ListView.builder(
              itemCount: usersData.length,
              itemBuilder: (context, index) {
                return UserTile(userData: usersData[index]);
              }),
        ),
      ),
    );
  }
}
