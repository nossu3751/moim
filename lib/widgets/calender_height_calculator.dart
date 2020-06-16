import 'package:flutter/material.dart';

double boxHeight (String time1, String time2){

  // dt formatted as DateTime String.
  double diff = 0;

  DateTime dt1 = DateTime.parse(time1);
  DateTime dt2 = DateTime.parse(time2);

  Duration dur = dt2.difference(dt1);
  diff = dur.inMinutes + 0.0;
  diff = diff.isNegative?diff * -1:diff;

  return diff/1440;
}

class CalendarBoxInfo {
  double _height;
  double _dayPosition;
  double _timePosition;

  CalendarBoxInfo(double height, double dayPosition, double timePosition){
    this._height = height;
    this._dayPosition = dayPosition;
    this._timePosition = timePosition;
  }

  double getHeight() {
    return this._height;
  }

  double getDayPosition(){
    return this._dayPosition;
  }

  double getTimePosition(){
    return this._timePosition;
  }

}

class DateContainer extends StatelessWidget{
  final double height;
  DateContainer({Color color, @required this.height});

  @override
  Widget build(BuildContext context){
    return Container(
      height: this.height,
    );
  }
}