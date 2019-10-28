import 'package:flutter/material.dart';

import 'package:toast/toast.dart';

import 'package:real_braille/Util/PreferencesHandler.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsPageState();
  }
}

class _SettingsPageState extends State<SettingsPage> {
  final SharedPref preferences = SharedPref.instance;

  final portController = TextEditingController();

  final ipController1 = TextEditingController();
  final ipController2 = TextEditingController();
  final ipController3 = TextEditingController();
  final ipController4 = TextEditingController();

  @override
  void dispose() {
    portController.dispose();

    ipController1.dispose();
    ipController2.dispose();
    ipController3.dispose();
    ipController4.dispose();

    super.dispose();
  }

  Future<String> waitForPrefs() async {
    await Future.delayed(
      Duration(seconds: 3),
    ).whenComplete(() {
      return preferences.getIpAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        //`true` if you want Flutter to automatically add Back Button when needed,
        //or `false` if you want to force your own back button every where
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60.0,
            child: FlatButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Card(
                      margin: EdgeInsets.fromLTRB(40.0, 60.0, 40.0, 300),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 30.0,
                            ),
                            Text("Set Ip Address"),
                            SizedBox(
                              height: 30.0,
                            ),
                            //TODO: Restrict users to only 3 digits per ip section
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  height: 40.0,
                                  width: 50.0,
                                  child: TextField(
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    autofocus: false,
                                    maxLines: 1,
                                    controller: ipController1,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "123"),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(3.0),
                                    ),
                                    border: Border.all(color: Colors.black54),
                                  ),
                                ),
                                Text("."),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  height: 40.0,
                                  width: 50.0,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    autofocus: false,
                                    maxLines: 1,
                                    controller: ipController2,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "1,2,3"),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(3.0),
                                    ),
                                    border: Border.all(color: Colors.black54),
                                  ),
                                ),
                                Text("."),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  height: 40.0,
                                  width: 50.0,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    autofocus: false,
                                    maxLines: 1,
                                    controller: ipController3,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "123"),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(3.0),
                                    ),
                                    border: Border.all(color: Colors.black54),
                                  ),
                                ),
                                Text("."),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  height: 40.0,
                                  width: 50.0,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    autofocus: false,
                                    maxLines: 1,
                                    controller: ipController4,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "123"),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(3.0),
                                    ),
                                    border: Border.all(color: Colors.black54),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            RaisedButton(
                              onPressed: () {
                                String ipAddress = ipController1.text +
                                    "." +
                                    ipController2.text +
                                    "." +
                                    ipController3.text +
                                    "." +
                                    ipController4.text;

                                if (ipAddress.contains(RegExp(
                                    r'^(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)$'))) {
                                  print("in here");
                                  preferences
                                      .setIpAddress(ipController1.text +
                                          "." +
                                          ipController2.text +
                                          "." +
                                          ipController3.text +
                                          "." +
                                          ipController4.text)
                                      .then((result) {
                                    if (result == "Changed ip Address") {
                                      Toast.show(
                                        "Changed ip Address",
                                        context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM,
                                      );
                                      Navigator.pop(context, null);
                                    } else {
                                      Toast.show(
                                        "Something went wrong :(",
                                        context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM,
                                      );
                                    }
                                  }).catchError((error) {
                                    print("ERROR" + error + "\n");
                                  });
                                } else {
                                  print('in here pt 2');
                                  Toast.show(
                                    "Something went wrong :(",
                                    context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM,
                                  );
                                }
                              },
                              child: Text("Set"),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: FutureBuilder(
                  future: preferences.getIpAddress(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return Text("Ip Address: " + snapshot.data);
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
                      print(preferences != null);
                      setState(() {});
                      return Text("error");
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
          ),
          Divider(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60.0,
            child: FlatButton(
              onPressed: () {},
              child: Align(
                alignment: Alignment.centerLeft,
                child: FutureBuilder(
                  future: preferences.getPortNumber(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return Text("Port Number: " + snapshot.data);
                    } else if (snapshot.hasError) {
                      /*
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Card(
                              child: Text(snapshot.error.toString()),
                            );
                          }); */
                      print(snapshot.error.toString());
                      return Text("error, please refresh");
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
          ),
          Divider(),
          SizedBox(
            height: 50.0,
          ),
          Center(
            child: RaisedButton(
              color: Colors.greenAccent,
              onPressed: () {
                setState(() {});
              },
              child: Text("Refresh"),
            ),
          )
        ],
      ),
    );
  }
}
