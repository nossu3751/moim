import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget{
  final String title;
  final String subtitle;


  const CustomCard({Key key, this.title, this.subtitle}) :super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(

      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(20)
      ),
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: EdgeInsets.all(0),
        child: ListTile(
          title: Text(this.title),
          subtitle: Text(this.subtitle),
          trailing: Icon(Icons.edit),
        )
      )
    );
  }
}