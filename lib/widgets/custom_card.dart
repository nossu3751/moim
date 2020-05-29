import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget{
  final String title;
  final String subtitle;
  final String imageURL;

  const CustomCard({Key key, this.title, this.subtitle, this.imageURL}) :assert(imageURL != null), super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      elevation: 0,
      child: ListTile(
        title: Text(this.title),
        subtitle: Text(this.subtitle),
        trailing: imagePlace,
      )
    );
  }

  Widget get imagePlace{
    return imageURL.isEmpty ? Container(
      color: Colors.transparent,
      height: 150,
      width: 100,
      child: Placeholder(),
    ) : Image.network(imageURL);
  }
}