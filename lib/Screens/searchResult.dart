import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moimapp/Widgets/highlight_text.dart';
import 'package:moimapp/Widgets/round_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moimapp/widgets/Schedule/src/course.dart';
import 'package:moimapp/widgets/Schedule/src/schedule_db.dart';

class SearchResult extends StatefulWidget {
  final collection = Firestore.instance.collection('testcourse');

  @override
  SearchResultState createState() => SearchResultState();
}

class SearchResultState extends State<SearchResult> {
  List<Course> courselist = courses;
  Stream courseListStream;
  Schedule_db scheduledb = new Schedule_db();

  clearSearch() {
    Schedule_db.Csubject = "";
    Schedule_db.Ctitle = "";
  }

  Widget ResultList() {
    return StreamBuilder(
      stream: courseListStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return CourseTile(
                    Cname: snapshot.data.documents[index].data['course_name'],
                    major: snapshot.data.documents[index].data['major'],
                    prof: snapshot.data.documents[index].data['professor'],
                    Ccode: snapshot.data.documents[index].data['course_code'],
                  );
                })
            : ListTile();
      },
    );
  }

  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    scheduledb.getCourse().then((value) {
      setState(() {
        courseListStream = value;
      });
    });
  }

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
            clearSearch();
            Navigator.pop(context);
          },
        ),
        title: HighlightText(
            text: 'Search Result',
            fontStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        actions: <Widget>[
          // action button
          Container(
            width: size.width * 0.22,
            padding: EdgeInsets.all(8),
            child: RoundedButton(
              text: 'Add',
              fillColor: Color(0xFFADD8E5),
              fontSize: 11,
            ),
          ),
        ],
      ),
      body: ResultList()
    );
  }
}

//Widget _buildItem(Course course) {
//  return new Padding(
//    padding: const EdgeInsets.all(2),
//    child: new ListTile(
//      title: new Text(course.title, style: new TextStyle(fontSize: 15)),
//      subtitle: new Text(course.days.toString()),
//      leading: new Text(course.subject, style: new TextStyle(fontSize: 20)),
//      trailing: new Text(course.startTime.toString() +
//          "AM  -  " +
//          course.endTime.toString() +
//          "AM"),
//    ),
//  );
//}

class CourseTile extends StatelessWidget {
  final String Cname;
  final String major;
  final String prof;
  final String Ccode;

  const CourseTile({Key key, this.Cname, this.major, this.prof, this.Ccode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: new Text(Cname, style: new TextStyle(fontSize: 15)),
      title: new Text(Ccode),
      leading: new Text(major, style: new TextStyle(fontSize: 20)),
      trailing: new Text(prof),
    );
  }
}
