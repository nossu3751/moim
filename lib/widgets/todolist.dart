import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moimapp/widgets/d_date_calculator.dart';
import 'package:moimapp/widgets/task.dart';

class TodoScaffold extends StatefulWidget{
//  final List<Task> tasks;
//  final onToggle;
  final collection = Firestore.instance.collection('rhosung_tasks');
  final completedCollection = Firestore.instance.collection('rhosungCompletedTasks');

//  TodoScaffold({@required this.tasks, @required this.onToggle});

  @override
  TodoScaffoldState createState() => TodoScaffoldState();
}
class TodoScaffoldState extends State<TodoScaffold>{

  @override
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        // list is ordered by due time
        stream: widget.collection.orderBy('due_time').snapshots(),
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
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                constraints: BoxConstraints.expand(),
                child: RefreshIndicator(
                  onRefresh: () async{
                    await Future.delayed(Duration(seconds: 2));
                    return null;
                  },
                  child: ListView(
                    children: snapshot.data.documents.map((DocumentSnapshot document){
                      if(snapshot.data == null) {
                        return Text('No data to show');
                      }else{
                        return Dismissible(
                            child: Padding(
                              padding: EdgeInsets.all(0),
                              child: Container(
                                  height: 90,
                                  child: Card(
                                    elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(0)
                                      ),
                                      child: Center(
                                          child: ListTile(
                                              title: Text(document['name']),
                                              trailing: Text(
//                                              document['due_time'] != null && document['due_time'] != ""?
//                                              document['due_time']:"not specified",
                                                document['due_time'] != null && document['due_time'] != "" ?
                                                (dDay(document['due_time'])):"not specified",
                                                style: TextStyle(color: Colors.grey, fontSize: 10),
                                              )
                                          )
                                      )
                                  )
                              ),
                            ),
                            key: Key(document.documentID.toString()),
                            onDismissed: (direction) async {
                              if(direction == DismissDirection.startToEnd){
                                await widget.completedCollection.add({
                                  'name': document['name'],
                                  'content': document['content'],
                                  'due_time': "",
                                  'year': "",
                                  'month': "",
                                  'date': "",
                                  'hour': "",
                                  'minute': "",
                                });
                                await widget.collection.document(document.documentID).delete();
                              }else if(direction == DismissDirection.endToStart){
                                await widget.collection.document(document.documentID).delete();
                              }
                            },
                            background: Padding(
                              padding: EdgeInsets.all(0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.all(Radius.circular(0)),
                                  color: Colors.green,
                                ),
                                child: Icon(Icons.check, color: Colors.white),
                              ),
                            ),
                            secondaryBackground: Padding(
                                padding: EdgeInsets.all(0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: new BorderRadius.all(Radius.circular(0)),
                                    color: Colors.red,
                                  ),
                                  child: Icon(Icons.cancel, color: Colors.white),
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
                )
              );
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
          onPressed: () => Navigator.pushNamed(context, '/create'),
          child: Icon(Icons.add)
      ),

  );
}