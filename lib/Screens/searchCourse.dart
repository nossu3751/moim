import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moimapp/Widgets/highlight_text.dart';
import 'package:moimapp/Widgets/round_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moimapp/Screens/searchResult.dart';
import 'package:moimapp/widgets/Schedule/src/schedule_db.dart';

class SearchCourse extends StatefulWidget {
  final collection = Firestore.instance.collection('testcourse');
  @override
  SearchCourseState createState() => SearchCourseState();
}

class SearchCourseState extends State<SearchCourse> {
  List<String> reportList = ["MON", "TUE", "WED", "THU", "FRI"];
  List<String> selectedReportList = List();
  String startTime = "None";
  String endTime = "None";

  clearSearch() {
    Schedule_db.Csubject = "";
    Schedule_db.Ctitle = "";
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
            text: 'Search Course',
            fontStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        actions: <Widget>[
          // action button
          Container(
            width: size.width * 0.22,
            padding: EdgeInsets.all(8),
            child: RoundedButton(
              press:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchResult()),
                );
              },
              text: 'Search',
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
                              onChanged: (value) {Schedule_db.Csubject = value;},
                              decoration: InputDecoration(
                                hasFloatingPlaceholder: false,
                                hintText: "Search by Subject",
                                contentPadding: EdgeInsets.all(12),
                                labelText: "Search by Subject",
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
                              onChanged: (value) {Schedule_db.Ctitle = value;},
                              decoration: InputDecoration(
                                hasFloatingPlaceholder: false,
                                hintText: "Search by Course Title",
                                contentPadding: EdgeInsets.all(12),
                                labelText: "Search by Course Title",
                              ),
                            ),
                          ),
                        ])),
                        Padding(
                          padding: EdgeInsets.all(0),
                          child: TextField(
                            textAlign: TextAlign.start,
                            onChanged: (value) {},
                            enabled: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 0),
                              labelText: "Search by Time",
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              MultiSelectChip(
                                reportList,
                                onSelectionChanged: (selectedList) {
                                  setState(() {
                                    selectedReportList = selectedList;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 14),
                                child: DropdownButton<String>(
                                  value: startTime,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      startTime = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'None',
                                    'AM 8',
                                    'AM 9',
                                    'AM 10',
                                    'AM 11'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                )),
                            Container(
                              child: Icon(Icons.remove, color: Colors.grey,),
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 14),
                                child: DropdownButton<String>(
                                  value: endTime,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      endTime = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'None',
                                    'AM 8',
                                    'AM 9',
                                    'AM 10',
                                    'AM 11'
                                  ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.5,
                        )
                      ]),
                ],
              ))),
    );
  }
}

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip(this.reportList, {this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> selectedChoices = List();

  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selectedColor: Color(0xFFADD8E5),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices); // +added
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
