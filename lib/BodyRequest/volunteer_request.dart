class  VolunteerRequest {
  VolunteerRequest({
      String? userId, 
      String? volunteer,}){
    _userId = userId;
    _volunteer = volunteer;
}

  VolunteerRequest.fromJson(dynamic json) {
    _userId = json['user_id'];
    _volunteer = json['volunteer'];
  }
  String? _userId;
  String? _volunteer;
VolunteerRequest copyWith({  String? userId,
  String? volunteer,
}) => VolunteerRequest(  userId: userId ?? _userId,
  volunteer: volunteer ?? _volunteer,
);
  String? get userId => _userId;
  String? get volunteer => _volunteer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['volunteer'] = _volunteer;
    return map;
  }

}