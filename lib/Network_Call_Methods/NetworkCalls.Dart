import 'package:http/http.dart' as http;

import 'dart:convert';

//POST METHODS

//network call method for creating a Text
Future<http.Response> createText(
    String ipAddress, String title, String message) async {
  var url = 'http://' + ipAddress + "/create/text";

  Map data = {'body': message, 'title': title};

  var body = json.encode(data);

  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  return response;
}

//network call method for creating a Category with a name and description
Future<http.Response> createCategory( String ipAddress, String name, String description, {List<int> Texts}) async {
  
  var url = 'http://' + ipAddress + "/organization/create/category";

  Map data = {
    'description': description,
    'name':name,
    'texts': [],
  };

  var body = json.encode(data);

  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  return response;
}


//DELETE METHODS

//network call method for deleting a text specified by an id
Future<http.Response> deleteText(String ipAddress, int id) async {
  
  var url = 'http://' + ipAddress + "/deleteText/" + id.toString();

  var response = http.delete(
    url,
    headers: {"Content-Type": "application/json"},
  );

  return response;
}

//network call method for deleting a category with an option of deleting the text with the category
Future<http.Response> deleteCategory(String ipAddress, int id, bool deleteContents) async {
  
  var url = 'http://' + ipAddress + "/organization/category/" + id.toString() +" ?deleteContents=" + deleteContents.toString();

  var response = http.delete(
    url,
    headers: {"Content-Type": "application/json"},
  );

  return response;
}

//PUT METHODS

//network call method for editing a text specified by an id
Future<http.Response> editText(
    String ipAddress, int id, String title, String message) async {
  var url = 'http://' + ipAddress + "/edit/text/" + id.toString();

  Map data = {
    'body': message,
    'title': title,
  };

  var body = json.encode(data);

  var response = await http.put(
    url,
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  return response;
}

//network call method for selecting Text with a specified id
Future<http.Response> selectText(
  String ipAddress,
  int id,
) async {
  var url = 'http://' + ipAddress + "/selectText";

  Map data = {
    'textIdToSelect': id,
  };

  var body = json.encode(data);

  var response = await http.put(
    url,
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  return response;
}

//network call method for resetting the reading index
Future<http.Response> resetText(String ipAddress) async {
  var url = 'http://' + ipAddress + "/reset";

  var response = await http.put(
    url,
    headers: {"Content-Type": "application/json"},
  );

  return response;
}

//not sure if I should implement /next & /prev api endpoint calls

//GET METHODS

// network call method for getting a Text specified with an id
Future<http.Response> getText(String ipAddress, int id) async {
  var url = 'http://' + ipAddress + "/getText/" + id.toString();

  var response = await http.get(
    url,
    headers: {"Content-Type": "application/json"},
  );

  return response;
}

// network call method for getting all categories
Future<http.Response> getAllCategories(String ipAddress) async {
  var url = 'http://' + ipAddress + "/organization/categories" ;

  var response = await http.get(
    url,
    headers: {"Content-Type": "application/json"},
  );

  return response;
}

// network call method for getting category with id
Future<http.Response> getCategory(String ipAddress, int id) async {
  var url = 'http://' + ipAddress + "/organization/category/" + id.toString();

  var response = await http.get(
    url,
    headers: {"Content-Type": "application/json"},
  );

  return response;
}

//network call method for getting all texts
Future<http.Response> getAllText(String ipAddress) async {
  var url = 'http://' + ipAddress + "/getAllTexts";

  var response = await http.get(
    url,
    headers: {"Content-Type": "application/json"},
  );

  return response;
}

//network call method for getting the current selected Text
Future<http.Response> getSelectedText(String ipAddress, int id) async {
  var url = 'http://' + ipAddress + "/selectText";

  var response = await http.get(
    url,
    headers: {"Content-Type": "application/json"},
  );

  return response;
}

//PATCH METHODS

//network call method for selecting Category with a specified id
Future<http.Response> editCategory( String ipAddress,int id, String name, String description) async {
  
  var url = 'http://' + ipAddress + "/organization/category/"+ id.toString();

  Map data = {
    'description': description,
    'name':name,
  };

  var body = json.encode(data);

  var response = await http.patch(
    url,
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  return response;
}

//network call method for adding Text with a specified id to a Category with a specified id
Future<http.Response> addTextToCategory( String ipAddress,int catId,int textId, String name, String description) async {
  
  var url = 'http://' + ipAddress + "/organization/category/" + catId.toString() + "/addText/"+ textId.toString();

  var response = await http.patch(
    url,
    headers: {"Content-Type": "application/json"},
  );

  return response;
}

