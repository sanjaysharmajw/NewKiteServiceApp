class NotificationModelList {
  NotificationModelList({
      bool? status, 
      List<NotificationData>? data,
      Count? count,}){
    _status = status;
    _data = data;
    _count = count;
}

  NotificationModelList.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(NotificationData.fromJson(v));
      });
    }
    _count = json['count'] != null ? Count.fromJson(json['count']) : null;
  }
  bool? _status;
  List<NotificationData>? _data;
  Count? _count;
NotificationModelList copyWith({  bool? status,
  List<NotificationData>? data,
  Count? count,
}) => NotificationModelList(  status: status ?? _status,
  data: data ?? _data,
  count: count ?? _count,
);
  bool? get status => _status;
  List<NotificationData>? get data => _data;
  Count? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_count != null) {
      map['count'] = _count?.toJson();
    }
    return map;
  }

}

class Count {
  Count({
      String? id, 
      num? allRequest, 
      num? pendingRequest, 
      num? acceptedRequest, 
      num? rejectedRequest,}){
    _id = id;
    _allRequest = allRequest;
    _pendingRequest = pendingRequest;
    _acceptedRequest = acceptedRequest;
    _rejectedRequest = rejectedRequest;
}

  Count.fromJson(dynamic json) {
    _id = json['_id'];
    _allRequest = json['all_request'];
    _pendingRequest = json['pending_request'];
    _acceptedRequest = json['accepted_request'];
    _rejectedRequest = json['rejected_request'];
  }
  String? _id;
  num? _allRequest;
  num? _pendingRequest;
  num? _acceptedRequest;
  num? _rejectedRequest;
Count copyWith({  String? id,
  num? allRequest,
  num? pendingRequest,
  num? acceptedRequest,
  num? rejectedRequest,
}) => Count(  id: id ?? _id,
  allRequest: allRequest ?? _allRequest,
  pendingRequest: pendingRequest ?? _pendingRequest,
  acceptedRequest: acceptedRequest ?? _acceptedRequest,
  rejectedRequest: rejectedRequest ?? _rejectedRequest,
);
  String? get id => _id;
  num? get allRequest => _allRequest;
  num? get pendingRequest => _pendingRequest;
  num? get acceptedRequest => _acceptedRequest;
  num? get rejectedRequest => _rejectedRequest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['all_request'] = _allRequest;
    map['pending_request'] = _pendingRequest;
    map['accepted_request'] = _acceptedRequest;
    map['rejected_request'] = _rejectedRequest;
    return map;
  }

}

class NotificationData {
  NotificationData({
      String? title, 
      String? description, 
      String? type, 
      num? status, 
      String? id, 
      String? dateor, 
      String? date,}){
    _title = title;
    _description = description;
    _type = type;
    _status = status;
    _id = id;
    _dateor = dateor;
    _date = date;
}

  NotificationData.fromJson(dynamic json) {
    _title = json['title'];
    _description = json['description'];
    _type = json['type'];
    _status = json['status'];
    _id = json['_id'];
    _dateor = json['dateor'];
    _date = json['date'];
  }
  String? _title;
  String? _description;
  String? _type;
  num? _status;
  String? _id;
  String? _dateor;
  String? _date;
  NotificationData copyWith({  String? title,
  String? description,
  String? type,
  num? status,
  String? id,
  String? dateor,
  String? date,
}) => NotificationData(  title: title ?? _title,
  description: description ?? _description,
  type: type ?? _type,
  status: status ?? _status,
  id: id ?? _id,
  dateor: dateor ?? _dateor,
  date: date ?? _date,
);
  String? get title => _title;
  String? get description => _description;
  String? get type => _type;
  num? get status => _status;
  String? get id => _id;
  String? get dateor => _dateor;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['description'] = _description;
    map['type'] = _type;
    map['status'] = _status;
    map['_id'] = _id;
    map['dateor'] = _dateor;
    map['date'] = _date;
    return map;
  }

}