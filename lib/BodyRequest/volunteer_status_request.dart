class VolunteerStatusRequest {
  VolunteerStatusRequest({
      String? userId, 
      String? volunteer, 
      List<String>? volunteerAri,}){
    _userId = userId;
    _volunteer = volunteer;
    _volunteerAri = volunteerAri;
}

  VolunteerStatusRequest.fromJson(dynamic json) {
    _userId = json['user_id'];
    _volunteer = json['volunteer'];
    _volunteerAri = json['volunteer_ari'] != null ? json['volunteer_ari'].cast<String>() : [];
  }
  String? _userId;
  String? _volunteer;
  List<String>? _volunteerAri;
VolunteerStatusRequest copyWith({  String? userId,
  String? volunteer,
  List<String>? volunteerAri,
}) => VolunteerStatusRequest(  userId: userId ?? _userId,
  volunteer: volunteer ?? _volunteer,
  volunteerAri: volunteerAri ?? _volunteerAri,
);
  String? get userId => _userId;
  String? get volunteer => _volunteer;
  List<String>? get volunteerAri => _volunteerAri;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['volunteer'] = _volunteer;
    map['volunteer_ari'] = _volunteerAri;
    return map;
  }

}