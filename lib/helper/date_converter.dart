import 'package:intl/intl.dart';

class DateConverter {
  static String dateToTime(DateTime? dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime!);
  }

  static String dateToDateAndTime(DateTime? dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime!);
  }

  static String dateToDateAndTime1(DateTime? dateTime) {
    return DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime!);
  }

  static String dateToDateOnly(DateTime? dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime!);
  }

  static String dateToDate(DateTime? dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime!);
  }

  static String dateToDateWithDot(DateTime? dateTime) {
    return DateFormat('dd.MM.yyyy').format(dateTime!);
  }
  static String isoStringToLocalString(String dateTime) {
    String date = dateTime + " 00:00:00";
    DateFormat format = DateFormat("dd/MM/yyyy hh:mm:ss");
    return DateFormat('dd-MM-yyyy').format(format.parse(date)).toString();
  }

  static String dateTimeStringToDateOnly(String dateTime) {
    return DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }

  static String dateTimeDashToDateOnly(String dateTime) {
    return DateFormat('dd-MM-yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }
}
