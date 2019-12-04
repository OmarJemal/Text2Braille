import 'dart:convert';

import 'package:real_braille/models/FullModels/TextModel.dart';

class CategoryModel {
  String _description;
  int _id;
  String _name;
  List<TextModel> _texts;

  CategoryModel(
      {String description, int id, String name, List<TextModel> texts}) {
    _description = description;
    _id = id;
    _name = name;
    _texts = texts;
  }

  String get description => _description;
  int get id => _id;
  String get name => _name;
  List<TextModel> get texts => _texts;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    _description = json['description'];
    _id = json['id'];
    _name = json['name'];

    List<TextModel> texts = [];
        print("got here2");

    dynamic textList = json["texts"];

    print("got here3");

    for (var textEntry in textList) {
          print("got here4");
print(textEntry.toString());
      TextModel text = TextModel.fromJson(textEntry);
      print("got here5");

      texts.add(text);
          print("got here6");

    }
    _texts = texts;
    print("got here");
  }
}
