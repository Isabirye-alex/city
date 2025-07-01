import 'dart:convert';

class Welcome {
  int id;
  String name;
  String description;
  String imageUrl;
  int categoryId;
  String categoryName;

  Welcome({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.categoryId,
    required this.categoryName,
  });

  Welcome copyWith({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    int? categoryId,
    String? categoryName,
  }) => Welcome(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    imageUrl: imageUrl ?? this.imageUrl,
    categoryId: categoryId ?? this.categoryId,
    categoryName: categoryName ?? this.categoryName,
  );

  factory Welcome.fromRawJson(String str) => Welcome.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    categoryId: json["category_id"],
    categoryName: json["categoryName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "imageUrl": imageUrl,
    "category_id": categoryId,
    "categoryName": categoryName,
  };
}
