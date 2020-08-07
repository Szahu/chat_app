import 'package:chat_app/Utils/constants.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/dataBase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationScreen extends StatefulWidget {
  final convData;
  ConversationScreen({this.convData});
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  String _inputMessage;
  final ScrollController _scrollController = ScrollController();
  var _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final messages = Provider.of<List<MessageData>>(context);
    final loggedUser = Provider.of<User>(context);
    messages.sort((a, b) {
      int aStamp = int.parse(a.timeStamp);
      int bStamp = int.parse(b.timeStamp);
      return aStamp.compareTo(bStamp);
    });

    Widget _buildMessageBox(MessageData messageData) {
      bool _senderIsMe = messageData.sender == loggedUser.uid ? true : false;
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
            color: _senderIsMe ? Colors.blue : Colors.blue[300],
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[400],
                  offset: Offset(2.0, 2.0),
                  blurRadius: 2.0)
            ],
            borderRadius: BorderRadius.circular(25.0)),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.5),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Text(
            messageData.message.toString(),
            style: TextStyle(fontSize: 15.0, color: Colors.white),
            softWrap: true,
          ),
        ),
      );
    }

    List<Widget> _buildMessagesColumn() {
      List<Widget> messagesWidgets = List();
      messagesWidgets.add(SizedBox(height: 10.0));
      messages.forEach((message) {
        messagesWidgets.add(Row(
          mainAxisAlignment: message.sender == loggedUser.uid
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: <Widget>[
            _buildMessageBox(message),
          ],
        ));
        messagesWidgets.add(SizedBox(height: 10.0));
      });
      messagesWidgets.add(SizedBox(height: 80.0));
      return messagesWidgets;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue[400]),
        title: Text(
          'Conversation',
          style: TextStyle(
            fontSize: 25,
            color: Colors.blue[400],
          ),
        ),
        elevation: 0.0,
      ),
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                  children: _buildMessagesColumn().isEmpty
                      ? <Widget>[
                          Container(
                            height: 100,
                          )
                        ]
                      : _buildMessagesColumn()),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: TextField(
                          controller: _textFieldController,
                          decoration: textInputDecoration.copyWith(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                              fillColor: Colors.grey[100],
                              hintText: 'Message here'),
                          onChanged: (val) => _inputMessage = val,
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.blue[400],
                        ),
                        onPressed: () async {
                          await DataBaseService().sentMessageToChatRoom(
                              loggedUser.uid,
                              widget.convData.documentPath,
                              _inputMessage);

                          _scrollController.animateTo(999999999999,
                              duration: Duration(seconds: 1),
                              curve: Curves.ease);
                          FocusScope.of(context).unfocus();
                          _textFieldController.clear();
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
