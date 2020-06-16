import 'package:flutter/material.dart';

class DropDownGeneral extends StatelessWidget {
  final String selected;
  final Function(String) select;
  final List<String> items;

  const DropDownGeneral({Key key, this.selected, this.select, this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selected,
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
        select(newValue);
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
