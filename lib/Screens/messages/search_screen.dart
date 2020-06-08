import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moimapp/Screens/messages/conversation_screen.dart';
import 'package:moimapp/Widgets/round_button.dart';
import 'package:moimapp/helper/constants.dart';
import 'package:moimapp/services/database_methods.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController =
      new TextEditingController();

  QuerySnapshot searchSnapshot;

  initiateSearch() {
    databaseMethods
        .getUserByName(
            'Mount Holyoke College', searchTextEditingController.text)
        .then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  createChatRoomAndStartConversation(String userName) {
    if (userName != Constants.myName) {
      List<String> users = [userName, Constants.myName];

      String chatRoomId = getChatRoomId(userName, Constants.myName);
      Map<String, dynamic> chatRoomMap = {
        'users': users,
        'chatroomId': chatRoomId
      };
      databaseMethods.createChatRoom(
          Constants.myCollege, chatRoomId, chatRoomMap);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ConversationScreen(chatRoomId);
      }));
    }
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                userName: searchSnapshot.documents[index].data['name'],
                email: searchSnapshot.documents[index].data['email'],
              );
            })
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.white, title: Text('Search Screen')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: searchTextEditingController,
                    decoration: InputDecoration(
                        hintText: 'search username...',
                        border: InputBorder.none),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Icon(Icons.search))
              ],
            ),
          ),
          searchList()
        ],
      ),
    );
  }

  Widget SearchTile({String userName, String email}) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[Text(userName), Text(email)],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                createChatRoomAndStartConversation(userName);
              },
              child: Container(
                child: RoundedButton(
                  text: 'Message',
                  fillColor: Colors.grey[350],
                ),
              ),
            ),
          ],
        ));
  }
}

// from Youtube
getChatRoomId(String a, String b) {
  //TODO: what if the first is the same?
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
