import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextView extends StatelessWidget {
   CustomTextView({
    Key? key,
    // required String text,
    // Color? color,
    // TextStyle? textStyle,
    // int? maxLines, 
    required this.text, 
    this.color, 
    this.textStyle, 
    this.maxLines,
  })  : super(key: key);
  final String text;
  final Color? color;
  final TextStyle? textStyle;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      maxLines: maxLines,
    );
  }
}
