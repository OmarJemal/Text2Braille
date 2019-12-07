//import 'package:cbco_prototype/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:real_braille/Pages/AppHomeScreen.dart';

import 'package:real_braille/Pages/MessagesPage.dart';
import 'package:real_braille/Pages/SettingsPage.dart';
import 'package:real_braille/Pages/TestingApisPage.dart';

import 'package:real_braille/Util/PreferencesHandler.dart';

//import 'settings_page.dart';

import 'package:real_braille/Pages/SubmitPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /* int _currentIndex = 0;

  SharedPref preferences;

  List<Widget> _children;
  List<BottomNavigationBarItem> _navItems = []; */

  @override
  void initState() {
    super.initState();

    /*  print("INIT START");
    SharedPref initializer = SharedPref();

    initializer.init().then((val) {
      print("INIT START2");

      preferences = val;

      getTabs().then((val) {
        _children = val;
      });

      getNavItems().then((val) {
        _navItems = val;
      });

      print("INIT START3");
    });

    setState(() {}); */
  }

  Widget build(BuildContext context) {
    var data = "View Messages";
    return Scaffold(
      appBar: AppBar(
        title: Text("Text to Braille"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 200,
          ),
          Container(
            margin: EdgeInsets.all(30),
            height: 75.0,
            width: 350.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              border: Border.all(color: Colors.black54),
            ),
            child: InkResponse(
              onTap: () => goToTextsPage(1),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Text("Submit Texts"),
                      Icon(Icons.remove_red_eye)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(30),
            height: 75.0,
            width: 350.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              border: Border.all(color: Colors.black54),
            ),
            child: InkResponse(
              onTap: () => goToTextsPage(0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Text("View Texts"),
                      Icon(Icons.view_list)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    /* return FutureBuilder(
      future: preferences == null
          ? Future.delayed(Duration(milliseconds:1000), () => false)
          : preferences.getIsTestingMode(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          print("REBUILD FUTURE");
          return Scaffold(
            appBar: AppBar(
              title: Text("Text to Braille"),
              //leading: Icon(Icons.settings),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    settings().then((val) {
                      if (val) {
                        setState(() {
                          getTabs().then((val) {
                            _children = val;
                          });

                          getNavItems().then((val) {
                            _navItems = val;
                          });
                        });
                      } else {}
                    });
                  },
                )
              ],
            ),
            body: _children[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: onTabTapped,
              selectedItemColor: Colors.black,
              items: _navItems,
            ),
          );
        } else if (snapshot.hasError) {
          /*
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Card(
                              child: Text(snapshot.error.toString()),
                            );
                          }); 
          */
          print(snapshot.error.toString());
          return Center(
            child: Text("error, please refresh"),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    ); */
  }

  /* void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
 */

/* 
  Future<List<Widget>> getTabs() async {
    bool isTestingMode = await preferences.getIsTestingMode();

    if (isTestingMode) {
      return [
        SubmitPage(title: "Text to Braille"),
        MessagesPage(),
        TestAPIPage(),
      ];
    } else {
      return [
        SubmitPage(title: "Text to Braille"),
        MessagesPage(),
      ];
    }
  }
 */

/* 
  Future<List<BottomNavigationBarItem>> getNavItems() async {
    bool isTestingMode = await preferences.getIsTestingMode();

    if (isTestingMode) {
      return [
        BottomNavigationBarItem(
          title: Text("Create new Message"),
          icon: Icon(Icons.save),
        ),
        BottomNavigationBarItem(
          title: Text("View Messages"),
          icon: Icon(
            Icons.subject,
          ),
        ),
        BottomNavigationBarItem(
          title: Text("Test Page"),
          icon: Icon(
            Icons.developer_mode,
          ),
        ),
      ];
    } else {
      return [
        BottomNavigationBarItem(
          title: Text("Create new Message"),
          icon: Icon(Icons.save),
        ),
        BottomNavigationBarItem(
          title: Text("View Messages"),
          icon: Icon(
            Icons.subject,
          ),
        ),
      ];
    }
  }
 */

/* 
  Future<bool> settings() async {
    bool shouldReload = await Navigator.push(
      context,
      MaterialPageRoute<bool>(builder: (context) => SettingsPage()),
    );

    if (shouldReload == null) {
      shouldReload = true;
    }
    print("IN SETTINGS METHOD");
    print(shouldReload);
    print("-----------");
    return shouldReload;
  }
 */
  /*
  Future<bool> defaultFuture() async {
    bool shouldReload = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );

    Future.delayed(Duration(milliseconds: 500),)

    return shouldReload;
  }
  */

  void goToTextsPage(int firstPage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppHomePage(
          initialPage: firstPage,
        ),
      ),
    );
  }
}
