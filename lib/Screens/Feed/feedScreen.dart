import "package:flutter/material.dart";
import 'package:moimapp/Screens/Feed/postScreen.dart';
import 'package:moimapp/Screens/Feed/writePost.dart';
import 'package:moimapp/Screens/messages/conversation_screen.dart';
import 'package:moimapp/Screens/messages/search_screen.dart';
import 'package:moimapp/Screens/welcome/sign_in.dart';
import 'package:moimapp/Widgets/icon_button.dart';
import 'package:moimapp/helper/constants.dart';
import 'package:moimapp/helper/helperfunctions.dart';
import 'package:moimapp/services/auth.dart';
import 'package:moimapp/services/database_methods.dart';

class feedScreen extends StatefulWidget {
  @override
  feedScreenState createState() => feedScreenState();
}

class feedScreenState extends State<feedScreen> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream postStream;

  Widget FeedList() {
    return StreamBuilder(
      stream: postStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return ChatRoomTile(
                  title:
                  snapshot.data.documents[index].data['title'],
                  content: snapshot.data.documents[index].data['content']
                      .toString()
                      .replaceAll('_', '')
                      .replaceAll(Constants.myUsername, ''),
                  userID: snapshot.data.documents[index].data['writer'],
                  documentID: snapshot.data.documents[index].documentID,
              );
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
    databaseMethods
        .getAllPosts(Constants.myCollege, Constants.myUsername)
        .then((value) {
      setState(() {
        postStream = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Feed', style: TextStyle(color:Colors.white)),
        elevation: 0,
      ),
      body: FeedList(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.create),
          onPressed: () {
            print(Constants.myUsername);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return WritePost();
            }));
          }),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String title;
  final String content;
  final String userID;
  final String documentID;

  const ChatRoomTile({Key key, this.title, this.content, this.userID, this.documentID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PostScreen(documentID: documentID, title: title, userID: userID, content: content,);
        }));
      },
      child: Container(
        padding: EdgeInsets.all(15),
        child: ListTile(
          title: Row(children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: <Widget>[
                Text(
                  content,
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ]),
          trailing: Text(
              userID,
              style: TextStyle(fontSize: 13)
          )


        ),
      ),
    );
  }
}
