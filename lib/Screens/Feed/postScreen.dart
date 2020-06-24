import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

import 'package:moimapp/helper/constants.dart';

class PostScreen extends StatefulWidget{
  final documentID;
  final title;
  final userID;
  final content;

  @override
  PostScreen({@required this.documentID, this.title, this.userID, this.content});
  
  @override
  PostScreenState createState() => PostScreenState();
}

class PostScreenState extends State<PostScreen>{
  DocumentReference post;
  String lastCreated;
  DocumentSnapshot postSnapshot;
  CollectionReference replyCollection;

  Future _setDocument() async {
    post = Firestore.instance.collection(Constants.myCollege).document('path').collection('post').document(widget.documentID);
    lastCreated = await post.get().then((document) => document.data['last_created']);
    replyCollection = post.collection('replies');
  }

  Widget _loadingScreen(){
    return Center(
      child: CircularProgressIndicator()
    );
  }

  Widget replyArea(TextEditingController reply) {
    return ListTile(
      title: TextField(
          autofocus: false,
          controller: reply,
          decoration: InputDecoration(
              labelText: 'Leave a reply.'
          )
      ),
      trailing: FlatButton(
          onPressed: () async {
            await replyCollection.add({
              'user' : widget.userID,
              'reply_content': reply.text,
              'reply_time': DateTime.now().toString(),
              'num_like': 0,
            });
          },
          child: Icon(Icons.reply),
      ),
    );
  }

  Widget _postScreen(){
    TextEditingController replyController = new TextEditingController();

    return Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(widget.userID)
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(lastCreated)
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(widget.content)
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: replyArea(replyController),
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 300,
                  child: StreamBuilder(
                    stream: replyCollection.snapshots(),
                    builder: (context, snapshot){
                      if(snapshot.hasError){
                        return _loadingScreen();
                      }
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return _loadingScreen();
                      }else{
                        int replyCount = snapshot.data.documents.length;
                        return replyCount != 0 ? ListView.builder(
                            itemCount: replyCount,
                            itemBuilder: (context, index){
                              return ListTile(
                                title: Text(snapshot.data.documents[index].data['reply_content']),
                                trailing: Text(snapshot.data.documents[index].data['user']),
                              );
                            }
                        ): Container(
                          child: Center(
                            child: Text("no reply yet")
                          )
                        );
                      }
                    }
                  )
                )
            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: _setDocument(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              return _loadingScreen();
            }
            return _postScreen();
          }
          return _loadingScreen();
        }
      )
    );
  }
}