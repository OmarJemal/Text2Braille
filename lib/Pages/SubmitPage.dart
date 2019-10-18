import 'package:flutter/material.dart';

import 'package:real_braille/Networks/NetworkCalls.Dart';

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
  final ipController = TextEditingController();

  @override
  void initState() {
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
    ipController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100.0,
              ),
              Text("Text to be Translated"),
              TextField(
                controller: ipController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "IP address of System"),
              ),
              SizedBox(
                height: 70.0,
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title of Message"),
              ),
              SizedBox(
                height: 70.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                height: 150.0,
                child: TextField(
                  autofocus: true,
                  maxLines: 8,
                  controller: bodyController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Message to be Translated"),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  border: Border.all(color: Colors.black54),
                ),
              ),
              SizedBox(
                height: 50.0,
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
                          var x =createMessage(ipController.text, titleController.text, bodyController.text);
                          x.then((i) {
                            print("NETWORK2 " + i.statusCode.toString());
                          });
                          print("NETWORK CALL" + x.toString());
                        },
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
