import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final Function press;
  final Icon icon;

  const RoundIconButton({
    Key key,
    this.press,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue[100],
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 15),
              blurRadius: 30,
              color: Colors.grey.withOpacity(0.1),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: icon,
          // child: Row(
          //   mainAxisSize: MainAxisSize.min,
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: <Widget>[
          //     Icon(Icons.navigate_next)
          //   ],
          // ),
        ),
      ),
    );
  }
}
