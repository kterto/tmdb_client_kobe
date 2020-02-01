import 'package:flutter/material.dart';

class ReleaseDate extends StatelessWidget {
  final int day;
  final int month;
  final int year;
  final Color textColor;
  final double fontSize;

  ReleaseDate({
    this.day,
    this.month,
    this.year,
    this.textColor = Colors.white,
    this.fontSize = 12,
  });

  String numberToString(int number) {
    if (number < 10) {
      return '0$number';
    } else {
      return number.toString();
    }
  }

  Widget build(context) {
    return Text(
      "Release Date: ${numberToString(day)}/${numberToString(month)}/$year",
      style: TextStyle(
        fontFamily: "OpenSans",
        fontSize: fontSize,
        color: textColor,
      ),
    );
  }
}
