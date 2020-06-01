import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  final String college;
  final Function(String) selected;

  const DropDown({Key key, this.college, this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: college,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      iconDisabledColor: Colors.black,
      iconEnabledColor: Colors.black,
      elevation: 16,
      style: TextStyle(color: Colors.black, fontSize: 16),
      underline: Container(
        height: 0,
      ),
      onChanged: (String newValue) {
        selected(newValue);
      },
      items: <String>[
        'Mount Holyoke College',
        'Brandeis University',
        'Umass Amherst',
        'Boston University'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
