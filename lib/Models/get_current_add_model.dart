/// status : true
/// result : [{"Distance":6.66926904029298,"Place":{"Country":"IND","Geometry":{"Point":[72.99548,19.06528]},"Interpolated":false,"Label":"Limra Technosys, Shree Bhagwan Mahavir Marg, Sector 30, Vashi, Navi Mumbai 400703, India","Municipality":"Navi Mumbai","Neighborhood":"Vashi","PostalCode":"400703","Region":"Maharashtra","Street":"Shree Bhagwan Mahavir Marg","SubRegion":"Thane","TimeZone":{"Name":"Asia/Kolkata","Offset":19800}},"PlaceId":"AQAAAHEAYvXto2Cd56eVsMogX0WV5THoDw4SQAbm2bD-RYjO26MPXJUzmkSAvbdfGCu9d-J-JYja1xX2tIJs-pL4WHdhZsTCVtUz52HCOh8pFkQeDu-ACuT9efPEaUhtrqulR7znvZRTP82wHo6XOoYMCtJC0IdNlRTCPj1hf4IJMiw-kHItfMrh1NGlqxxbG_WdEJFMdg"}]

class GetCurrentAddModel {
  GetCurrentAddModel({
      bool? status, 
      List<Result>? result,}){
    _status = status;
    _result = result;
}

