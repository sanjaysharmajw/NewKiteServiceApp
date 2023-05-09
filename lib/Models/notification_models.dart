class NotificationModels {
  NotificationModels({
      bool? status, 
      num? data, 
      Count? count,}){
    _status = status;
    _data = data;
    _count = count;
}

  NotificationModels.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'];
    _count = json['count'] != null ? Count.fromJson(json['count']) : null;
  }
  bool? _status;
  num? _data;
  Count? _count;
NotificationModels copyWith({  bool? status,
  num? data,
  Count? count,
}) => NotificationModels(  status: status ?? _status,
  data: data ?? _data,
  count: count ?? _count,
);
  bool? get status => _status;
  num? get data => _data;
  Count? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['data'] = _data;
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