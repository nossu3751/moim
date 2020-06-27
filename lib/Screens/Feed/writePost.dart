import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moimapp/Widgets/highlight_text.dart';
import 'package:moimapp/Widgets/round_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moimapp/Screens/welcome/sign_in.dart';
import 'package:moimapp/helper/constants.dart';
import 'package:moimapp/services/auth.dart';
import 'package:moimapp/services/database_methods.dart';

class WritePost extends StatefulWidget {
  final collection = Firestore.instance.collection('testcourse');

  @override
  WritePostState createState() => WritePostState();
}

class WritePostState extends State<WritePost> {
  String title = "";
  String content = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: HighlightText(
            text: 'Write Post',
            fontStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        actions: <Widget>[
          // action button
          Container(
            width: size.width * 0.22,
            padding: EdgeInsets.all(8),
            child: RoundedButton(
              press: () async {
                await  Firestore.instance
                    .collection(Constants.myCollege)
                    .document('path')
                    .collection('post')
                    .add({
                  'title': title,
                  'content': content,
                  'writer': Constants.myUsername,
                  'last_created': DateTime.now().toString()
                });
                Navigator.pop(context);
              },
              text: 'Write',
              fillColor: Color(0xFFADD8E5),
              fontSize: 11,
            ),
          ),
        ],
      ),
      body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: Stack(
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                        ),
                        Container(
                            child: Column(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: TextField(
//                              controller: ,
                              textAlign: TextAlign.start,
                              onChanged: (value) {
                                title = value;
                              },
                              decoration: InputDecoration(
                                hasFloatingPlaceholder: false,
                                hintText: "Write Title",
                                contentPadding: EdgeInsets.all(12),
                                labelText: "Write Title",
                              ),
                            ),
                          ),
                        ])),
                        Container(
                            child: Column(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: TextField(
                              textAlign: TextAlign.start,
                              onChanged: (value) {
                                content = value;
                              },
                              decoration: InputDecoration(
                                hasFloatingPlaceholder: false,
                                hintText: "Write Content",
                                contentPadding: EdgeInsets.all(12),
                                labelText: "Write Content",
                              ),
                            ),
                          ),
                        ])),
                      ]),
                ],
              ))),
    );
  }

  CreatePost(String title, String content) async {
    Firestore.instance
        .collection(Constants.myCollege)
        .document('path')
        .collection('post')
        .add({
          'title': title,
          'content': content,
          'writer': Constants.myUsername,

    });
  }
}
