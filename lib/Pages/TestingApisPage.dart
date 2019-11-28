
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:real_braille/Network_Call_Methods/NetworkCalls.Dart';
import 'package:real_braille/Util/PreferencesHandler.dart';

class TestAPIPage extends StatefulWidget {
  TestAPIPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TestAPIPageState();
  }
}

class _TestAPIPageState extends State<TestAPIPage> {
  final bodyController = TextEditingController();
  final titleController = TextEditingController();
  final textIdController = TextEditingController();
  final categoryIdController = TextEditingController();
  final deleteContentsController = TextEditingController();


  //final SharedPref preferences = SharedPref.instance;
  SharedPref preferences;

  @override
  void initState() {

    SharedPref initializer = SharedPref();

    initializer.init().then((val){
      preferences = val;
    });
    
    
    super.initState();
    //FocusNode myFocusNode = FocusNode();
  }

  /*final snackBar = SnackBar(
    content: Text("Submitted Text"),
  ); */

  @override
  void dispose() {
    // TODO: implement dispose
    bodyController.dispose();
    titleController.dispose();
    textIdController.dispose();
    categoryIdController.dispose();
    deleteContentsController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("Message Text Id"),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    height: 40.0,
                    width: 90.0,
                    child: TextField(
                      controller: textIdController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Message Id"),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      border: Border.all(color: Colors.black54),
                    ),
                  ),
                   SizedBox(
                    height: 30.0,
                  ),
                  Text("Message Category Id"),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    height: 40.0,
                    width: 90.0,
                    child: TextField(
                      controller: categoryIdController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Message Id"),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      border: Border.all(color: Colors.black54),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text("delete Contents? (1 or 0)"),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    height: 40.0,
                    width: 90.0,
                    child: TextField(
                      controller: deleteContentsController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Message Id"),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      border: Border.all(color: Colors.black54),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text("Message Title"),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    height: 40.0,
                    width: 90.0,
                    child: TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Title of Message",
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      border: Border.all(color: Colors.black54),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text("Message Body"),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    height: 40.0,
                    width: 90.0,
                    child: TextField(
                      autofocus: true,
                      controller: bodyController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Message body"),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      border: Border.all(color: Colors.black54),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Builder(
                    builder: (context) => RaisedButton(
                      disabledColor: Colors.blueAccent,
                      color: Colors.lightBlue,
                      child: Text("Submit Text"),
                      onPressed: () {
                        /*
                          final snackBar = SnackBar(
                            content: Text("Submitted Text " + bodyController.text),
                          );
                          FocusScope.of(context).unfocus();
                          Scaffold.of(context).showSnackBar(snackBar);
                          */

                        getAddress().then((val) {
                          createText(val, titleController.text,
                                  bodyController.text)
                              .then((val) {
                            test(val);
                          });
                        });
                      },
                    ),
                  ),
                  RaisedButton(
                    child: Text("Delete"),
                    onPressed: () {
                      getAddress().then((val) {
                        deleteText(val, int.parse(textIdController.text))
                            .then((val) {
                          test(val);
                        });
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text("Put"),
                    onPressed: () {
                      getAddress().then((val) {
                        editText(
                          val,
                          int.parse(textIdController.text),
                          titleController.text,
                          bodyController.text,
                        ).then((val) {
                          test(val);
                        });
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text("Select Text"),
                    onPressed: () {
                      getAddress().then((val) {
                        selectText(val, int.parse(textIdController.text))
                            .then((val) {
                          test(val);
                        });
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text("reset Text"),
                    onPressed: () {
                      getAddress().then((val) {
                        resetText(val).then((val) {
                          test(val);
                        });
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text("Get Text"),
                    onPressed: () {
                      getAddress().then((val) {
                        getText(val, int.parse(textIdController.text)).then((val) {
                          test(val);
                        });
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text("Get All Text"),
                    onPressed: () {
                      getAddress().then((val) {
                        getAllText(val).then((val) {
                          test(val);
                        });
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text("get selected Text"),
                    onPressed: () {
                      getAddress().then((val) {
                        getSelectedText(val)
                            .then((val) {
                          test(val);
                        });
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text("get Categories"),
                    onPressed: () {
                      getAddress().then((val) {
                        getAllCategories(val)
                            .then((val) {
                          test(val);
                        });
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text("get Categorie by Id"),
                    onPressed: () {
                      getAddress().then((val) {
                        getCategory(val, int.parse(categoryIdController.text))
                            .then((val) {
                          test(val);
                        });
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text("delete Category"),
                    onPressed: () {
                      getAddress().then((val) {
                        deleteCategory(val, int.parse(categoryIdController.text), deleteContentsController.text == '1' ? true : false )
                            .then((val) {
                          test(val);
                        });
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text("edit category"),
                    onPressed: () {
                      getAddress().then((val) {
                        editCategory(val, int.parse(categoryIdController.text), titleController.text, bodyController.text)
                            .then((val) {
                          test(val);
                        });
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text("add text to category"),
                    onPressed: () {
                      getAddress().then((val) {
                        addTextToCategory(val, int.parse(categoryIdController.text),int.parse(textIdController.text))
                            .then((val) {
                          test(val);
                        });
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text("create Category"),
                    onPressed: () {
                      getAddress().then((val) {
                        createCategory(val, titleController.text , bodyController.text)
                            .then((val) {
                          test(val);
                        });
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getAddress() async {
    String ipAddress = await preferences.getIpAddress();

    String portNumber = await preferences.getPortNumber();

    return ipAddress + ":" + portNumber;
  }

  void test(http.Response i) {
    print("=======================================\n");
    print(i.headers);
    print(i.body);
    print(i.statusCode);
    print(i.toString());
    print("=======================================");
  }
}
