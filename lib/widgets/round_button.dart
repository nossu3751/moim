import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final Function press;
  final Color fontColor;

  // by Default, font size is 14 but can be adjusted
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.fontColor,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue[100],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 15),
              blurRadius: 30,
              color: Colors.grey.withOpacity(0.1),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    color: fontColor),
              )
              // if we want to add an icon next to the text
              // Icon(Icons.navigate_next)
            ],
          ),
        ),
      ),
    );
  }
}
