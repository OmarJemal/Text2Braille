import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:real_braille/Pages/EditMessagePage.dart';

import 'package:real_braille/Util/PreferencesHandler.dart';
import 'package:real_braille/Network_Call_Methods/NetworkCalls.Dart';
import 'package:real_braille/models/FullModels/CategoryModel.dart';
import 'package:real_braille/models/FullModels/TextModel.dart';
import 'package:real_braille/models/PreviewModels/CategoryPreview.dart';
import 'package:real_braille/models/PreviewModels/TextPreviewModel.dart';
import 'package:toast/toast.dart';

import 'editCategoryPage.dart';

class CategoriesPage extends StatefulWidget {
  final PageController pageController;

  CategoriesPage({Key key, this.pageController}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CategoriesPageState();
  }
}

class _CategoriesPageState extends State<CategoriesPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          widget.pageController.animateToPage(1,
              duration: Duration(milliseconds: 350), curve: Curves.easeInOut);
        },
      ),
      body: FutureBuilder(
        future: getCategories(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            print("IN FUTUREBUILDER CATEGORY LISTER");

            // List<TextPreviewModel> texts = snapshot.data[0];
            List<CategoryPreviewModel> categories = snapshot.data[0];
            /*

          Dropdown menu for filter selections

          DropdownButton(
              hint: Text(
                  'Please choose a location'), // Not necessary for Option 1
              value: _selectedFilter,
              onChanged: (newValue) {
                setState(() {
                  _selectedFilter = newValue;
                });
              },
              items: categories.map((category) {
                return DropdownMenuItem(
                  child: new Text(category.name),
                  value: category.name,
                );
              }).toList());

List<TextPreviewModel> filteredTexts = texts.where((val){
               val.
             }).toList()


          */

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

            Widget categoryList = ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: categories.length,
              itemBuilder: (context, int index) {
                return Column(
                  children: [
                    ExpansionTile(
                      leading: Icon(Icons.folder),
                      title: Text(
                        categories[index].name,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                              color: Colors.orangeAccent,
                              icon: Icon(Icons.edit),
                              tooltip: "Edit Category",
                              onPressed: () {
                                goToEditCategoryPage(categories[index].name,
                                    categories[index].id);
                              },
                            ),
                            IconButton(
                              color: Colors.redAccent,
                              icon: Icon(Icons.delete),
                              tooltip: "Delete Category",
                              onPressed: () {
                                displayDeleteMessage(categories[index].id);
                              },
                            ),
                            IconButton(
                              color: Colors.blueAccent,
                              icon: Icon(Icons.remove),
                              tooltip: "Remove Text from a Category",
                              onPressed: () {
                                displayTextMenu(categories[index].texts,
                                    categories[index].id);
                              },
                            ),
                            IconButton(
                              color: Colors.green,
                              icon: Icon(Icons.remove_red_eye),
                              tooltip: "View Category",
                              onPressed: () {
                                displayFullCategory(categories[index].id);
                              },
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

            return categoryList;

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
            print("ERROR HERE" + snapshot.error.toString());
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

  Future<http.Response> getCategoriesList() async {
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

  Future<dynamic> getCategories() async {
    List<dynamic> result = [];

    await getCategoriesList().then((val) {
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

    print("result was $result");
    return result;
  }

//will be changed to be the view for the category
  void displayFullCategory(int catId) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder(
          future: getFullCategory(catId),
          builder:
              (BuildContext context, AsyncSnapshot<CategoryModel> snapshot) {
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
                              snapshot.data.name,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        /* Row(
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
                        ), */
                        /* SizedBox(
                          height: 15.0,
                        ), */
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              // Expanded(
                              //child:

                              Container(
                                height: 200,
                                child: SingleChildScrollView(
                                  //   scrollDirection: Axis.vertical,

                                  child: Text(
                                    snapshot.data.description,
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
                        Container(
                          margin: EdgeInsets.all(30),
                          child: Center(
                            child: Text("Texts"),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data.texts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      snapshot.data.texts[index].title,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  Divider(),
                                ],
                              );
                            },
                          ),
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
              print("error: " + snapshot.error.toString());
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

  void displayDeleteMessage(int catId) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Attention!'),
        content: new Text(
          "Do you want to delete the contents of this Category?",
          style: new TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: <Widget>[
          new FlatButton(
              onPressed: () {
                sendDeleteCategoryRequest(catId, true);
                Navigator.pop(context);
              },
              child: new Text('yes')),
          new FlatButton(
              onPressed: () {
                sendDeleteCategoryRequest(catId, false);
                Navigator.pop(context);
              },
              child: new Text('no')),
        ],
      ),
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
      SharedPref initializer = SharedPref();
      await initializer.init();
      String address = await initializer.getAddress();
      var response = await getText(address, messageId);

      var responseJson = jsonDecode(response.body);

      TextModel fullText = TextModel.fromJson(responseJson);

      return fullText;
    }
  }

  Future<CategoryModel> getFullCategory(int catId) async {
    if (preferences != null) {
      String address = await preferences.getAddress();
      var response = await getCategory(address, catId);

      var responseJson = jsonDecode(response.body);
      print("fullCategory2:" + responseJson.toString());

      CategoryModel fullCategory = CategoryModel.fromJson(responseJson);
      print("fullCategory:" + fullCategory.toString());
      return fullCategory;
    } else {
      SharedPref initializer = SharedPref();
      await initializer.init();
      String address = await initializer.getAddress();
      var response = await getCategory(address, catId);

      var responseJson = jsonDecode(response.body);
      print("fullCategory2:" + responseJson.toString());

      CategoryModel fullCategory = CategoryModel.fromJson(responseJson);
      print("fullCategory:" + fullCategory.toString());
      return fullCategory;
    }
  }

  void displayTextMenu(List<TextPreviewModel> texts, int catId) {
    showDialog(
      context: context,
      builder: (context) {
        return Card(
          margin: EdgeInsets.fromLTRB(50.0, 190.0, 40.0, 250),
          child: Container(
            child: Column(
              children: <Widget>[
                Text(
                  "Texts",
                  style: TextStyle(fontSize: 25),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: texts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Divider(),
                          ListTile(
                            title: Text(
                              texts[index].title,
                              style: TextStyle(fontSize: 18),
                            ),
                            onTap: () {
                              sendRemovalFromCategoryRequest(
                                  texts[index].id, catId);
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

  void sendRemovalFromCategoryRequest(int textId, int catId) {
    print("activated!");
    preferences.getAddress().then(
      (val) {
        print("Getting Address");
        removeTextFromCategory(val, catId, textId).then(
          (val) {
            print("Selected something");
            print(val.body);
            print(textId);
            Toast.show(
              "text removed to category!",
              context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.TOP,
            );
          },
        );
      },
    );
  }

  void sendDeleteCategoryRequest(int catId, bool deleteContents) {
    preferences.getAddress().then(
      (val) {
        deleteCategory(val, catId, deleteContents).then(
          (val) {
            Toast.show(
              "Deleted Category!",
              context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.TOP,
            );
          },
        );
      },
    );
    setState(() {});
  }

  void goToEditCategoryPage(String name, int catId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCategoryPage(
          name: name,
          catId: catId,
        ),
      ),
    );

    setState(() {});
  }
}
