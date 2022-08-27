import 'package:flutter/material.dart';

class WeekListTile extends StatelessWidget {
  const WeekListTile(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.isActive,
      this.index,
      this.isTitle = false})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final bool isActive;
  final bool isTitle;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: isActive
            ? BoxDecoration(border: Border.all(color: Colors.black, width: 3))
            : null,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15,
              fontWeight: isTitle || isActive ? FontWeight.bold : null),
        ),
      ),
    );
  }
}
