import 'package:flutter/material.dart';

class BrowseConversationsScreen extends StatefulWidget {
  @override
  _BrowseConversationsScreenState createState() =>
      _BrowseConversationsScreenState();
}

class _BrowseConversationsScreenState extends State<BrowseConversationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(appBar: AppBar(title: Text('Browse Conversations!'))),
    );
  }
}
