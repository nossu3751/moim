import 'package:flutter/material.dart';

// highlight text, but only up to one line
// only use for short phrases
class HighlightText extends StatelessWidget {
  final String text;
  final TextStyle fontStyle;

  const HighlightText({
    Key key,
    this.text,
    this.fontStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = _textSize(text, fontStyle);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          color: Colors.yellow[300],
          width: size.width,
          height: size.height / 2.5,
        ),
        Text(
          text,
          style: fontStyle,
        ),
      ],
    );
  }

  // Stackoverflow: https://stackoverflow.com/questions/52659759/how-can-i-get-the-size-of-the-text-widget-in-flutter
  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
