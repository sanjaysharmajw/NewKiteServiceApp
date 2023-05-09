class NotificationRequestBody {
  NotificationRequestBody({
      bool? count, 
      bool? unread, 
      String? userId,}){
    _count = count;
    _unread = unread;
    _userId = userId;
}

  NotificationRequestBody.fromJson(dynamic json) {
    _count = json['count'];
    _unread = json['unread'];
    _userId = json['user_id'];
  }
  bool? _count;
  bool? _unread;
  String? _userId;
NotificationRequestBody copyWith({  bool? count,
  bool? unread,
  String? userId,
}) => NotificationRequestBody(  count: count ?? _count,
  unread: unread ?? _unread,
  userId: userId ?? _userId,
);
  bool? get count => _count;
  bool? get unread => _unread;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    map['unread'] = _unread;
    map['user_id'] = _userId;
    return map;
  }

}