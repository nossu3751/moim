import "package:flutter/material.dart";
import 'package:moimapp/Screens/messages/search_screen.dart';
import 'package:moimapp/Screens/welcome/welcome_screen.dart';
import 'package:moimapp/Widgets/icon_button.dart';
import 'package:moimapp/helper/constants.dart';
import 'package:moimapp/helper/helperfunctions.dart';
import 'package:moimapp/services/auth.dart';
import 'package:moimapp/services/database_methods.dart';

class MessageHome extends StatefulWidget {
  @override
  _MessageHomeState createState() => _MessageHomeState();
}

class _MessageHomeState extends State<MessageHome> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatRoomStream;

  Widget ChatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return ChatRoomTile(
                      name: snapshot.data.documents[index].data['chatroomId']
                          .toString()
                          .replaceAll('_', '')
                          .replaceAll(Constants.myName, ''));
                })
            : Container();
      },
    );
  }

  // it is not a good practice to use asynk with initState
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNamePreference();
    Constants.myCollege = await HelperFunctions.getUserCollegePreference();
    databaseMethods
        .getAllChatRooms(Constants.myCollege, Constants.myName)
        .then((value) {
      setState(() {
        chatRoomStream = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.chevron_left),
        //   onPressed: () => Navigator.pop(context, false),
        // ),
        backgroundColor: Colors.white,
        title: Text('Messages'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.exit_to_app)),
          ),
        ],
      ),
      body: ChatRoomList(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SearchScreen();
            }));
          }),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String name;

  const ChatRoomTile({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[Icon(Icons.send), Text(name)]),
    );
  }
}
