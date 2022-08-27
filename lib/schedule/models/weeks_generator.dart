import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class WeeksGenerator {
  final DateTime startTime;
  final DateTime endTime;

  WeeksGenerator({
    required this.startTime,
    required this.endTime,
  });

  List<dynamic> generate() {
    int difference = Jiffy([startTime.year, startTime.month, startTime.day])
        .diff(Jiffy([endTime.year, endTime.month, endTime.day]), Units.DAY)
        .toInt();
    DateTime start = startTime;
    List<dynamic> weeksList = [];
    for (var i = 0; i < difference.abs(); i = i + 7) {
      List<DateTime> daysList = [];
      daysList.add(start);
      DateTime FirstDay = start;
      start = start.add(Duration(days: 6));
      daysList.add(start);
      start = start.add(Duration(days: 1));
      DateTime LastDay = start;
      weeksList.add(daysList);
      if (FirstDay.month != LastDay.month) {
        weeksList.add(DateFormat('MMM').format(LastDay));
      }
    }
    return weeksList.toList();
  }
}

void main(List<String> args) {
  WeeksGenerator(
          startTime: (DateTime.now().subtract(Duration(days: 365))),
          endTime: DateTime.now().add(Duration(days: 365)))
      .generate();
}
