// To parse this JSON data, do
//
//     final orderList = orderListFromJson(jsonString);

import 'dart:convert';

OrderList orderListFromJson(String str) => OrderList.fromJson(json.decode(str));

String orderListToJson(OrderList data) => json.encode(data.toJson());

class OrderList {
  OrderList({
    this.placed,
    this.processing,
    this.pickup,
    this.delivered,
  });

  List<Delivered> placed;
  dynamic processing;
  dynamic pickup;
  List<Delivered> delivered;

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
    placed:json["placed"] == null ?  List<Delivered>.from(json["placed"].map((x) => Delivered.fromJson(x))) :json["placed"] ,
    processing: json["processing"]  == null ?  List<Delivered>.from(json["processing"].map((x) => Delivered.fromJson(x))) :json["processing"] ,
    pickup: json["pickup"] == null ?  List<Delivered>.from(json["pickup"].map((x) => Delivered.fromJson(x))) :json["pickup"] ,
    delivered:json["delivered"] == null ? List<Delivered>.from(json["delivered"].map((x) => Delivered.fromJson(x))) : json["delivered"],
  );

  Map<String, dynamic> toJson() => {
    "placed": List<dynamic>.from(placed.map((x) => x.toJson())),
    "processing": List<dynamic>.from(processing.map((x) => x.toJson())),
    "pickup":  List<dynamic>.from(pickup.map((x) => x.toJson())),
    "delivered": List<dynamic>.from(delivered.map((x) => x.toJson())),
  };
}

class Delivered {
  Delivered({
    this.id,
    this.customerId,
    this.orderdetails,
    this.prescriptionDetails,
    this.shipingInfo,
    this.dateTime,
    this.discount,
    this.subTotal,
    this.totalBill,
    this.deliveryCharge,
    this.status,
    this.takeBy,
    this.paymentType,
    this.latVal,
    this.langVal,
    this.invoiceId,
    this.restaurantId,
    this.productId,
    this.qty,
    this.price,
    this.totalAmount,
    this.userName,
    this.image,
    this.address1,
    this.address2,
    this.phone,
    this.Total_Amount
  });

  String id;
  String customerId;
  String orderdetails;
  String prescriptionDetails;
  String shipingInfo;
  DateTime dateTime;
  String discount;
  String subTotal;
  String totalBill;
  String deliveryCharge;
  String status;
  dynamic takeBy;
  String paymentType;
  dynamic latVal;
  dynamic langVal;
  String invoiceId;
  String restaurantId;
  String productId;
  String qty;
  String price;
  String totalAmount;
  String userName;
  dynamic image;
  dynamic address1;
  dynamic address2;
  String phone;
  String Total_Amount;

  factory Delivered.fromJson(Map<String, dynamic> json) => Delivered(
    id: json["id"],
    customerId: json["customer_id"],
    orderdetails: json["orderdetails"],
    prescriptionDetails: json["prescriptionDetails"],
    shipingInfo: json["shiping_info"],
    dateTime: DateTime.parse(json["date_time"]),
    discount: json["discount"],
    subTotal: json["subTotal"],
    totalBill: json["total_bill"],
    deliveryCharge: json["delivery_charge"],
    status: json["status"],
    takeBy: json["take_by"],
    paymentType: json["payment_type"],
    latVal: json["lat_val"],
    langVal: json["lang_val"],
    invoiceId: json["invoice_id"],
    restaurantId: json["restaurant_id"],
    productId: json["product_id"],
    qty: json["qty"],
    price: json["price"],
    totalAmount: json["total_amount"],
    userName: json["user_name"],
    image: json["image"],
    address1: json["address1"],
    address2: json["address2"],
    phone: json["phone"],
    Total_Amount: json["TotalAmount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "orderdetails": orderdetails,
    "prescriptionDetails": prescriptionDetails,
    "shiping_info": shipingInfo,
    "date_time": dateTime.toIso8601String(),
    "discount": discount,
    "subTotal": subTotal,
    "total_bill": totalBill,
    "delivery_charge": deliveryCharge,
    "status": status,
    "take_by": takeBy,
    "payment_type": paymentType,
    "lat_val": latVal,
    "lang_val": langVal,
    "invoice_id": invoiceId,
    "restaurant_id": restaurantId,
    "product_id": productId,
    "qty": qty,
    "price": price,
    "total_amount": totalAmount,
    "user_name": userName,
    "image": image,
    "address1": address1,
    "address2": address2,
    "phone": phone,
    "TotalAmount":Total_Amount,

  };
}