  GetCurrentAddModel.fromJson(dynamic json) {
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
GetCurrentAddModel copyWith({  bool? status,
  List<Result>? result,
}) => GetCurrentAddModel(  status: status ?? _status,
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

/// Distance : 6.66926904029298
/// Place : {"Country":"IND","Geometry":{"Point":[72.99548,19.06528]},"Interpolated":false,"Label":"Limra Technosys, Shree Bhagwan Mahavir Marg, Sector 30, Vashi, Navi Mumbai 400703, India","Municipality":"Navi Mumbai","Neighborhood":"Vashi","PostalCode":"400703","Region":"Maharashtra","Street":"Shree Bhagwan Mahavir Marg","SubRegion":"Thane","TimeZone":{"Name":"Asia/Kolkata","Offset":19800}}
/// PlaceId : "AQAAAHEAYvXto2Cd56eVsMogX0WV5THoDw4SQAbm2bD-RYjO26MPXJUzmkSAvbdfGCu9d-J-JYja1xX2tIJs-pL4WHdhZsTCVtUz52HCOh8pFkQeDu-ACuT9efPEaUhtrqulR7znvZRTP82wHo6XOoYMCtJC0IdNlRTCPj1hf4IJMiw-kHItfMrh1NGlqxxbG_WdEJFMdg"

class Result {
  Result({
      num? distance, 
      Place? place, 
      String? placeId,}){
    _distance = distance;
    _place = place;
    _placeId = placeId;
}

  Result.fromJson(dynamic json) {
    _distance = json['Distance'];
    _place = json['Place'] != null ? Place.fromJson(json['Place']) : null;
    _placeId = json['PlaceId'];
  }
  num? _distance;
  Place? _place;
  String? _placeId;
Result copyWith({  num? distance,
  Place? place,
  String? placeId,
}) => Result(  distance: distance ?? _distance,
  place: place ?? _place,
  placeId: placeId ?? _placeId,
);
  num? get distance => _distance;
  Place? get place => _place;
  String? get placeId => _placeId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Distance'] = _distance;
    if (_place != null) {
      map['Place'] = _place?.toJson();
    }
    map['PlaceId'] = _placeId;
    return map;
  }

}

/// Country : "IND"
/// Geometry : {"Point":[72.99548,19.06528]}
/// Interpolated : false
/// Label : "Limra Technosys, Shree Bhagwan Mahavir Marg, Sector 30, Vashi, Navi Mumbai 400703, India"
/// Municipality : "Navi Mumbai"
/// Neighborhood : "Vashi"
/// PostalCode : "400703"
/// Region : "Maharashtra"
/// Street : "Shree Bhagwan Mahavir Marg"
/// SubRegion : "Thane"
/// TimeZone : {"Name":"Asia/Kolkata","Offset":19800}

class Place {
  Place({
      String? country, 
      Geometry? geometry, 
      bool? interpolated, 
      String? label, 
      String? municipality, 
      String? neighborhood, 
      String? postalCode, 
      String? region, 
      String? street, 
      String? subRegion, 
      TimeZone? timeZone,}){
    _country = country;
    _geometry = geometry;
    _interpolated = interpolated;
    _label = label;
    _municipality = municipality;
    _neighborhood = neighborhood;
    _postalCode = postalCode;
    _region = region;
    _street = street;
    _subRegion = subRegion;
    _timeZone = timeZone;
}

  Place.fromJson(dynamic json) {
    _country = json['Country'];
    _geometry = json['Geometry'] != null ? Geometry.fromJson(json['Geometry']) : null;
    _interpolated = json['Interpolated'];
    _label = json['Label'];
    _municipality = json['Municipality'];
    _neighborhood = json['Neighborhood'];
    _postalCode = json['PostalCode'];
    _region = json['Region'];
    _street = json['Street'];
    _subRegion = json['SubRegion'];
    _timeZone = json['TimeZone'] != null ? TimeZone.fromJson(json['TimeZone']) : null;
  }
  String? _country;
  Geometry? _geometry;
  bool? _interpolated;
  String? _label;
  String? _municipality;
  String? _neighborhood;
  String? _postalCode;
  String? _region;
  String? _street;
  String? _subRegion;
  TimeZone? _timeZone;
Place copyWith({  String? country,
  Geometry? geometry,
  bool? interpolated,
  String? label,
  String? municipality,
  String? neighborhood,
  String? postalCode,
  String? region,
  String? street,
  String? subRegion,
  TimeZone? timeZone,
}) => Place(  country: country ?? _country,
  geometry: geometry ?? _geometry,
  interpolated: interpolated ?? _interpolated,
  label: label ?? _label,
  municipality: municipality ?? _municipality,
  neighborhood: neighborhood ?? _neighborhood,
  postalCode: postalCode ?? _postalCode,
  region: region ?? _region,
  street: street ?? _street,
  subRegion: subRegion ?? _subRegion,
  timeZone: timeZone ?? _timeZone,
);
  String? get country => _country;
  Geometry? get geometry => _geometry;
  bool? get interpolated => _interpolated;
  String? get label => _label;
  String? get municipality => _municipality;
  String? get neighborhood => _neighborhood;
  String? get postalCode => _postalCode;
  String? get region => _region;
  String? get street => _street;
  String? get subRegion => _subRegion;
  TimeZone? get timeZone => _timeZone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Country'] = _country;
    if (_geometry != null) {
      map['Geometry'] = _geometry?.toJson();
    }
    map['Interpolated'] = _interpolated;
    map['Label'] = _label;
    map['Municipality'] = _municipality;
    map['Neighborhood'] = _neighborhood;
    map['PostalCode'] = _postalCode;
    map['Region'] = _region;
    map['Street'] = _street;
    map['SubRegion'] = _subRegion;
    if (_timeZone != null) {
      map['TimeZone'] = _timeZone?.toJson();
    }
    return map;
  }

}

/// Name : "Asia/Kolkata"
/// Offset : 19800

class TimeZone {
  TimeZone({
      String? name, 
      num? offset,}){
    _name = name;
    _offset = offset;
}

  TimeZone.fromJson(dynamic json) {
    _name = json['Name'];
    _offset = json['Offset'];
  }
  String? _name;
  num? _offset;
TimeZone copyWith({  String? name,
  num? offset,
}) => TimeZone(  name: name ?? _name,
  offset: offset ?? _offset,
);
  String? get name => _name;
  num? get offset => _offset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Name'] = _name;
    map['Offset'] = _offset;
    return map;
  }

}

/// Point : [72.99548,19.06528]

class Geometry {
  Geometry({
      List<num>? point,}){
    _point = point;
}

  Geometry.fromJson(dynamic json) {
    _point = json['Point'] != null ? json['Point'].cast<num>() : [];
  }
  List<num>? _point;
Geometry copyWith({  List<num>? point,
}) => Geometry(  point: point ?? _point,
);
  List<num>? get point => _point;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Point'] = _point;
    return map;
  }

}