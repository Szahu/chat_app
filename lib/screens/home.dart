import 'package:chat_app/screens/home/browse_conversations_screen.dart';
import 'package:chat_app/screens/home/browse_users_screen.dart';
import 'package:chat_app/screens/home/profile_screen.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/dataBase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:provider/provider.dart';

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
    final user = Provider.of<User>(context);
    Widget _buildNavigationButton(Function onTap, Icon icon) {
      return Expanded(
        child: RawMaterialButton(
          onPressed: onTap,
          child: icon,
          focusColor: Colors.black.withOpacity(0.0),
          highlightColor: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 13.0),
        ),
      );
    }

    return Scaffold(
      body: Container(
        child: PageView(
          controller: _pageController,
          children: <Widget>[
            StreamProvider<List<ConversationData>>.value(
                initialData: List(),
                value: DataBaseService().getConvData(user.uid),
                child: BrowseConversationsScreen()),
            StreamProvider<List<UserData>>.value(
                initialData: List(),
                value: DataBaseService().usersData,
                child: BrowseUsersScreen()),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildNavigationButton(() {
              _pageController.animateToPage(0,
                  duration: Duration(milliseconds: 200), curve: Curves.ease);
            },
                Icon(
                  Iconic.chat,
                  color: Colors.blue,
                )),
            _buildNavigationButton(() {
              _pageController.animateToPage(1,
                  duration: Duration(milliseconds: 200), curve: Curves.ease);
            },
                Icon(
                  Iconic.book,
                  color: Colors.blue,
                )),
            _buildNavigationButton(() {
              _pageController.animateToPage(2,
                  duration: Duration(milliseconds: 200), curve: Curves.ease);
            },
                Icon(
                  Iconic.user,
                  color: Colors.blue,
                )),
          ],
        ),
      ),
    );
  }
}
