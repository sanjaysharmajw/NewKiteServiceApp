class ServiceListMasterModel {
  ServiceListMasterModel({
    bool? status,
    List<ServiceTypeListMasterData>? data,}){
    _status = status;
    _data = data;
  }

  ServiceListMasterModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ServiceTypeListMasterData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<ServiceTypeListMasterData>? _data;
  ServiceListMasterModel copyWith({  bool? status,
    List<ServiceTypeListMasterData>? data,
  }) => ServiceListMasterModel(  status: status ?? _status,
    data: data ?? _data,
  );
  bool? get status => _status;
  List<ServiceTypeListMasterData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ServiceTypeListMasterData {
  ServiceTypeListMasterData({
    String? id,
    String? name,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? createdBy,
    String? updatedBy,}){
    _id = id;
    _name = name;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _createdBy = createdBy;
    _updatedBy = updatedBy;
  }

  ServiceTypeListMasterData.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];
  }
  String? _id;
  String? _name;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _createdBy;
  String? _updatedBy;
  ServiceTypeListMasterData copyWith({  String? id,
    String? name,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? createdBy,
    String? updatedBy,
  }) => ServiceTypeListMasterData(  id: id ?? _id,
    name: name ?? _name,
    status: status ?? _status,
    createdAt: createdAt ?? _createdAt,
    updatedAt: updatedAt ?? _updatedAt,
    createdBy: createdBy ?? _createdBy,
    updatedBy: updatedBy ?? _updatedBy,
  );
  String? get id => _id;
  String? get name => _name;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get createdBy => _createdBy;
  String? get updatedBy => _updatedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['created_by'] = _createdBy;
    map['updated_by'] = _updatedBy;
    return map;
  }

}