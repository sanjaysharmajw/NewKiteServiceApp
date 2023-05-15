class ReasonMasterModel {
  ReasonMasterModel({
      bool? status, 
      List<ReasonMasterData>? data,}){
    _status = status;
    _data = data;
}

  ReasonMasterModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ReasonMasterData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<ReasonMasterData>? _data;
ReasonMasterModel copyWith({  bool? status,
  List<ReasonMasterData>? data,
}) => ReasonMasterModel(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<ReasonMasterData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ReasonMasterData {
  ReasonMasterData({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  ReasonMasterData.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
  ReasonMasterData copyWith({  String? id,
  String? name,
}) => ReasonMasterData(  id: id ?? _id,
  name: name ?? _name,
);
  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    return map;
  }

}