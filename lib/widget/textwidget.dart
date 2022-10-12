import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double textSize;
  final FontWeight textweight;
  final Color textcolor;
  final TextAlign textAlign;

  const TextWidget({
    Key? key, 
    required this.text, 
    required this.textSize, 
    required this.textweight, 
    required this.textcolor, 
    required this.textAlign,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
      fontSize: textSize,
      fontWeight: textweight,
      color: textcolor,    
    ),
    textAlign: textAlign,
    );
  }
}