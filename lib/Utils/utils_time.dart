import 'package:intl/intl.dart';

class Utils {
  static String formatTimeOfDay(int milliSecond) {
    final DateTime date = DateTime.now();
    final dt =
        DateTime(date.year, date.month, date.day, date.hour, date.minute);
    final format = DateFormat.MMMMEEEEd(); //"6:00 AM"
    return format.format(dt);
  }

  static String hourAndMin(int milliSecond) {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(milliSecond);
    final dt =
        DateTime(date.year, date.month, date.day, date.hour, date.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  static String timeAgoSinceDate(int milliSecond) {
    //week 1646110200000 Tue Mar 01 2022 04:50:00
    //days 1646455800000 Sat Mar 05 2022 04:50:00
    //year 1614919800000 Fri Mar 05 2021 04:50:00
    //month 1644382200000  9-2-2022
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(milliSecond);
    final date2 = DateTime.now();
    final difference = date2.difference(date);
    final duration = Duration(
        days: date.day,
        hours: date.hour,
        minutes: date.minute,
        seconds: date.second);
    final hours = date2.subtract(duration).hour;
    final minutes = date2.subtract(duration).minute;

    if ((difference.inDays / 365).floor() >= 1) {
      return '${(difference.inDays / 365).floor()}Y ${hours}H ${minutes}m';
    } else if ((difference.inDays /
                daysInMonth(monthNum: date.month, year: date.year))
            .floor() >=
        1) {
      return '${(difference.inDays / daysInMonth(monthNum: date.month, year: date.year)).floor()}M ${hours}H ${minutes}m';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return '${(difference.inDays / 7).floor()}W ${hours}H ${minutes}m';
    } else if ((difference.inDays).floor() >= 1) {
      return '${(difference.inDays).floor()}D ${hours}H ${minutes}m';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours}H ${minutes}s';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes}m';
    } else {
      return '${difference.inSeconds}s';
    }
  }

  static int daysInMonth({required int monthNum, required int year}) {
    if (monthNum > 12) {
      return 0;
    }
    final List<int> monthLength = List.filled(12, 0);
    monthLength[0] = 31;
    monthLength[2] = 31;
    monthLength[4] = 31;
    monthLength[6] = 31;
    monthLength[7] = 31;
    monthLength[9] = 31;
    monthLength[11] = 31;
    monthLength[3] = 30;
    monthLength[8] = 30;
    monthLength[5] = 30;
    monthLength[10] = 30;

    if (leapYear(year) == true) {
      monthLength[1] = 29;
    } else {
      monthLength[1] = 28;
    }

    return monthLength[monthNum - 1];
  }

  static bool leapYear(int year) {
    bool leapYear = false;
    final bool leap = (year % 100 == 0) && (year % 400 != 0);
    if (leap == true) {
      leapYear = false;
    } else if (year % 4 == 0) {
      leapYear = true;
    }

    return leapYear;
  }
}
