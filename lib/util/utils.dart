import 'package:ntp/ntp.dart';

var kCurrentDate = DateTime.now();

Future<DateTime> getDate() async {
  DateTime startDate = await NTP.now();
  kCurrentDate = DateTime(startDate.year, startDate.month, startDate.day,startDate.hour);
  return startDate;
}
