import 'package:flutter/material.dart';

class RoundedInput extends StatelessWidget {
  final String hintText;
  final IconData icon;

  const RoundedInput({
    Key key,
    @required this.size,
    this.hintText,
    this.icon,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Colors.grey[100]),
      width: size.width * 0.8,
      child: TextField(
        decoration: InputDecoration(
            hintText: hintText,
            icon: Icon(
              icon,
              color: Colors.grey[900],
            ),
            border: InputBorder.none),
      ),
    );
  }
}
