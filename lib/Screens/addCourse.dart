import 'package:flutter/material.dart';
import 'package:moimapp/Widgets/highlight_text.dart';
import 'package:moimapp/Widgets/icon_button.dart';
import 'package:moimapp/Widgets/round_button.dart';
import 'package:moimapp/Widgets/Schedule/src/timetable.dart';
import 'package:moimapp/Screens/searchCourse.dart';

class AddCourse extends StatelessWidget {
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
            text: 'Add Course',
            fontStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        actions: <Widget>[
          // action button
          Container(
            width: size.width * 0.22,
            padding: EdgeInsets.all(8),
            child: RoundedButton(
              text: 'Confirm',
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
                Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                  ),
                  SizedBox(
                      height: size.height * 0.4,
                      child: ListView(
                        children: [WeeklyTimeTable()],
                      )),
                  Container(
                    height: size.height * 0.09,
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        labelText: "Course Title",
                        hintText: "Type Course Title Here",
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.09,
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(0),
                    child: TextField(
                      enabled: false,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        labelText:
                            "Days                                                                   Time",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.3,
                  )
                ]),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchCourse()),
          );
        },
        child: Icon(Icons.search),
        backgroundColor: Color(0xFFADD8E5),
      ),
    );
  }
}
