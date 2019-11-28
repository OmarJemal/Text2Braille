class TextModel {
  int _id;
  int _index;
  bool _selected;
  String _text;
  DateTime _timeStamp;
  String _title;

  TextModel(
      {int id,
      int index,
      bool selected,
      String text,
      DateTime timeStamp,
      String title}) {
    _id = id;
    _index = index;
    _selected = selected;
    _text = text;
    _timeStamp = timeStamp;
    _title = title;
  }

  int get id => _id;
  int get index => _index;
  bool get isSelected => _selected;
  String get text => _text;
  DateTime get timeStamp => _timeStamp;
  String get title => _title;

  int compareTo(DateTime other) {
    return _timeStamp.compareTo(other);
  }

  TextModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _index = json['index'];
    _selected = json['selected'];
    _text = json['text'];
    _timeStamp = DateTime.parse(json['timeStamp']);
    _title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['index'] = this._index;
    data['selected'] = this._selected;
    data['text'] = this._text;
    data['timeStamp'] = this._timeStamp;
    data['title'] = this._title;
    return data;
  }
}
