// To parse this JSON data, do
//
//     final catModel = catModelFromJson(jsonString);

import 'dart:convert';

List<CatModel> catModelFromJson(String str) => List<CatModel>.from(json.decode(str).map((x) => CatModel.fromJson(x)));

String catModelToJson(List<CatModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CatModel {
  CatModel({
    this.id,
    this.categoryName,
    this.categoryImage,
  });

  String id;
  String categoryName;
  String categoryImage;

  factory CatModel.fromJson(Map<String, dynamic> json) => CatModel(
    id: json["id"],
    categoryName: json["category_name"],
    categoryImage: json["category_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "category_image": categoryImage,
  };
}
