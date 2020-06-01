import 'package:flutter/material.dart';

class RoundedInputWithController extends StatelessWidget {
  final TextFormField textFormField;

  const RoundedInputWithController(
      {Key key, @required this.size, this.textFormField})
      : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: Colors.grey[100]),
        width: size.width * 0.8,
        child: textFormField);
  }
}
