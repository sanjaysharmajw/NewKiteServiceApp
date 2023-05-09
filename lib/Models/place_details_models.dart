/// status : true
/// result : [{"lat":19.06528,"lng":72.99548,"Label":"Limra Technosys, Shree Bhagwan Mahavir Marg, Sector 30, Vashi, Navi Mumbai 400703, India","Municipality":"Navi Mumbai","Neighborhood":"Vashi","PostalCode":"400703","Region":"Maharashtra","SubRegion":"Thane"}]

class PlaceDetailsModels {
  PlaceDetailsModels({
      bool? status, 
      List<Result>? result,}){
    _status = status;
    _result = result;
}

  PlaceDetailsModels.fromJson(dynamic json) {
    _status = json['status'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(Result.fromJson(v));
      });
    }
  }
  bool? _status;
  List<Result>? _result;
PlaceDetailsModels copyWith({  bool? status,
  List<Result>? result,
}) => PlaceDetailsModels(  status: status ?? _status,
  result: result ?? _result,
);
  bool? get status => _status;
  List<Result>? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// lat : 19.06528
/// lng : 72.99548
/// Label : "Limra Technosys, Shree Bhagwan Mahavir Marg, Sector 30, Vashi, Navi Mumbai 400703, India"
/// Municipality : "Navi Mumbai"
/// Neighborhood : "Vashi"
/// PostalCode : "400703"
/// Region : "Maharashtra"
/// SubRegion : "Thane"

class Result {
  Result({
      num? lat, 
      num? lng, 
      String? label, 
      String? municipality, 
      String? neighborhood, 
      String? postalCode, 
      String? region, 
      String? subRegion,}){
    _lat = lat;
    _lng = lng;
    _label = label;
    _municipality = municipality;
    _neighborhood = neighborhood;
    _postalCode = postalCode;
    _region = region;
    _subRegion = subRegion;
}

  Result.fromJson(dynamic json) {
    _lat = json['lat'];
    _lng = json['lng'];
    _label = json['Label'];
    _municipality = json['Municipality'];
    _neighborhood = json['Neighborhood'];
    _postalCode = json['PostalCode'];
    _region = json['Region'];
    _subRegion = json['SubRegion'];
  }
  num? _lat;
  num? _lng;
  String? _label;
  String? _municipality;
  String? _neighborhood;
  String? _postalCode;
  String? _region;
  String? _subRegion;
Result copyWith({  num? lat,
  num? lng,
  String? label,
  String? municipality,
  String? neighborhood,
  String? postalCode,
  String? region,
  String? subRegion,
}) => Result(  lat: lat ?? _lat,
  lng: lng ?? _lng,
  label: label ?? _label,
  municipality: municipality ?? _municipality,
  neighborhood: neighborhood ?? _neighborhood,
  postalCode: postalCode ?? _postalCode,
  region: region ?? _region,
  subRegion: subRegion ?? _subRegion,
);
  num? get lat => _lat;
  num? get lng => _lng;
  String? get label => _label;
  String? get municipality => _municipality;
  String? get neighborhood => _neighborhood;
  String? get postalCode => _postalCode;
  String? get region => _region;
  String? get subRegion => _subRegion;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['Label'] = _label;
    map['Municipality'] = _municipality;
    map['Neighborhood'] = _neighborhood;
    map['PostalCode'] = _postalCode;
    map['Region'] = _region;
    map['SubRegion'] = _subRegion;
    return map;
  }

}