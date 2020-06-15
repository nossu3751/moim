import 'package:flutter/material.dart';
import 'package:moimapp/widgets/Schedule/src/cell.dart';
import 'package:moimapp/widgets/Schedule/src/header.dart';
import 'package:moimapp/widgets/Schedule/src/indicator.dart';
import 'package:moimapp/widgets/Schedule/src/weekly_times.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WeeklyTimeTable extends StatefulWidget {
  final ValueChanged<Map<int, List<int>>> onValueChanged;
  final Color cellColor;
  final Color cellSelectedColor;
  final Color boarderColor;
  final Map<int, List<int>> initialSchedule;
  final bool draggable;
  final String locale;
  final bool scrollable;

  WeeklyTimeTable({
    this.cellColor = Colors.white,
    this.cellSelectedColor = Colors.black,
    this.boarderColor = Colors.black,
    this.initialSchedule = const {
      0: [1,2,3],
      1: [],
      2: [1],
      3: [],
      4: [],
      5: [],
    },
    this.draggable = false,
    this.locale = "en",
    this.onValueChanged,
    this.scrollable = true,
  });

  @override
  _WeeklyTimeTableState createState() => _WeeklyTimeTableState(this.initialSchedule);
}

class _WeeklyTimeTableState extends State<WeeklyTimeTable> {
  String locale = 'en';
  Map<int, List<int>> selected;

  _WeeklyTimeTableState(this.selected);

  @override
  void initState() {
    if (WeeklyTimes.localContains(widget.locale)) {
      setState(() {
        locale = widget.locale;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool scrollPhysics = widget.scrollable;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Header(WeeklyTimes.dates[this.locale],),
        Container(
          child: ListView.builder(
            physics: scrollPhysics? const  NeverScrollableScrollPhysics(): const AlwaysScrollableScrollPhysics(),
            itemCount: WeeklyTimes.times[this.locale].length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              List<Widget> children = [];
              children.add(Indicator(WeeklyTimes.times[this.locale][index]));
              children.addAll(
                List.generate(
                  WeeklyTimes.dates[this.locale].length - 1,
                      (i) =>
                      Cell(
                        day: i,
                        timeRange: index,
                        isSelected: selected[i].contains(index),
                        onCellTapped: onCellTapped,
                        cellColor: widget.cellColor,
                        cellSelectedColor: widget.cellSelectedColor,
                        boarderColor: widget.boarderColor,
                      ),
                ),
              );
              return Row(children: children);
            },
          ),
        ),
      ],
    );
  }

  onCellTapped(int day, int timeRange, bool nextSelectedState) {
    setState(() {
      if (!nextSelectedState) {
        selected[day].add(timeRange);
      } else {
        selected[day].remove(timeRange);
      }
    });
    widget.onValueChanged(selected);
  }
}
