import 'package:flutter/material.dart';

class BrowseUsersScreen extends StatefulWidget {
  @override
  _BrowseUsersScreenState createState() => _BrowseUsersScreenState();
}

class _BrowseUsersScreenState extends State<BrowseUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(appBar: AppBar(title: Text('Browse Users!'))),
    );
  }
}
