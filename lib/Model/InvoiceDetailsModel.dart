// To parse this JSON data, do
//
//     final invoiceDetails = invoiceDetailsFromJson(jsonString);

import 'dart:convert';

InvoiceDetails invoiceDetailsFromJson(String str) => InvoiceDetails.fromJson(json.decode(str));

String invoiceDetailsToJson(InvoiceDetails data) => json.encode(data.toJson());

class InvoiceDetails {
  InvoiceDetails({
    this.orders,
    this.priceTotal,
  });

  List<Order> orders;
  int priceTotal;

  factory InvoiceDetails.fromJson(Map<String, dynamic> json) => InvoiceDetails(
    orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
    priceTotal: json["priceTotal"],
  );

  Map<String, dynamic> toJson() => {
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
    "priceTotal": priceTotal,
  };
}

class Order {
  Order({
    this.userName,
    this.image,
    this.address1,
    this.address2,
    this.phone,
    this.name,
    this.purchasePrice,
    this.price,
    this.size,
    this.id,
    this.customerId,
    this.orderdetails,
    this.prescriptionDetails,
    this.shipingInfo,
    this.dateTime,
    this.discount,
    this.totalBill,
    this.deliveryCharge,
    this.status,
    this.paymentType,
    this.invoiceItemId,
    this.invoiceId,
    this.restaurantId,
    this.productId,
    this.qty,
    this.totalAmount,
  });

  String userName;
  String image;
  dynamic address1;
  dynamic address2;
  String phone;
  String name;
  String purchasePrice;
  String price;
  String size;
  String id;
  String customerId;
  String orderdetails;
  String prescriptionDetails;
  String shipingInfo;
  DateTime dateTime;
  String discount;
  String totalBill;
  String deliveryCharge;
  String status;
  String paymentType;
  String invoiceItemId;
  String invoiceId;
  String restaurantId;
  String productId;
  String qty;
  String totalAmount;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    userName: json["user_name"],
    image: json["image"],
    address1: json["address1"],
    address2: json["address2"],
    phone: json["phone"],
    name: json["name"],
    purchasePrice: json["purchasePrice"],
    price: json["price"],
    size: json["size"],
    id: json["id"],
    customerId: json["customer_id"],
    orderdetails: json["orderdetails"],
    prescriptionDetails: json["prescriptionDetails"],
    shipingInfo: json["shiping_info"],
    dateTime: DateTime.parse(json["date_time"]),
    discount: json["discount"],
    totalBill: json["total_bill"],
    deliveryCharge: json["delivery_charge"],
    status: json["status"],
    paymentType: json["payment_type"],
    invoiceItemId: json["invoice_item_id"],
    invoiceId: json["invoice_id"],
    restaurantId: json["restaurant_id"],
    productId: json["product_id"],
    qty: json["qty"],
    totalAmount: json["total_amount"],
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "image": image,
    "address1": address1,
    "address2": address2,
    "phone": phone,
    "name": name,
    "purchasePrice": purchasePrice,
    "price": price,
    "size": size,
    "id": id,
    "customer_id": customerId,
    "orderdetails": orderdetails,
    "prescriptionDetails": prescriptionDetails,
    "shiping_info": shipingInfo,
    "date_time": dateTime.toIso8601String(),
    "discount": discount,
    "total_bill": totalBill,
    "delivery_charge": deliveryCharge,
    "status": status,
    "payment_type": paymentType,
    "invoice_item_id": invoiceItemId,
    "invoice_id": invoiceId,
    "restaurant_id": restaurantId,
    "product_id": productId,
    "qty": qty,
    "total_amount": totalAmount,
  };
}
