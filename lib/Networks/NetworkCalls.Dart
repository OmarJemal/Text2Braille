import 'package:http/http.dart' as http;

import 'dart:convert';



Future<http.Response> createMessage(String ipAddress, String title, String message) async {

var url = 'http://' + ipAddress + "/create/text";

Map data = {
              'body': message,
              'title' : title
            };

var body = json.encode(data);

var response = await http.post(url,
headers: {"Content-Type": "application/json"},
body: body);

return response;

}
