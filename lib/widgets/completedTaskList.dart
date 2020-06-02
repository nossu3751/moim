import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CompletedTasksList extends StatefulWidget{
  final completedCollection = Firestore.instance.collection('rhosungCompletedTasks');
  final incompleteCollection = Firestore.instance.collection('rhosung_tasks');
  @override
  CompletedTasksListState createState() => CompletedTasksListState();
}

class CompletedTasksListState extends State<CompletedTasksList>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: widget.completedCollection.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState){
              case ConnectionState.waiting: return Text('Loading...');
              default:
                return ListView(
                  children: snapshot.data.documents.map((DocumentSnapshot document){
                    if(snapshot.data == null) {
                      return Text('No data to show');
                    }else{
                      return Dismissible(
                          child: Card(
                              child: ListTile(
                                title: Text(document['name']),
                              )
                          ),
                          key: Key(document.documentID.toString()),
                          onDismissed: (direction) async {
                            if(direction == DismissDirection.startToEnd){
                              await widget.completedCollection.document(document.documentID).delete();
                            }else if(direction == DismissDirection.endToStart){
                              await widget.incompleteCollection.add({'name': document['name']});
                              await widget.completedCollection.document(document.documentID).delete();
                            }
                          },
                          background: Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: new BorderRadius.all(Radius.circular(20)),
                                color: Colors.red,
                              ),
                              child: Icon(Icons.remove),
                            ),
                          ),
                          secondaryBackground: Padding(
                              padding: EdgeInsets.all(5),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.all(Radius.circular(20)),
                                  color: Colors.blueAccent,
                                ),
                                child: Icon(Icons.arrow_back),
                              )
                          )
//                        onDismissed:(direction){
//                          setState(() async{
//                            await widget.collection.document(document.documentID).delete();
//                          });
//                        }
                      );
                    }
                  }).toList(),
                );
            }
          }
      ),
    );
  }
}