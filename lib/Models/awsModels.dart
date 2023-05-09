/// status : true
/// data : "https://travelsafe-docs.s3.ap-south-1.amazonaws.com//test/image1.jpg?Content-Type=img%2Fjpeg&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJIMWZNR6OPKSSMCQ%2F20230303%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20230303T090654Z&X-Amz-Expires=3600&X-Amz-Signature=9a99b7dcf4a6ce37ff3e23c8ae923937e2b6fef2d530076fa8a1d1cf28c1e178&X-Amz-SignedHeaders=host"

class AwsModels {
  AwsModels({
      bool? status, 
      String? data,}){
    _status = status;
    _data = data;
}

  AwsModels.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'];
  }
  bool? _status;
  String? _data;
AwsModels copyWith({  bool? status,
  String? data,
}) => AwsModels(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['data'] = _data;
    return map;
  }

}