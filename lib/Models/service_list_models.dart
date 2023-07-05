class ServiceListModels {
  ServiceListModels({
      bool? status, 
      List<ServiceListData>? data,}){
    _status = status;
    _data = data;
}

  ServiceListModels.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ServiceListData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<ServiceListData>? _data;
ServiceListModels copyWith({  bool? status,
  List<ServiceListData>? data,
}) => ServiceListModels(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<ServiceListData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ServiceListData {
  ServiceListData({
      String? serviceId, 
      String? serviceProviderId, 
      String? rating, 
      String? userId, 
      String? customerStatus, 
      String? id, 
      num? dist, 
      String? date, 
      String? comments, 
      String? serviceStatus, 
      String? feedback, 
      num? userlng, 
      num? userlat, 
      String? username, 
      String? usermobilenumber, 
      String? userprofileimage, 
      num? statusOrder, 
      String? providername, 
      String? providermobilenumber, 
      dynamic providerprofileimage, 
      String? servicetype,}){
    _serviceId = serviceId;
    _serviceProviderId = serviceProviderId;
    _rating = rating;
    _userId = userId;
    _customerStatus = customerStatus;
    _id = id;
    _dist = dist;
    _date = date;
    _comments = comments;
    _serviceStatus = serviceStatus;
    _feedback = feedback;
    _userlng = userlng;
    _userlat = userlat;
    _username = username;
    _usermobilenumber = usermobilenumber;
    _userprofileimage = userprofileimage;
    _statusOrder = statusOrder;
    _providername = providername;
    _providermobilenumber = providermobilenumber;
    _providerprofileimage = providerprofileimage;
    _servicetype = servicetype;
}

  ServiceListData.fromJson(dynamic json) {
    _serviceId = json['service_id'];
    _serviceProviderId = json['service_provider_id'];
    _rating = json['rating'];
    _userId = json['user_id'];
    _customerStatus = json['customer_status'];
    _id = json['_id'];
    _dist = json['dist'];
    _date = json['date'];
    _comments = json['comments'];
    _serviceStatus = json['service_status'];
    _feedback = json['feedback'];
    _userlng = json['userlng'];
    _userlat = json['userlat'];
    _username = json['username'];
    _usermobilenumber = json['usermobilenumber'];
    _userprofileimage = json['userprofileimage'];
    _statusOrder = json['status_order'];
    _providername = json['providername'];
    _providermobilenumber = json['providermobilenumber'];
    _providerprofileimage = json['providerprofileimage'];
    _servicetype = json['servicetype'];
  }
  String? _serviceId;
  String? _serviceProviderId;
  String? _rating;
  String? _userId;
  String? _customerStatus;
  String? _id;
  num? _dist;
  String? _date;
  String? _comments;
  String? _serviceStatus;
  String? _feedback;
  num? _userlng;
  num? _userlat;
  String? _username;
  String? _usermobilenumber;
  String? _userprofileimage;
  num? _statusOrder;
  String? _providername;
  String? _providermobilenumber;
  dynamic _providerprofileimage;
  String? _servicetype;
  ServiceListData copyWith({  String? serviceId,
  String? serviceProviderId,
  String? rating,
  String? userId,
  String? customerStatus,
  String? id,
  num? dist,
  String? date,
  String? comments,
  String? serviceStatus,
  String? feedback,
  num? userlng,
  num? userlat,
  String? username,
  String? usermobilenumber,
  String? userprofileimage,
  num? statusOrder,
  String? providername,
  String? providermobilenumber,
  dynamic providerprofileimage,
  String? servicetype,
}) => ServiceListData(  serviceId: serviceId ?? _serviceId,
  serviceProviderId: serviceProviderId ?? _serviceProviderId,
  rating: rating ?? _rating,
  userId: userId ?? _userId,
  customerStatus: customerStatus ?? _customerStatus,
  id: id ?? _id,
  dist: dist ?? _dist,
  date: date ?? _date,
  comments: comments ?? _comments,
  serviceStatus: serviceStatus ?? _serviceStatus,
  feedback: feedback ?? _feedback,
  userlng: userlng ?? _userlng,
  userlat: userlat ?? _userlat,
  username: username ?? _username,
  usermobilenumber: usermobilenumber ?? _usermobilenumber,
  userprofileimage: userprofileimage ?? _userprofileimage,
  statusOrder: statusOrder ?? _statusOrder,
  providername: providername ?? _providername,
  providermobilenumber: providermobilenumber ?? _providermobilenumber,
  providerprofileimage: providerprofileimage ?? _providerprofileimage,
  servicetype: servicetype ?? _servicetype,
);
  String? get serviceId => _serviceId;
  String? get serviceProviderId => _serviceProviderId;
  String? get rating => _rating;
  String? get userId => _userId;
  String? get customerStatus => _customerStatus;
  String? get id => _id;
  num? get dist => _dist;
  String? get date => _date;
  String? get comments => _comments;
  String? get serviceStatus => _serviceStatus;
  String? get feedback => _feedback;
  num? get userlng => _userlng;
  num? get userlat => _userlat;
  String? get username => _username;
  String? get usermobilenumber => _usermobilenumber;
  String? get userprofileimage => _userprofileimage;
  num? get statusOrder => _statusOrder;
  String? get providername => _providername;
  String? get providermobilenumber => _providermobilenumber;
  dynamic get providerprofileimage => _providerprofileimage;
  String? get servicetype => _servicetype;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_id'] = _serviceId;
    map['service_provider_id'] = _serviceProviderId;
    map['rating'] = _rating;
    map['user_id'] = _userId;
    map['customer_status'] = _customerStatus;
    map['_id'] = _id;
    map['dist'] = _dist;
    map['date'] = _date;
    map['comments'] = _comments;
    map['service_status'] = _serviceStatus;
    map['feedback'] = _feedback;
    map['userlng'] = _userlng;
    map['userlat'] = _userlat;
    map['username'] = _username;
    map['usermobilenumber'] = _usermobilenumber;
    map['userprofileimage'] = _userprofileimage;
    map['status_order'] = _statusOrder;
    map['providername'] = _providername;
    map['providermobilenumber'] = _providermobilenumber;
    map['providerprofileimage'] = _providerprofileimage;
    map['servicetype'] = _servicetype;
    return map;
  }

}