import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    final fString = '${startDate.day} - ${endDate.day}';

    if (isMonth) {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          height: 33,
          width: 90,
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
          child: Text(
            DateFormat('MMM').format(endDate),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        InkWell(
          onTap: onPressed,
          child: Container(
            height: 33,
            width: 90,
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
            decoration: isSelected
                ? BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3))
                : null,
            child: Text(
              fString,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.bold : null),
            ),
          ),
        ),
      ]);
    }

    return Center(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 33,
          width: 90,
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
          decoration: isSelected
              ? BoxDecoration(border: Border.all(color: Colors.black, width: 3))
              : null,
          child: Center(
            child: Text(
              fString,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.bold : null),
            ),
          ),
        ),
      ),
    );
  }
}
