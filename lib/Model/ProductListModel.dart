// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.id,
    this.name,
    this.productType,
    this.subCategoryId,
    this.restaurantId,
    this.image,
    this.description,
    this.foodType,
    this.size,
    this.medicineMgMl,
    this.medicineCompany,
    this.purchasePrice,
    this.price,
    this.discountPrice,
    this.discountPercent,
    this.availability,
    this.openingTime,
    this.closingTime,
    this.subCategoryName,
  });

  String id;
  String name;
  String productType;
  String subCategoryId;
  String restaurantId;
  String image;
  String description;
  String foodType;
  String size;
  String medicineMgMl;
  String medicineCompany;
  String purchasePrice;
  String price;
  String discountPrice;
  String discountPercent;
  String availability;
  String openingTime;
  String closingTime;
  String subCategoryName;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    productType: json["product_type"],
    subCategoryId: json["subCategory_id"],
    restaurantId: json["restaurant_id"],
    image: json["image"],
    description: json["description"],
    foodType: json["food_type"],
    size: json["size"],
    medicineMgMl: json["medicine_mg_ml"],
    medicineCompany: json["medicine_company"],
    purchasePrice: json["purchasePrice"],
    price: json["price"],
    discountPrice: json["discount_price"],
    discountPercent: json["discount_percent"],
    availability: json["availability"],
    openingTime: json["opening_time"],
    closingTime: json["closing_time"],
    subCategoryName: json["subCategory_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "product_type": productType,
    "subCategory_id": subCategoryId,
    "restaurant_id": restaurantId,
    "image": image,
    "description": description,
    "food_type": foodType,
    "size": size,
    "medicine_mg_ml": medicineMgMl,
    "medicine_company": medicineCompany,
    "purchasePrice": purchasePrice,
    "price": price,
    "discount_price": discountPrice,
    "discount_percent": discountPercent,
    "availability": availability,
    "opening_time": openingTime,
    "closing_time": closingTime,
    "subCategory_name": subCategoryName,
  };
}
