import 'dart:convert';

class SubCategoryModel {
  int id;
  String name;
  String description;
  String imageUrl;
  int categoryId;
  String categoryName;

  SubCategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.categoryId,
    required this.categoryName,
  });

  SubCategoryModel copyWith({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    int? categoryId,
    String? categoryName,
  }) => SubCategoryModel(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    imageUrl: imageUrl ?? this.imageUrl,
    categoryId: categoryId ?? this.categoryId,
    categoryName: categoryName ?? this.categoryName,
  );

  factory SubCategoryModel.fromRawJson(String str) => SubCategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
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
