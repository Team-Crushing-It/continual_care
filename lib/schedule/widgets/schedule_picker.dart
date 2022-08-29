import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SchedulePicker extends StatefulWidget {
  const SchedulePicker({
    Key? key,
  }) : super(key: key);

  @override
  State<SchedulePicker> createState() => _SchedulePickerState();
}

class _SchedulePickerState extends State<SchedulePicker> {
  late ScrollController _controller;
  late DateTime nCurrent;
  final isSelected = false;
  var monthOffset = 0;

  @override
  void initState() {
    final timeNow = DateTime.now();
    nCurrent = timeNow.subtract(new Duration(days: timeNow.weekday - 1));

    _controller = ScrollController(initialScrollOffset: 1056);

//  WidgetsBinding.instance
//         .addPostFrameCallback((_) => animateToTile(1000));
    super.initState();
  }

  animateToTile(double pozish) {
    print('onScrolld $pozish');
    _controller.animateTo(pozish,
        duration: Duration(seconds: 1), curve: Curves.ease);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Color(0xffF6E7E7),
      child: ListView.builder(
        controller: _controller,
        // itemExtent: 33,
        itemCount: 62,
        itemBuilder: ((context, index) {
          /// Start from 1/2 year in the past, and
          /// move every week from there
          final startDate = nCurrent
              .subtract(Duration(days: 26 * 7))
              .add(Duration(days: index * 7));

          final endDate = startDate.add(Duration(days: 7));
          var isMonth = false;

          /// if end date is at the beginning of a month,
          /// (less than seven days into it)
          /// then display the month in a tile

          if (endDate.day < 8) {
            isMonth = true;
          }

          /// Else just return a normal List Tile
          return WeekListTile(
            isMonth: isMonth,
            startDate: startDate,
            endDate: endDate,
            isSelected: false,
            onPressed: () {},
          );
        }),
      ),
    );
  }
}

class WeekListTile extends StatelessWidget {
  const WeekListTile(
      {Key? key,
      required this.isMonth,
      required this.startDate,
      required this.endDate,
      required this.isSelected,
      required this.onPressed})
      : super(key: key);

  final bool isMonth;
  final DateTime startDate;
  final DateTime endDate;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final output = '${startDate.day} - ${endDate.day}';
    if (isMonth) {
      return Column(children: [
        Container(
          height: 33,
          child: Text(DateFormat('MMM').format(endDate)),
        ),
        Container(
          height: 33,
          child: Text(output),
        ),
      ]);
    }

    return Center(
      child: Container(
        height: 33,
        child: Text(output),
      ),
    );
  }
}
