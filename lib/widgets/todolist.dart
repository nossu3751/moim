import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
            case ConnectionState.waiting: return Text('Loading...');
            default:
              return ListView(
                children: snapshot.data.documents.map((DocumentSnapshot document){
                  if(snapshot.data == null) {
                    return Text('No data to show');
                  }else{
                    return Dismissible(
                        child: Container(
                          height: 100,
                          child: Card(
                              child: Center(
                                child: ListTile(
                                  title: Text(document['name']),
                                  trailing: Text(
                                    document['due_time'] != null && document['due_time'] != ""?
                                        document['due_time']:"not specified"
                                  )
                                )
                              )
                          )
                        ),
                        key: Key(document.documentID.toString()),
                        onDismissed: (direction) async {
                          if(direction == DismissDirection.startToEnd){
                            await widget.completedCollection.add({'name': document['name']});
                            await widget.collection.document(document.documentID).delete();
                          }else if(direction == DismissDirection.endToStart){
                            await widget.collection.document(document.documentID).delete();
                          }
                        },
                        background: Padding(
                          padding: EdgeInsets.all(5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: new BorderRadius.all(Radius.circular(20)),
                              color: Colors.green,
                            ),
                            child: Icon(Icons.check, color: Colors.white),
                          ),
                        ),
                        secondaryBackground: Padding(
                          padding: EdgeInsets.all(5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: new BorderRadius.all(Radius.circular(20)),
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
              );
          }
        }
      ),
//      body: ListView.builder(
//        itemCount: widget.tasks.length,
//        itemBuilder: (context, index) {
//          return Dismissible(
//            child: Card(
//                child: ListTile(
//                    title: Text(widget.tasks[index].getName())
//                )
//            ),
//            key: Key(widget.tasks[index].getName()),
//            direction: DismissDirection.startToEnd,
//            onDismissed: (direction){
//              setState(() {
//                widget.tasks.removeAt(index);
//              });
//            },
//          );
//        },
////      itemBuilder: (context, index) => ListTile(
////        title: Text(tasks[index].getName())
////      )
//      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/create'),
          child: Icon(Icons.add)
      ),

  );
}