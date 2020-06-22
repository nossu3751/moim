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

  Future _setDocument() async {
    post = Firestore.instance.collection(Constants.myCollege).document('path').collection('post').document(widget.documentID);
    lastCreated = await post.get().then((document) => document.data['last_created']);
  }

  Widget _loadingScreen(){
    return Center(
      child: CircularProgressIndicator()
    );
  }

  Widget _postScreen(){
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