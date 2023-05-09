class StartRideRequest {
  StartRideRequest({
      String? userId, 
      String? driverId, 
      String? date, 
      String? updown, 
      StartPoint? startPoint, 
      EndPoint? endPoint, 
      String? serviceId,}){
    _userId = userId;
    _driverId = driverId;
    _date = date;
    _updown = updown;
    _startPoint = startPoint;
    _endPoint = endPoint;
    _serviceId = serviceId;
}

  StartRideRequest.fromJson(dynamic json) {
    _userId = json['user_id'];
    _driverId = json['driver_id'];
    _date = json['date'];
    _updown = json['updown'];
    _startPoint = json['start_point'] != null ? StartPoint.fromJson(json['start_point']) : null;
    _endPoint = json['end_point'] != null ? EndPoint.fromJson(json['end_point']) : null;
    _serviceId = json['service_id'];
  }
  String? _userId;
  String? _driverId;
  String? _date;
  String? _updown;
  StartPoint? _startPoint;
  EndPoint? _endPoint;
  String? _serviceId;
StartRideRequest copyWith({  String? userId,
  String? driverId,
  String? date,
  String? updown,
  StartPoint? startPoint,
  EndPoint? endPoint,
  String? serviceId,
}) => StartRideRequest(  userId: userId ?? _userId,
  driverId: driverId ?? _driverId,
  date: date ?? _date,
  updown: updown ?? _updown,
  startPoint: startPoint ?? _startPoint,
  endPoint: endPoint ?? _endPoint,
  serviceId: serviceId ?? _serviceId,
);
  String? get userId => _userId;
  String? get driverId => _driverId;
  String? get date => _date;
  String? get updown => _updown;
  StartPoint? get startPoint => _startPoint;
  EndPoint? get endPoint => _endPoint;
  String? get serviceId => _serviceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['driver_id'] = _driverId;
    map['date'] = _date;
    map['updown'] = _updown;
    if (_startPoint != null) {
      map['start_point'] = _startPoint?.toJson();
    }
    if (_endPoint != null) {
      map['end_point'] = _endPoint?.toJson();
    }
    map['service_id'] = _serviceId;
    return map;
  }

}

class EndPoint {
  EndPoint({
      String? time, 
      num? latitude, 
      num? longitude, 
      String? location,}){
    _time = time;
    _latitude = latitude;
    _longitude = longitude;
    _location = location;
}

  EndPoint.fromJson(dynamic json) {
    _time = json['time'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _location = json['location'];
  }
  String? _time;
  num? _latitude;
  num? _longitude;
  String? _location;
EndPoint copyWith({  String? time,
  num? latitude,
  num? longitude,
  String? location,
}) => EndPoint(  time: time ?? _time,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  location: location ?? _location,
);
  String? get time => _time;
  num? get latitude => _latitude;
  num? get longitude => _longitude;
  String? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = _time;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['location'] = _location;
    return map;
  }

}

class StartPoint {
  StartPoint({
      String? time, 
      num? latitude, 
      num? longitude, 
      String? location,}){
    _time = time;
    _latitude = latitude;
    _longitude = longitude;
    _location = location;
}

  StartPoint.fromJson(dynamic json) {
    _time = json['time'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _location = json['location'];
  }
  String? _time;
  num? _latitude;
  num? _longitude;
  String? _location;
StartPoint copyWith({  String? time,
  num? latitude,
  num? longitude,
  String? location,
}) => StartPoint(  time: time ?? _time,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  location: location ?? _location,
);
  String? get time => _time;
  num? get latitude => _latitude;
  num? get longitude => _longitude;
  String? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = _time;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['location'] = _location;
    return map;
  }

}