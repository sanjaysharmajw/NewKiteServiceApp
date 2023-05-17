class VideoAttendRequest {
  VideoAttendRequest({
      String? userId, 
      String? videoId,}){
    _userId = userId;
    _videoId = videoId;
}

  VideoAttendRequest.fromJson(dynamic json) {
    _userId = json['user_id'];
    _videoId = json['video_id'];
  }
  String? _userId;
  String? _videoId;
VideoAttendRequest copyWith({  String? userId,
  String? videoId,
}) => VideoAttendRequest(  userId: userId ?? _userId,
  videoId: videoId ?? _videoId,
);
  String? get userId => _userId;
  String? get videoId => _videoId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['video_id'] = _videoId;
    return map;
  }

}