class ServiceListBodyRequest {
  ServiceListBodyRequest({
      String? userId, 
      num? lat, 
      num? lng, 
      String? id, 
      String? serviceId,}){
    _userId = userId;
    _lat = lat;
    _lng = lng;
    _id = id;
    _serviceId = serviceId;
}

  ServiceListBodyRequest.fromJson(dynamic json) {
    _userId = json['user_id'];
    _lat = json['lat'];
    _lng = json['lng'];
    _id = json['id'];
    _serviceId = json['service_id'];
  }
  String? _userId;
  num? _lat;
  num? _lng;
  String? _id;
  String? _serviceId;
ServiceListBodyRequest copyWith({  String? userId,
  num? lat,
  num? lng,
  String? id,
  String? serviceId,
}) => ServiceListBodyRequest(  userId: userId ?? _userId,
  lat: lat ?? _lat,
  lng: lng ?? _lng,
  id: id ?? _id,
  serviceId: serviceId ?? _serviceId,
);
  String? get userId => _userId;
  num? get lat => _lat;
  num? get lng => _lng;
  String? get id => _id;
  String? get serviceId => _serviceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['id'] = _id;
    map['service_id'] = _serviceId;
    return map;
  }

}