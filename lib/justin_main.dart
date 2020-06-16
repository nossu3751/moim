import 'dart:ui';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moimapp/calculator.dart';
import 'package:moimapp/course.dart';
import 'package:moimapp/services/database.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Flutter Demo",
        home: MyHomePage(title: "HELLO WORLD"));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white12,
          title: Image.asset('assets/MoimWord1.png', width: 100),
          leading: IconButton(
            icon: Icon(Icons.notifications),
            iconSize: 40.0,
            tooltip: "Notifications",
            onPressed: () {
              print("Notifications");
            },
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.person),
                iconSize: 40.0,
                tooltip: "Check Profile",
                onPressed: () {
                  print("Profile");
                })
          ]),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SearchBar(
                hintText: 'Search',
                searchBarStyle: SearchBarStyle(backgroundColor: Colors.white70),
              ),
            ),
          ),
          SizedBox(
              height: 150,
              child: PageView(
                  controller: PageController(viewportFraction: 1.0),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFEFB868)),
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red),
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green),
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                    ),
                  ])),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            width: 10000,
            height: 100,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('  I AM GROOT',
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                  Text('    ARE YOU GROOT?',
                      style: TextStyle(fontSize: 15, color: Colors.white))
                ]),
            decoration: BoxDecoration(color: Color(0xFF383F51)),
          ),
          new Expanded(
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Container(
                        width: 10,
                      ),
                      title: Text(
                        'Will MOIM be the next big thing?',
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        'Flutter is too difficult smh',
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.thumb_up,
                          color: Colors.grey,
                        ),
                        onPressed: () {},
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 10,
                      color: Colors.white10,
                    );
                  }))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white12,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFFEFB868),
          unselectedItemColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          iconSize: 40.0,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.dashboard),
              title: Text("Communities"),
            ),
            BottomNavigationBarItem(
                icon: new Icon(Icons.calendar_today), title: Text("Calendar")),
            BottomNavigationBarItem(
              icon: new IconButton(
                icon: new Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Calculator()),
                  );
                },
              ),
              title: Text("Calculator"),
            ),
          ]),
    );
  }
}
