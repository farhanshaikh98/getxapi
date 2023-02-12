// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
  });

  List<Datum> data;
  int total;
  int page;
  int limit;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        total: json["total"],
        page: json["page"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "total": total,
        "page": page,
        "limit": limit,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.picture,
  });

  String id;
  Title title;
  String firstName;
  String lastName;
  String picture;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: titleValues.map[json["title"]]!,
        firstName: json["firstName"],
        lastName: json["lastName"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": titleValues.reverse[title],
        "firstName": firstName,
        "lastName": lastName,
        "picture": picture,
      };
}

enum Title { MS, MISS, MR, MRS }

final titleValues = EnumValues(
    {"miss": Title.MISS, "mr": Title.MR, "mrs": Title.MRS, "ms": Title.MS});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
