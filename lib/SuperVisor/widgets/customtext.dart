import 'package:flutter/material.dart';

class Customtext extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color colors;
  final FontWeight fontWeight;

  Customtext({this.text, this.fontSize, this.colors, this.fontWeight});
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: fontSize ?? 16,
            color: colors ?? kSecondaryColor,
            fontWeight: fontWeight ?? FontWeight.normal));
  }
}

const kSecondaryColor = Color(0xFF95A5A6);
