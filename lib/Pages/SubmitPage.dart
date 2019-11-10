import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:toast/toast.dart';

import 'package:real_braille/Network_Call_Methods/NetworkCalls.Dart';
import 'package:real_braille/Util/PreferencesHandler.dart';

class SubmitPage extends StatefulWidget {
  SubmitPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SubmitPageState();
  }
}

class _SubmitPageState extends State<SubmitPage> {
  final bodyController = TextEditingController();
  final titleController = TextEditingController();

  SharedPref preferences;

  @override
  void initState() {
    SharedPref initializer = SharedPref();

    initializer.init().then((val) {
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
              Text("Message Title"),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                height: 40.0,
                width: 150.0,
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
                height: 200.0,
                width: 300.0,
                child: TextField(
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

                    preferences.getAddress().then(
                      (val) {
                        print("in here pt 1");

                        try{
                          
                        createText(
                                val, titleController.text, bodyController.text)
                            .then((val) {
                          print("in here pt 1");

                          Toast.show(
                            val.body,
                            context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.TOP,
                          );
                        }).catchError((err){
                          print(err);
                        });
                        }catch(e){
                         print(e);
                        }
                      },
                    );
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
