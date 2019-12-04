import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'package:real_braille/Network_Call_Methods/NetworkCalls.Dart';
import 'package:real_braille/Util/PreferencesHandler.dart';

class CreateCategoryPage extends StatefulWidget {
  CreateCategoryPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CreateCategoryPageState();
  }
}

class _CreateCategoryPageState extends State<CreateCategoryPage> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  SharedPref preferences;

  @override
  void initState() {
    SharedPref initializer = SharedPref();

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
    return Container(
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
                    hintText: "Name of Message",
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                height: 200.0,
                width: 300.0,
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Description of Category"),
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
    );
  }
}
