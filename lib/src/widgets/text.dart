import 'package:flutter/material.dart';

class ClTitle extends StatelessWidget {
  final String title;

  const ClTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class ClSubTitle extends StatelessWidget {
  final String subTitle;
  final double fontSize;
  final Color color;

  const ClSubTitle(
    this.subTitle, {
    this.fontSize = 20,
    this.color = Colors.grey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      subTitle,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }
}
