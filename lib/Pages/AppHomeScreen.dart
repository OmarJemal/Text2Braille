import 'package:flutter/material.dart';
import 'package:real_braille/Pages/TestingApisPage.dart';
import 'package:real_braille/Util/PreferencesHandler.dart';

import 'MessagesPage.dart';
import 'SettingsPage.dart';
import 'SubmitPage.dart';

class AppHomePage extends StatefulWidget {
  final int initialPage;

  AppHomePage({Key key, this.initialPage}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppHomePageState();
  }
}

class _AppHomePageState extends State<AppHomePage> {
  PageController pageController;

  SharedPref preferences;

  List<Widget> _children;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.initialPage);

    SharedPref initializer = SharedPref();

    initializer.init().then((val) {
      print("INIT START2");

      preferences = val;

      getChildren().then((val) {
        _children = val;
      });

      print("INIT START3");
    });

    setState(() {});
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Messages!"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              settings().then(
                (val) {
                  if (val) {
                    setState(
                      () {
                        getChildren().then(
                          (val) {
                            _children = val;
                          },
                        );
                      },
                    );
                  }
                },
              );
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: preferences == null
            ? Future.delayed(Duration(milliseconds: 1000), () {
                defaultWidget();
                setState(() {});
              })
            : getChildren(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {

            print(snapshot.data);
            return PageView(
              controller: pageController,
              children: snapshot.data,
            );
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
            setState(() {});
            return Center(
              child: Text("error, please refresh"),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  List<Widget> defaultWidget() {
    return [CircularProgressIndicator()];
  }

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

  Future<List<Widget>> getChildren() async {
    bool isTestingMode = await preferences.getIsTestingMode();

    if (isTestingMode) {
      return [
        MessagesPage(
          pageController: pageController,
        ),
        SubmitPage(),
        TestAPIPage(),
      ];
    } else {
      return [
        MessagesPage(
          pageController: pageController,
        ),
        SubmitPage(),
      ];
    }
  }
}
