//import 'package:cbco_prototype/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:real_braille/Pages/MessagesPage.dart';

//import 'settings_page.dart';

import 'package:real_braille/Pages/SubmitPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    SubmitPage(title: "Text to Braille"),
    MessagesPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text to Braille"),
        //leading: Icon(Icons.settings),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              
            },
          )
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
              title: Text("Create new Message"), icon: Icon(Icons.subject)),
          BottomNavigationBarItem(
            title: Text("View Messages"),
            icon: Icon(
              Icons.save,
            ),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
