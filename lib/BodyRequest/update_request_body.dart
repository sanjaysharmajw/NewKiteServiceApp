/// user_id : "6386f83ba2d80074cbcfb903"
/// documents : [{"id_number":"12345","photo":"https://tse1.mm.bing.net/th?id=OIP.9OIuT6R4m3VERDmK_ANrCwHaDt&pid=Api&P=0"}]

class UpdateRequestBody {
  UpdateRequestBody({
      String? userId, 
      List<Documents>? documents,}){
    _userId = userId;
    _documents = documents;
}

  UpdateRequestBody.fromJson(dynamic json) {
    _userId = json['user_id'];
    if (json['documents'] != null) {
      _documents = [];
      json['documents'].forEach((v) {
        _documents?.add(Documents.fromJson(v));
      });
    }
  }
  String? _userId;
  List<Documents>? _documents;
UpdateRequestBody copyWith({  String? userId,
  List<Documents>? documents,
}) => UpdateRequestBody(  userId: userId ?? _userId,
  documents: documents ?? _documents,
);
  String? get userId => _userId;
  List<Documents>? get documents => _documents;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    if (_documents != null) {
      map['documents'] = _documents?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id_number : "12345"
/// photo : "https://tse1.mm.bing.net/th?id=OIP.9OIuT6R4m3VERDmK_ANrCwHaDt&pid=Api&P=0"

class Documents {
  Documents({
      String? idNumber, 
      String? photo,}){
    _idNumber = idNumber;
    _photo = photo;
}

  Documents.fromJson(dynamic json) {
    _idNumber = json['id_number'];
    _photo = json['photo'];
  }
  String? _idNumber;
  String? _photo;
Documents copyWith({  String? idNumber,
  String? photo,
}) => Documents(  idNumber: idNumber ?? _idNumber,
  photo: photo ?? _photo,
);
  String? get idNumber => _idNumber;
  String? get photo => _photo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_number'] = _idNumber;
    map['photo'] = _photo;
    return map;
  }

}