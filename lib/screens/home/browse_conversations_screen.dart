import 'package:chat_app/Utils/utils.dart';
import 'package:chat_app/screens/home/conversation_screen.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/services/dataBase_service.dart';

Route _createRoute(BuildContext context, Widget nextPage, bool up) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => nextPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = up ? Offset(0.0, 1.0) : Offset(0.0, -1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class ConversationTile extends StatefulWidget {
  final convData;
  ConversationTile({this.convData});
  @override
  _ConversationTileState createState() => _ConversationTileState();
}

class _ConversationTileState extends State<ConversationTile> {
  @override
  Widget build(BuildContext context) {
    final loggedUser = Provider.of<User>(context);
    String anotherUser = loggedUser.uid == widget.convData.users_uids[0]
        ? widget.convData.users_uids[1]
        : widget.convData.users_uids[0];
    return ListTile(
      title: FutureBuilder(
        future: DataBaseService().getUserData(anotherUser),
        builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
          if (snapshot.hasData) {
            return Text('You and ' + snapshot.data.name);
          }
          if (snapshot.hasError) {
            showDialogBox(context, 'Error', 'Error');
            return Text('');
          }
          return Text('');
        },
      ),
      onTap: () {
        Navigator.of(context).push(_createRoute(
            context,
            StreamProvider<List<MessageData>>.value(
                initialData: List(),
                value: widget.convData.messagesStream,
                child: ConversationScreen(
                  convData: widget.convData,
                )),
            true));
      },
    );
  }
}

class BrowseConversationsScreen extends StatefulWidget {
  @override
  _BrowseConversationsScreenState createState() =>
      _BrowseConversationsScreenState();
}

class _BrowseConversationsScreenState extends State<BrowseConversationsScreen> {
  @override
  Widget build(BuildContext context) {
    final convData = Provider.of<List<ConversationData>>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Browse Conversations!',
            style: TextStyle(color: Colors.blue[400])),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: convData.length,
          itemBuilder: (context, index) {
            return ConversationTile(convData: convData[index]);
          }),
    );
  }
}
