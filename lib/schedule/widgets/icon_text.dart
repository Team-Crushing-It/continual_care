import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  const IconText({
    required this.icon,
    required this.text,
  }) : super();

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Text(text),
      ],
    );
  }
}
