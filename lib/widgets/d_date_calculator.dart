String dDay (String time){
  DateTime dueTime = DateTime.parse(time);
  DateTime rightNow = DateTime.now();
  String difference = dueTime.difference(rightNow).inDays.toString();
  return difference;
}
