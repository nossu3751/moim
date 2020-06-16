//TODO: have to implement

import 'package:flutter/material.dart';
import 'package:moimapp/helper/constants.dart';
import 'package:moimapp/services/database_methods.dart';

class LastMessage extends StatefulWidget {
  final String chatroomId;
  LastMessage(this.chatroomId);
  @override
  _LastMessageState createState() => _LastMessageState();
}

class _LastMessageState extends State<LastMessage> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream conversationStream;
  TextEditingController messageTextEditingController =
      new TextEditingController();

  // if I want data to be refreshed all the time, then i need to use "STREAM"
  Widget ConversationList() {
    return StreamBuilder(
      stream: conversationStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      snapshot.data.documents[index].data['message'],
                      snapshot.data.documents[index].data['sendBy'] ==
                          Constants.myUsername);
                },
              )
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageTextEditingController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        'message': messageTextEditingController.text,
        'sendBy': Constants.myUsername,
        'time': DateTime.now().millisecondsSinceEpoch,
      };
      databaseMethods.addConversationMessages(
          Constants.myCollege, widget.chatroomId, messageMap);

      messageTextEditingController.text = '';
    }
  }

  @override
  void initState() {
    databaseMethods
        .getConversationMessages(Constants.myCollege, widget.chatroomId)
        .then((val) {
      setState(() {
        conversationStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white, title: Text('Conversation Screen')),
      body: Container(
        child: Stack(
          children: <Widget>[
            ConversationList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: messageTextEditingController,
                          decoration: InputDecoration(
                              hintText: 'Message', border: InputBorder.none),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            sendMessage();
                          },
                          child: Icon(Icons.send))
                    ],
                  ),
                ),
                // searchList()
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;

  MessageTile(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 11),
            decoration: isSendByMe
                ? BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                        bottomLeft: Radius.circular(18)),
                  )
                : BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(18))),
            // borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(18),
            //     topRight: Radius.circular(18),
            //     bottomRight: Radius.circular(18))),
            child: Text(message),
          ),
        ),
      ],
    );
  }
}
