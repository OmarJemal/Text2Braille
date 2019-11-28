
import 'dart:convert';

import 'package:real_braille/models/PreviewModels/TextPreviewModel.dart';
class CategoryPreviewModel {

  
  String _description;
  int _id;
  String _name;
  List<TextPreviewModel> _texts;

  CategoryPreviewModel(
      {String description,
      int id,
      String name,
      List<TextPreviewModel> texts}) {
    _description = description;
    _id = id;
    _name = name;
    _texts = texts;    
  }

  String get description => _description;
  int get id => _id;
  String get name => _name;
  List<TextPreviewModel> get texts => _texts;

 
  CategoryPreviewModel.fromJson(Map<String, dynamic> json) {
    _description = json['description'];
    _id = json['id'];
    _name= json['name'];


    List<TextPreviewModel> texts = [];
    dynamic textList = json["texts"];

   for  (var textEntry in textList){

      TextPreviewModel text = TextPreviewModel.fromJson(textEntry);

      texts.add(text);
    }
    _texts = texts;
   
  }

  
}
