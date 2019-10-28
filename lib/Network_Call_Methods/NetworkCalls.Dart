import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:http/http.dart';

//POST METHODS

//network call method for creating a Text
Future<http.Response> createText( String ipAddress, String title, String message) async {
  var url = 'http://' + ipAddress + "/create/text";

  Map data = {'body': message, 
              'title': title
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
  var url = 'http://' + ipAddress + "/deleteText";

  Map data = {
    'textIdToSelect': id,
  };

  var body = json.encode(data);

  var rq = Request('DELETE', Uri.parse(url));

  rq.headers.addAll(
    {"Content-Type": "application/json"},
  );

  rq.bodyFields = data;

  var response = await http.Client().send(rq).then(Response.fromStream);

/*
var response = await http.delete(url,
headers: {"Content-Type": "application/json"},  ///
body: body);
*/

  return response;
}

//PUT METHODS

//network call method for editing a text specified by an id
Future<http.Response> editText( String ipAddress, int id, String title, String message) async {
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
Future<http.Response> selectText( String ipAddress, int id, ) async {
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
Future<http.Response> resetText( String ipAddress) async {
  var url = 'http://' + ipAddress + "/reset" ;

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

//network call method for getting all texts
Future<http.Response> getAllText(String ipAddress, int id) async {
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
