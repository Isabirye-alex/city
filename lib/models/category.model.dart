import 'dart:convert';

class Welcome {
  int id;
  String name;
  String imageUrl;
  DateTime createdAt;
  DateTime updatedAt;

  Welcome({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  Welcome copyWith({
    int? id,
    String? name,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Welcome(
    id: id ?? this.id,
    name: name ?? this.name,
    imageUrl: imageUrl ?? this.imageUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Welcome.fromRawJson(String str) => Welcome.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    id: json["id"],
    name: json["name"],
    imageUrl: json["imageUrl"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "imageUrl": imageUrl,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
