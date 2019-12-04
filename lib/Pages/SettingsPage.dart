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
  SharedPref preferences;

  final portController = TextEditingController();

  final ipController1 = TextEditingController();
  final ipController2 = TextEditingController();
  final ipController3 = TextEditingController();
  final ipController4 = TextEditingController();

  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  final focusNode3 = FocusNode();

  bool isCurrentlyTestmode = false;
  bool shouldreload = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPref initializer = SharedPref();

    initializer.init().then(
      (val) {
        preferences = val;

        checkTestingMode().then(
          (val) {
            isCurrentlyTestmode = val;
          },
        );

        setState(() {
          print("IN SETSTATE");
        });
      },
    );
  }

  @override
  void dispose() {
    portController.dispose();

    ipController1.dispose();
    ipController2.dispose();
    ipController3.dispose();
    ipController4.dispose();

    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();

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
          onPressed: () => Navigator.pop(context, shouldreload),
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
                                    autofocus: true,
                                    maxLines: 1,
                                    controller: ipController1,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            9.0, 9.0, 8.0, 3.0),
                                        border: InputBorder.none,
                                        hintText: "123"),
                                    onSubmitted: (val) {
                                      FocusScope.of(context)
                                          .requestFocus(focusNode1);
                                    },
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(3.0),
                                    ),
                                    border: Border.all(color: Colors.black54),
                                  ),
                                ),
                                Text(
                                  ".",
                                  style: TextStyle(fontSize: 30.0),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  height: 40.0,
                                  width: 50.0,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    focusNode: focusNode1,
                                    maxLines: 1,
                                    controller: ipController2,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            9.0, 9.0, 8.0, 3.0),
                                        border: InputBorder.none,
                                        hintText: "123"),
                                    onSubmitted: (val) {
                                      FocusScope.of(context)
                                          .requestFocus(focusNode2);
                                    },
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(3.0),
                                    ),
                                    border: Border.all(color: Colors.black54),
                                  ),
                                ),
                                Text(
                                  ".",
                                  style: TextStyle(fontSize: 30.0),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  height: 40.0,
                                  width: 50.0,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    focusNode: focusNode2,
                                    maxLines: 1,
                                    controller: ipController3,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            9.0, 9.0, 8.0, 3.0),
                                        border: InputBorder.none,
                                        hintText: "123"),
                                    onSubmitted: (val) {
                                      FocusScope.of(context)
                                          .requestFocus(focusNode3);
                                    },
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(3.0),
                                    ),
                                    border: Border.all(color: Colors.black54),
                                  ),
                                ),
                                Text(
                                  ".",
                                  style: TextStyle(fontSize: 30.0),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  height: 40.0,
                                  width: 50.0,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    focusNode: focusNode3,
                                    maxLines: 1,
                                    controller: ipController4,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            9.0, 9.0, 8.0, 3.0),
                                        border: InputBorder.none,
                                        hintText: "123"),
                                        onSubmitted: (val){
                                          Navigator.pop(context);
                                        },
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
                                      .setIpAddress(ipAddress)
                                      .then((result) {
                                    if (result == "Changed ip Address") {
                                      Toast.show(
                                        "Changed ip Address",
                                        context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.TOP,
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

                                setState(() {});
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
                  future: preferences == null
                      ? Future.delayed(Duration(milliseconds: 50), () {
                          print("IN F BUILDER 1");

                          return "123.123.123.456";
                        })
                      : preferences.getIpAddress(),
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
                            Text("Set Port Number"),
                            SizedBox(
                              height: 30.0,
                            ),
                            //TODO: Restrict users to only 3 digits per ip section
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    height: 35.0,
                                    width: 70.0,
                                    child: TextField(
                                      style: TextStyle(fontSize: 20.0),
                                      keyboardType:
                                          TextInputType.numberWithOptions(),
                                      autofocus: false,
                                      maxLines: 1,
                                      controller: portController,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              11.0, 3.0, 8.0, 3.0),
                                          border: InputBorder.none,
                                          hintText: "8080"),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(3.0),
                                      ),
                                      border: Border.all(color: Colors.black54),
                                    ),
                                  ),
                                ]),
                            SizedBox(
                              height: 40.0,
                            ),
                            RaisedButton(
                              onPressed: () {
                                String portNumber = portController.text;

                                if (portNumber
                                    .contains(RegExp(r'^(\d?\d?\d?\d?)$'))) {
                                  print("in here pt 3");
                                  preferences
                                      .setPortNumber(portNumber)
                                      .then((result) {
                                    if (result == "Changed port Number") {
                                      Toast.show(
                                        "Changed port Number",
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
                                  print('in here pt 4');
                                  Toast.show(
                                    "Something went wrong :(",
                                    context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM,
                                  );
                                }

                                setState(() {});
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
                  future: preferences == null
                      ? Future.delayed(Duration(milliseconds: 50), () {
                          print("IN F BUILDER 2");
                          return "8080";
                        })
                      : preferences.getPortNumber(),
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
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
            height: 60.0,
            child: FutureBuilder(
              future: preferences == null
                  ? Future.delayed(Duration(milliseconds: 50), () => false)
                  : preferences.getIsTestingMode(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  return Row(
                    children: <Widget>[
                      Text(
                        "Testing Mode",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Switch(
                        value: isCurrentlyTestmode,
                        onChanged: (val) {
                          preferences.setIsTestingMode(val);

                          setState(() {
                            isCurrentlyTestmode = val;
                            shouldreload = true;
                          });

                          print("Here is the val1:" + val.toString());
                        },
                      ),
                    ],
                  );
                  // return Text("Port Number: " + snapshot.data);

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
          Divider(),
        ],
      ),
    );
  }

  Future<bool> checkTestingMode() async {
    bool isTestingMode = await preferences.getIsTestingMode();
    return isTestingMode;
  }
}
