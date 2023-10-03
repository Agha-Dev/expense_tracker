import 'package:expense_tracker/constants/constant_colors.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
AutoSizeText customtext(String s, Color c, double fs, FontWeight fw) {
  return AutoSizeText(
    s,
    maxLines: 5,
    style: TextStyle(
      
      overflow: TextOverflow.ellipsis,
      color: c,
      fontSize: fs,
      fontWeight: fw,
      
    ),
  );
}

SizedBox verticalSpaceresponsive(double n, context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * n,
  );
}

SizedBox horizontalSpaceresponsive(double n, context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * n,
  );
}

void showSnackbarText(String message, context) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: mainColor, content: Text(message)));
}


class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}