import 'dart:convert';

SearchLocationModel resultFromJson(String str) => SearchLocationModel.fromJson(json.decode(str));
String resultToJson(SearchLocationModel data) => json.encode(data.toJson());
class SearchLocationModel {
  SearchLocationModel({
    this.placeId,
    this.text,});

  SearchLocationModel.fromJson(dynamic json) {
    placeId = json['PlaceId'];
    text = json['Text'];
  }
  String? placeId;
  String? text;
  SearchLocationModel copyWith({  String? placeId,
    String? text,
  }) => SearchLocationModel(  placeId: placeId ?? this.placeId,
    text: text ?? this.text,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PlaceId'] = placeId;
    map['Text'] = text;
    return map;
  }

}