import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:real_braille/models/FullModels/CategoryModel.dart';
import 'package:toast/toast.dart';

import 'package:real_braille/Network_Call_Methods/NetworkCalls.Dart';
import 'package:real_braille/Util/PreferencesHandler.dart';

import 'package:http/http.dart' as http;

class EditCategoryPage extends StatefulWidget {
  EditCategoryPage({Key key, this.name, this.catId}) : super(key: key);

  final String name;
  final int catId;


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditCategoryPageState();
  }
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  var nameController ;
  var descriptionController ;

  
  bool bodyLoaded = false;

  SharedPref preferences;

  @override
  void initState() {
    SharedPref initializer = SharedPref();

    nameController= TextEditingController(text: widget.name) ;

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
    nameController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                Text("Category Name"),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  height: 40.0,
                  width: 150.0,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Name of Category",
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
                Text("Category Description"),
                FutureBuilder(
                  future: getMessage(widget.catId),
                  builder: (BuildContext context,
                      AsyncSnapshot<http.Response> snapshot) {
                    if (snapshot.hasData) {
                      var responseJson = jsonDecode(snapshot.data.body);
                      // var responseJson = jsonDecode(val.body);

                      CategoryModel currentText =
                          CategoryModel.fromJson(responseJson);

                      descriptionController.text = currentText.description;

                      if (!bodyLoaded) {
                        descriptionController =
                            TextEditingController(text: currentText.description);
                            bodyLoaded = true;
                      }


                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        height: 200.0,
                        width: 300.0,
                        child: TextField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Category Description"),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          border: Border.all(color: Colors.black54),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print("ERROR IN EDITCATEGORY FUTURE BUILDER:" +
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
                    child: Text("Create Category"),
                    onPressed: () {
                      /*
                          final snackBar = SnackBar(
                            content: Text("Submitted Text " + nameController.text),
                          );
                          FocusScope.of(context).unfocus();
                          Scaffold.of(context).showSnackBar(snackBar);
                          */
                      if (preferences != null) {
                        preferences.getAddress().then(
                          (val) {
                            print("in here pt 1");

                            try {
                              createCategory(val, nameController.text,
                                      descriptionController.text)
                                  .then((val) {
                                print("in here pt 2");

                                Toast.show(
                                  val.body,
                                  context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.TOP,
                                );
                              }).catchError((err) {
                                print(err);
                              });
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

  Future<http.Response> getMessage(int catId) async {
    if (preferences != null) {
      String address = await preferences.getAddress();
      return await getCategory(address, catId);
    } else {
      return null;
    }
  }
}
