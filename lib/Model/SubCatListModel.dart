// To parse this JSON data, do
//
//     final subCatList = subCatListFromJson(jsonString);

import 'dart:convert';

List<SubCatList> subCatListFromJson(String str) => List<SubCatList>.from(json.decode(str).map((x) => SubCatList.fromJson(x)));

String subCatListToJson(List<SubCatList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCatList {
  SubCatList({
    this.id,
    this.categoryId,
    this.subCategoryName,
    this.image,
  });

  String id;
  String categoryId;
  String subCategoryName;
  String image;

  factory SubCatList.fromJson(Map<String, dynamic> json) => SubCatList(
    id: json["id"],
    categoryId: json["category_id"],
    subCategoryName: json["subCategory_name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "subCategory_name": subCategoryName,
    "image": image,
  };
}
