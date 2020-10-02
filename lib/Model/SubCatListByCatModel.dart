// To parse this JSON data, do
//
//     final subCatListByCat = subCatListByCatFromJson(jsonString);

import 'dart:convert';

List<SubCatListByCat> subCatListByCatFromJson(String str) => List<SubCatListByCat>.from(json.decode(str).map((x) => SubCatListByCat.fromJson(x)));

String subCatListByCatToJson(List<SubCatListByCat> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCatListByCat {
  SubCatListByCat({
    this.id,
    this.categoryId,
    this.subCategoryName,
    this.image,
  });

  String id;
  String categoryId;
  String subCategoryName;
  String image;

  factory SubCatListByCat.fromJson(Map<String, dynamic> json) => SubCatListByCat(
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
