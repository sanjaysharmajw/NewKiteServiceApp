class StartRideModesl {
  StartRideModesl({
      bool? status, 
      String? message, 
      String? data, 
      num? rideStartOtp, 
      String? sockettoken,}){
    _status = status;
    _message = message;
    _data = data;
    _rideStartOtp = rideStartOtp;
    _sockettoken = sockettoken;
}

  StartRideModesl.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'];
    _rideStartOtp = json['ride_start_otp'];
    _sockettoken = json['sockettoken'];
  }
  bool? _status;
  String? _message;
  String? _data;
  num? _rideStartOtp;
  String? _sockettoken;
StartRideModesl copyWith({  bool? status,
  String? message,
  String? data,
  num? rideStartOtp,
  String? sockettoken,
}) => StartRideModesl(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
  rideStartOtp: rideStartOtp ?? _rideStartOtp,
  sockettoken: sockettoken ?? _sockettoken,
);
  bool? get status => _status;
  String? get message => _message;
  String? get data => _data;
  num? get rideStartOtp => _rideStartOtp;
  String? get sockettoken => _sockettoken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['data'] = _data;
    map['ride_start_otp'] = _rideStartOtp;
    map['sockettoken'] = _sockettoken;
    return map;
  }

}