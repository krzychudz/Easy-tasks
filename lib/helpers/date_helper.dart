String getCurrentDate() {
  var date = DateTime.now().toString();
  var dateParse = DateTime.parse(date);
  var formattedDate =
      "${dateParse.day}.${dateParse.month}.${dateParse.year} - ${convertNumberToWeekdayName(dateParse.weekday)}";
  return formattedDate;
}

String convertNumberToWeekdayName(int number) {
  switch (number) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wedensday';
    case 4:
      return 'Thrusday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    case 7:
      return 'Sunday';
  }
}
