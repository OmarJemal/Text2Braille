import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:real_braille/models/FullModels/TextModel.dart';
import 'package:real_braille/models/PreviewModels/TextPreviewModel.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

import 'package:real_braille/Network_Call_Methods/NetworkCalls.Dart';
import 'package:real_braille/Util/PreferencesHandler.dart';

class EditPage extends StatefulWidget {
  final String title;
  final int textId;

  EditPage({Key key, this.title, this.textId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditPageState();
  }
}

class _EditPageState extends State<EditPage> {
  var bodyController;
  var titleController;

  bool bodyLoaded = false;

  SharedPref preferences;

  @override
  void initState() {
    SharedPref initializer = SharedPref();

    titleController = TextEditingController(text: widget.title);

    initializer.init().then((val) {
      preferences = val;

      setState(() {});
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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Message!"),
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                Text("Message Title"),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  height: 40.0,
                  width: 150.0,
                  child: TextFormField(
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
                FutureBuilder(
                  future: getMessage(widget.textId),
                  builder: (BuildContext context,
                      AsyncSnapshot<http.Response> snapshot) {
                    if (snapshot.hasData) {
                      var responseJson = jsonDecode(snapshot.data.body);
                      // var responseJson = jsonDecode(val.body);

                      TextModel currentText = TextModel.fromJson(responseJson);

                      if (!bodyLoaded) {
                        bodyController =
                            TextEditingController(text: currentText.text);
                            bodyLoaded = true;
                      }

                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        height: 200.0,
                        width: 300.0,
                        child: TextFormField(
                          controller: bodyController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Message body"),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          border: Border.all(color: Colors.black54),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print("ERROR IN EDITMESSAGE FUTURE BUILDER:" +
                          snapshot.error);
                      return Center(
                        child: Text("An error has occured"),
                      );
                    } else {
                      return Center(
                        child: LinearProgressIndicator(),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                Builder(
                  builder: (context) => RaisedButton(
                    disabledColor: Colors.blueAccent,
                    color: Colors.lightBlue,
                    child: Text("Update Text"),
                    onPressed: () {
                      /*
                          final snackBar = SnackBar(
                            content: Text("Submitted Text " + bodyController.text),
                          );
                          FocusScope.of(context).unfocus();
                          Scaffold.of(context).showSnackBar(snackBar);
                          */
                      if (preferences != null) {
                        preferences.getAddress().then(
                          (val) {
                            print("in here pt 1");
                            try {
                              editText(val, widget.textId, titleController.text,
                                      bodyController.text)
                                  .then(
                                (val) {
                                  print("in here pt 2");

                                  Toast.show(
                                    val.body,
                                    context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.TOP,
                                  );
                                },
                              ).catchError(
                                (err) {
                                  print(err);
                                },
                              );
                              Navigator.pop(context);
                            } catch (e) {
                              print(e);
                            }
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<http.Response> getMessage(int messageId) async {
    if (preferences != null) {
      String address = await preferences.getAddress();
      return await getText(address, messageId);
    } else {
      return null;
    }
  }
}
