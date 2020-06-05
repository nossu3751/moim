String dDay (String time){
  DateTime dueTime = DateTime.parse(time);
  DateTime rightNow = DateTime.now();
  Duration difference = dueTime.difference(rightNow);
  if(difference.isNegative){
    return "overdue";
  }
  int differenceRTN = dueTime.difference(rightNow).inDays;
  if(differenceRTN == 0){
    return "today";
  }else if(differenceRTN == 1){
    return "tomorrow";
  }
  return "D - " + differenceRTN.toString();
}
