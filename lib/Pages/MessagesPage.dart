import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:real_braille/Pages/EditMessagePage.dart';

import 'package:real_braille/Util/PreferencesHandler.dart';
import 'package:real_braille/Network_Call_Methods/NetworkCalls.Dart';
import 'package:real_braille/models/FullModels/TextModel.dart';
import 'package:real_braille/models/PreviewModels/CategoryPreview.dart';
import 'package:real_braille/models/PreviewModels/TextPreviewModel.dart';
import 'package:toast/toast.dart';

import 'CategoryHomePage.dart';

class MessagesPage extends StatefulWidget {
  final PageController pageController;

  MessagesPage({Key key, this.pageController}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MessagesPageState();
  }
}

class _MessagesPageState extends State<MessagesPage> {
  SharedPref preferences;
  String _selectedFilter = "All";

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          widget.pageController.animateToPage(1,
              duration: Duration(milliseconds: 350), curve: Curves.easeInOut);
        },
      ),
      body: FutureBuilder(
        future: getAllMessagesAndCategory(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            print("IN FUTUREBUILDER MESSAGE LISTER");

            List<TextPreviewModel> texts = snapshot.data[0];
            List<CategoryPreviewModel> categories = snapshot.data[1];
            int selectedTextId = snapshot.data[2];

            //Dropdown menu for filter selections
            List<String> categoryFilters = ["All", "None"];

            categories.forEach(
              (category) {
                categoryFilters.add(category.name);
              },
            );

            categories.map(
              (val) {
                print("sysc3600");
              },
            );

            Widget dropDownButton = DropdownButton(
                hint: Text(
                    'Please choose a filter'), // Not necessary for Option 1
                value: _selectedFilter,
                onChanged: (newValue) {
                  setState(
                    () {
                      _selectedFilter = newValue;
                    },
                  );
                },
                items: categoryFilters.map(
                  (category) {
                    return DropdownMenuItem<String>(
                      child: new Text(category),
                      value: category,
                    );
                  },
                ).toList());

            List<TextPreviewModel> filteredTexts = texts.where((val) {
              if (_selectedFilter == "All") {
                return true;
              } else {
                return _selectedFilter == val.categoryName;
              }
            }).toList();

            /* 
          Widget messageList = ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: texts.length,
            itemBuilder: (context, int index) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      texts[index].title,
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () => displayMenuOptions(
                        texts[index].id, texts[index].title, categories),
                  ),
                  Divider(),
                ],
              );
            },
          );
        */

            /*  Widget messageList = ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: texts.length,
                itemBuilder: (context, int index) {
                  return Column(
                    children: [
                      ExpansionTile(
                        leading: Icon(Icons.description),
                        title: Text(
                          texts[index].title,
                          style: TextStyle(
                              fontSize: 18,
                              color: texts[index].id == selectedTextId
                                  ? Colors.redAccent
                                  : Colors.black),
                        ),
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              IconButton(
                                color: Colors.green,
                                icon: Icon(Icons.send),
                                tooltip: "Select",
                                onPressed: () {
                                  sendSelectRequest(texts[index].id);
                                  setState(() {});
                                },
                              ),
                              IconButton(
                                color: Colors.redAccent,
                                icon: Icon(Icons.delete),
                                tooltip: "Delete",
                                onPressed: () =>
                                    sendDeleteRequest(texts[index].id),
                              ),
                              IconButton(
                                color: Colors.orange,
                                icon: Icon(Icons.edit),
                                tooltip: "Edit",
                                onPressed: () => goToEditPage(
                                    texts[index].title, texts[index].id),
                              ),
                              IconButton(
                                color: Colors.blueAccent,
                                icon: Icon(Icons.add),
                                tooltip: "Add to a Category",
                                onPressed: () => displayCategoryMenu(
                                    categories, texts[index].id),
                              ),
                              IconButton(
                                color: Colors.deepPurpleAccent,
                                icon: Icon(Icons.remove_red_eye),
                                tooltip: "View",
                                onPressed: () =>
                                    displayMessage(texts[index].id),
                              )
                            ],
                          )
                        ],
                      ),
                      Divider(),
                    ],
                  );
                },
              ); */

            Widget filteredMessageList = ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredTexts.length,
              itemBuilder: (context, int index) {
                return Column(
                  children: [
                    ExpansionTile(
                      leading: Icon(Icons.description),
                      title: Text(
                        texts[index].title,
                        style: TextStyle(
                            fontSize: 18,
                            color: filteredTexts[index].id == selectedTextId
                                ? Colors.redAccent
                                : Colors.black),
                      ),
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                              color: Colors.green,
                              icon: Icon(Icons.send),
                              tooltip: "Select",
                              onPressed: () {
                                sendSelectRequest(filteredTexts[index].id);
                                setState(() {});
                              },
                            ),
                            IconButton(
                              color: Colors.redAccent,
                              icon: Icon(Icons.delete),
                              tooltip: "Delete",
                              onPressed: () =>
                                  sendDeleteRequest(filteredTexts[index].id),
                            ),
                            IconButton(
                              color: Colors.orange,
                              icon: Icon(Icons.edit),
                              tooltip: "Edit",
                              onPressed: () => goToEditPage(
                                  texts[index].title, filteredTexts[index].id),
                            ),
                            IconButton(
                              color: Colors.blueAccent,
                              icon: Icon(Icons.add),
                              tooltip: "Add to a Category",
                              onPressed: () => displayCategoryMenu(
                                  categories, filteredTexts[index].id),
                            ),
                            IconButton(
                              color: Colors.deepPurpleAccent,
                              icon: Icon(Icons.remove_red_eye),
                              tooltip: "View",
                              onPressed: () =>
                                  displayMessage(filteredTexts[index].id),
                            )
                          ],
                        )
                      ],
                    ),
                    Divider(),
                  ],
                );
              },
            );
            print("This is categories $categories");

            return Column(
              children: <Widget>[
                //TODO: there will be a filter button
                Row(
                  children: <Widget>[
                    Container(child: dropDownButton),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.folder),
                        tooltip: "Manage Categories",
                        onPressed: () => goToCategoryHomePage(),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
                Flexible(child: filteredMessageList),
              ],
            );

            /* return messageList; */

            /*
          print(y[0]);
          print(y[0]['timeStamp']);
          print(y[0]['timeStamp'].runtimeType);

          var z1 = DateTime.parse(y[0]['timeStamp']);
          var z2 = DateTime.parse(y[1]['timeStamp']);
          var z3 = DateTime.parse(y[2]['timeStamp']);
          var z4 = DateTime.parse(y[3]['timeStamp']);

          var mylist = [z1,z3,z4,z2];

          mylist.sort( (a,b) => a.compareTo(b));
          print(mylist);
          print(mylist.runtimeType);

          */

            //return Center(child: Text("Testing"));

          } else if (snapshot.hasError) {
            print("ERROR BUILDING MESSAGE FUTURE");
            print(snapshot.error.toString());
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

  Future<http.Response> getMessages() async {
    if (preferences != null) {
      String address = await preferences.getAddress();
      return await getAllText(address);
    } else {
      SharedPref initializer = SharedPref();
      await initializer.init();
      String address = await initializer.getAddress();
      return await getAllText(address);
    }
  }

  Future<http.Response> getCategories() async {
    if (preferences != null) {
      String address = await preferences.getAddress();
      return await getAllCategories(address);
    } else {
      SharedPref initializer = SharedPref();
      await initializer.init();
      String address = await initializer.getAddress();
      return await getAllCategories(address);
    }
  }

  Future<http.Response> getSelected() async {
    if (preferences != null) {
      String address = await preferences.getAddress();
      return await getSelectedText(address);
    } else {
      SharedPref initializer = SharedPref();
      await initializer.init();
      String address = await initializer.getAddress();
      return await getSelectedText(address);
    }
  }

  Future<List<dynamic>> getAllMessagesAndCategory() async {
    List<dynamic> result = [];

    await getMessages().then((val) {
      print("IN GET MESSAGES");
      print(val.body);
      //print(snapshot.data.body.runtimeType);
      print("-------------------");
      var responseJson = jsonDecode(val.body);
      //print(x);
      //print(x.runtimeType);
      var textList = responseJson["textList"];
      List<TextPreviewModel> texts = [];

      for (var textEntry in textList) {
        TextPreviewModel text = TextPreviewModel.fromJson(textEntry);
        texts.add(text);
      }

      texts.sort((a, b) => a.compareTo(b));
      result.add(texts);
      print("OUT GET MESSAGE");
    });

    await getCategories().then((val) {
      print("IN GET CATEGORY");
      print(val.body);
      //print(snapshot.data.body.runtimeType);
      print("-------------------");
      var responseJson = jsonDecode(val.body);
      //print(x);
      //print(x.runtimeType);
      var textList = responseJson["categories"];
      List<CategoryPreviewModel> categories = [];

      for (var textEntry in textList) {
        print("Test 1");
        print(textEntry);
        CategoryPreviewModel text = CategoryPreviewModel.fromJson(textEntry);
        categories.add(text);
        print("Test 2");
      }

      result.add(categories);
      print("OUT GET CATEGORY");
    });

    await getSelected().then((val) {
      print("IN GET Selected");
      print(val.body);
      //print(snapshot.data.body.runtimeType);
      print("-------------------");
      var responseJson = jsonDecode(val.body);
      //print(x);
      //print(x.runtimeType);
      var selectedId = responseJson["textIdToSelect"];

      result.add(selectedId);
      print("OUT GET Selected");
    });

    print("result was $result");
    return result;
  }

  void displayMenuOptions(
      int textId, String title, List<CategoryPreviewModel> categories) {
    showDialog(
      context: context,
      builder: (context) {
        return Card(
          margin: EdgeInsets.fromLTRB(50.0, 190.0, 40.0, 250),
          child: Container(
            child: Column(
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 19.0),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: <Widget>[
                    RaisedButton(
                        color: Colors.yellowAccent,
                        child: Text("Select"),
                        onPressed: () => sendSelectRequest(textId)),
                    RaisedButton(
                      color: Colors.greenAccent,
                      child: Text("Delete"),
                      onPressed: () => sendDeleteRequest(textId),
                    ),
                    RaisedButton(
                      color: Colors.redAccent,
                      child: Text("Edit"),
                      onPressed: () => goToEditPage(title, textId),
                    )
                  ],
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("Add to a Category"),
                  onPressed: () => displayCategoryMenu(categories, textId),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void displayMessage(int textId) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder(
          future: getFullMessage(textId),
          builder: (BuildContext context, AsyncSnapshot<TextModel> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return Card(
                  margin: EdgeInsets.all(30.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              width: 5.0,
                            ),
                            IconButton(
                              color: Colors.blue,
                              icon: Icon(Icons.close),
                              iconSize: 36.0,
                              onPressed: () {
                                Navigator.pop(context, null);
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              snapshot.data.title,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              "- Published: " +
                                  snapshot.data.timeStamp
                                      .toString()
                                      .substring(0, 11),
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              // Expanded(
                              //child:

                              Container(
                                height: 410,
                                child: SingleChildScrollView(
                                  //   scrollDirection: Axis.vertical,

                                  child: Text(
                                    snapshot.data.text,
                                    // overflow: TextOverflow.visible,
                                  ),
                                ),
                              ),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text("Error loading text"),
                );
              }
            } else if (snapshot.hasError) {
              print("ERROR GETTING MESSAGES/CATEGORIES: " + snapshot.error);

              return Center(
                child: Text("Error message failed to load"),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      },
    );
  }

  Future<TextModel> getFullMessage(int messageId) async {
    if (preferences != null) {
      String address = await preferences.getAddress();
      var response = await getText(address, messageId);

      var responseJson = jsonDecode(response.body);

      TextModel fullText = TextModel.fromJson(responseJson);

      return fullText;
    } else {
      return null;
    }
  }

  void displayCategoryMenu(List<CategoryPreviewModel> categories, int textId) {
    showDialog(
      context: context,
      builder: (context) {
        return Card(
          margin: EdgeInsets.fromLTRB(50.0, 190.0, 40.0, 250),
          child: Container(
            child: Column(
              children: <Widget>[
                Text(
                  "Categories",
                  style: TextStyle(fontSize: 25),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Divider(),
                          ListTile(
                            title: Text(
                              categories[index].name,
                              style: TextStyle(fontSize: 18),
                            ),
                            onTap: () {
                              sendAdditionToCategoryRequest(
                                  textId, categories[index].id);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void sendAdditionToCategoryRequest(int textId, int catId) {
    print("activated!");
    preferences.getAddress().then(
      (val) {
        print("Getting Address");
        addTextToCategory(val, catId, textId).then((val) {
          print("Selected something");
          print(val.body);
          print(textId);
          Toast.show(
            "text added to category!",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
          );
        });
      },
    );
  }

  void sendSelectRequest(int i) {
    {
      print("activated!");
      preferences.getAddress().then((val) {
        print("Getting Address");
        selectText(val, i).then((val) {
          print("Selected something");
          print(val.body);
          print(i);
          Toast.show(
            "Selected text!",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
          );
        });
      });
    }
  }

  void sendDeleteRequest(int i) {
    preferences.getAddress().then((val) {
      deleteText(val, i);
    });

    setState(() {});
  }

  void goToEditPage(String title, int i) {
    Navigator.push(
      context,
      MaterialPageRoute<bool>(
        builder: (context) => EditPage(
          title: title,
          textId: i,
        ),
      ),
    );

    setState(() {});
  }

  void goToCategoryHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryHomePage(),
      ),
    );

    setState(() {});
  }
}
