// To parse this JSON data, do
//
//     final itemList = itemListFromJson(jsonString);

import 'dart:convert';

List<ItemList> itemListFromJson(String str) => List<ItemList>.from(json.decode(str).map((x) => ItemList.fromJson(x)));

String itemListToJson(List<ItemList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemList {
  ItemList({
    this.id,
    this.resId,
    this.proId,
    this.proName,
    this.pQuantity,
    this.price,
    this.discount,
    this.tPrice,
    this.pType,
    this.pImg,
  });

  int id;
  int resId;
  int proId;
  String proName;
  int pQuantity;
  int price;
  int discount;
  int tPrice;
  String pType;
  String pImg;

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
    id: json["_id"],
    resId: json["res_id"],
    proId: json["pro_id"],
    proName: json["pro_name"],
    pQuantity: json["p_quantity"],
    price: json["price"],
    discount: json["discount"],
    tPrice: json["tPrice"],
    pType: json["pType"],
    pImg: json["pImg"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "res_id": resId,
    "pro_id": proId,
    "pro_name": proName,
    "p_quantity": pQuantity,
    "price": price,
    "discount": discount,
    "tPrice": tPrice,
    "pType": pType,
    "pImg": pImg,
  };
}
