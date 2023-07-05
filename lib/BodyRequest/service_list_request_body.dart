class ServiceListRequestBody {
  ServiceListRequestBody({
      String? serviceProviderId, 
      String? status, 
      num? lng, 
      num? lat,}){
    _serviceProviderId = serviceProviderId;
    _status = status;
    _lng = lng;
    _lat = lat;
}

  ServiceListRequestBody.fromJson(dynamic json) {
    _serviceProviderId = json['service_provider_id'];
    _status = json['status'];
    _lng = json['lng'];
    _lat = json['lat'];
  }
  String? _serviceProviderId;
  String? _status;
  num? _lng;
  num? _lat;
ServiceListRequestBody copyWith({  String? serviceProviderId,
  String? status,
  num? lng,
  num? lat,
}) => ServiceListRequestBody(  serviceProviderId: serviceProviderId ?? _serviceProviderId,
  status: status ?? _status,
  lng: lng ?? _lng,
  lat: lat ?? _lat,
);
  String? get serviceProviderId => _serviceProviderId;
  String? get status => _status;
  num? get lng => _lng;
  num? get lat => _lat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_provider_id'] = _serviceProviderId;
    map['status'] = _status;
    map['lng'] = _lng;
    map['lat'] = _lat;
    return map;
  }

}