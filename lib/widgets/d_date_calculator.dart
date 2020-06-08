String dDay (String time){
  DateTime dueTime = DateTime.parse(time);
  DateTime rightNow = DateTime.now();
  Duration difference = dueTime.difference(rightNow);
  int dDateDay = dueTime.weekday;
  int todayDay = rightNow.weekday;
  if(difference.isNegative){
    return "overdue";
  }
  int differenceRTN = dueTime.difference(rightNow).inDays;
  if(differenceRTN == 0){
    if(dDateDay == todayDay){
      return "today";
    }
    return "tomorrow";
  }else if(differenceRTN == 1){
    if(dDateDay - (todayDay % 7) == 1){
      return "tomorrow";
    }
    return "D - 2";
  }
  if(((dDateDay + 7) - todayDay) % 7 == differenceRTN % 7 + 1){
    return "D - " + (differenceRTN + 1).toString();
  }
  return "D - " + differenceRTN.toString();
}
