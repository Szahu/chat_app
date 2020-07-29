import 'package:chat_app/Utils/utils.dart';
import 'package:chat_app/screens/home/browse_conversations_screen.dart';
import 'package:chat_app/screens/home/browse_users_screen.dart';
import 'package:chat_app/screens/home/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _pageController = PageController(
    initialPage: 1,
  );
  @override
  Widget build(BuildContext context) {
    Widget _buildNavigationButton(Function onTap, Icon icon) {
      return RawMaterialButton(
        onPressed: onTap,
        child: icon,
        shape: CircleBorder(),
        padding: EdgeInsets.all(2.0),
        focusColor: Colors.black.withOpacity(0.0),
        highlightColor: Colors.transparent,
      );
    }

    return Scaffold(
      body: Container(
        child: PageView(
          controller: _pageController,
          children: <Widget>[
            BrowseConversationsScreen(),
            BrowseUsersScreen(),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildNavigationButton(() {
                  _pageController.animateToPage(0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease);
                },
                    Icon(
                      Icons.message,
                      color: Colors.blue,
                    )),
                _buildNavigationButton(() {
                  _pageController.animateToPage(1,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease);
                },
                    Icon(
                      Icons.people,
                      color: Colors.blue,
                    )),
                _buildNavigationButton(() {
                  _pageController.animateToPage(2,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease);
                },
                    Icon(
                      Icons.person,
                      color: Colors.blue,
                    )),
              ],
            )),
      ),
    );
  }
}
