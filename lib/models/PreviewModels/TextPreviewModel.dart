
class TextPreviewModel {
  int _id;
  DateTime _timeStamp;
  String _title;
  String _categoryName;

  TextPreviewModel(
      {int id,
      DateTime timeStamp,
      String title,
      String categoryName}) {
    _id = id;
    _timeStamp = timeStamp;
    _title = title;
    _categoryName = categoryName;
  }

  int get id => _id;
  DateTime get timeStamp => _timeStamp;
  String get title => _title;
  String get categoryName => _categoryName;

  int compareTo(TextPreviewModel other) {
    return _timeStamp.compareTo(other.timeStamp);
  }

  TextPreviewModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _timeStamp = DateTime.parse(json['timeStamp']);
    _title = json['title'];
    _categoryName = json['category'] ?? "None";
  }
}
