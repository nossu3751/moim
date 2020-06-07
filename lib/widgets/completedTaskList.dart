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
              case ConnectionState.waiting:
                return Container(
                    child: Center(
                        child: CircularProgressIndicator()
                    )
                );
              default:
                return Container(
                  constraints: BoxConstraints.expand(),
                  child:ListView(
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
                                await widget.incompleteCollection.add({
                                  'name': document['name'],
                                  'content': document['content'],
                                  'due_time': document['due_time'],
                                  'year': document['year'],
                                  'month': document['month'],
                                  'date': document['date'],
                                  'hour': document['hour'],
                                  'minute': document['minute'],
                                });
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
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                            secondaryBackground: Padding(
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: new BorderRadius.all(Radius.circular(20)),
                                    color: Colors.blueAccent,
                                  ),
                                  child: Icon(Icons.arrow_back, color: Colors.white),
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
                  )
                );
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.delete),
        onPressed: (){
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
                title: Text("Clear completed task list"),
                content: Text("Would you like to remove all completed task items?"),
                actions: <Widget> [
                  FlatButton(
                      child: Text("Cancel"),
                      onPressed:(){
                        Navigator.of(context, rootNavigator: true).pop('dialog');
                      }
                  ),
                  FlatButton(
                    child: Text("Remove All"),
                    onPressed:(){
                      widget.completedCollection.getDocuments().then((snapshot){
                        for(DocumentSnapshot doc in snapshot.documents){
                          doc.reference.delete();
                        }
                      });
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    }
                  )
                ]
            )
          );
        }
      ),
    );
  }
}