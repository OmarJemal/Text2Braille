
import 'dart:convert';

import 'package:real_braille/models/FullModels/TextModel.dart';

class CategoryModel {

  
  String _description;
  int _id;
  String _name;
  List<TextModel> _texts;

  CategoryModel(
      {String description,
      int id,
      String name,
      List<TextModel> texts}) {
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
    _name= json['name'];


    List<TextModel> texts = [];
    dynamic textList = json["texts"];

   for  (var textEntry in textList){
      TextModel text = TextModel.fromJson(jsonDecode(textEntry));
      texts.add(text);
    }
    _texts = texts;
   
  }

  
}
