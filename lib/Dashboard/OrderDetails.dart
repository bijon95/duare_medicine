import 'dart:convert';
import 'package:duare_medicine/Dashboard/OrderDashBoard.dart';
import 'package:duare_medicine/Dashboard/UpdatePrice.dart';
import 'package:duare_medicine/Model/InvoiceDetailsModel.dart';
import 'package:duare_medicine/Model/ItemlistModel.dart';
import 'package:duare_medicine/Model/OrderListModel.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
class OrderDetails extends StatefulWidget {
  var itemList;
   List<Delivered> newOrderList = List();
   int index;
  OrderDetails({this.itemList,this.newOrderList,this.index});
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String date;
  var address;

  bool _isLoadin = true;

  List<ItemList> itemList = List();

  Future changeStatus(id,status) async{
    final response  =await http.post("https://admin.duare.net/api/shopApi/order_status_update.php",body: ({
      'id':id,
      'status':status,

    }));
    var data  = json.decode(response.body);
    if(response.statusCode==200){
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>OrderDashboard()));
    }
    print(data);
  }

  String dataSharePre = '';
  String nameKey = "_key_name";

  Future<String> loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(nameKey);
  }

  List<Order> detailsList = List();
var pescription;
  Future orderDetails() async {
    dataSharePre = await loadData();
    final response  = await http.get("https://admin.duare.net/ajax/ordersView/"+widget.newOrderList[widget.index].invoiceId+'/'+dataSharePre);
    var data = json.decode(response.body);
    var order = data["orders"];
  //  print(data);

    for(var note in order ){
      detailsList.add(Order.fromJson(note));
    }
    var prescritpion = json.decode(detailsList[0].prescriptionDetails);
pescription = prescritpion[0]["image"];

    print(prescritpion);
    print(pescription);

    setState(() {
      _isLoadin = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderDetails();
    var list = json.decode(widget.itemList);
    print(list);
     date = DateFormat("dd/MM/yyyy hh:mm a").format(widget.newOrderList[widget.index].dateTime);
    address = json.decode(widget.newOrderList[widget.index].shipingInfo);
     print(address);

     for(var note in list){
       setState(() {
         itemList.add(ItemList.fromJson(note));
       });

    }

    print(itemList[0].proName);

  }


  showAlertDialog(BuildContext context, status, id) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {
        changeStatus(id,status);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(status + " Order ?"),
      content: Text("Would you like to "+status),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Order Details"),),
      body: _isLoadin ? Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(child: CircularProgressIndicator()),) : Container(
        height: MediaQuery.of(context).size.height+100,
        child: SingleChildScrollView(
          child: Container(

            child: Column(children: [
              Container(
                  margin: EdgeInsets.only(left: 10,top: 10,bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Text("Order Information",style: TextStyle(fontSize: 16),)),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Text("Invoice ID : "+widget.newOrderList[widget.index].invoiceId)),
              Container(
                margin: EdgeInsets.only(left: 10,bottom: 5),
                  width: MediaQuery.of(context).size.width,
                  child: Text("Order Date : "+date)),
            Container(
              height: 1,
              color: Colors.grey[300],
              width: MediaQuery.of(context).size.width,
            ),

              Container(
                  margin: EdgeInsets.only(left: 10,top: 10,bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Text("Customer Information",style: TextStyle(fontSize: 16),)),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Text("Name : "+widget.newOrderList[widget.index].userName)),
              Container(
                  margin: EdgeInsets.only(left: 10,bottom: 5),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Text("Phone : "+widget.newOrderList[widget.index].phone.toString()),
                      GestureDetector(
                        onTap: (){
                          launch("tel:"+widget.newOrderList[widget.index].phone);
                        },
                        child: Container(
                          color: Colors.green[200],
                          margin: EdgeInsets.only(left: 20),
                          // width: 50,
                          child: Row(
                            children: [
                              Icon(Icons.call,size: 16,),
                              Text("Call"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                height: 1,
                color: Colors.grey[300],
                width: MediaQuery.of(context).size.width,
              ),

              Container(
                  margin: EdgeInsets.only(left: 10,top: 10,bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Text("Deliver Man Information",style: TextStyle(fontSize: 16),)),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Text("Name : "+widget.newOrderList[widget.index].userName.toString())),
              Container(
                  margin: EdgeInsets.only(left: 10,bottom: 5),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Text("Phone : "+widget.newOrderList[widget.index].phone.toString()),
                      GestureDetector(
                        onTap: (){
                          launch("tel:"+widget.newOrderList[widget.index].phone);
                        },
                        child: Container(
                          color: Colors.green[200],
                          margin: EdgeInsets.only(left: 20),
                          // width: 50,
                          child: Row(
                            children: [
                              Icon(Icons.call,size: 16,),
                              Text("Call"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                height: 1,
                color: Colors.grey[300],
                width: MediaQuery.of(context).size.width,
              ),


              Container(
                  margin: EdgeInsets.only(left: 10,top: 10,bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Text("Payment Information",style: TextStyle(fontSize: 16),)),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Text("Payment Method : "+widget.newOrderList[widget.index].paymentType)),
              Container(
                  margin: EdgeInsets.only(left: 10,),
                  width: MediaQuery.of(context).size.width,
                  child: Text("Discount : ৳"+widget.newOrderList[widget.index].discount)),
              // Container(
              //     margin: EdgeInsets.only(left: 10,),
              //     width: MediaQuery.of(context).size.width,
              //     child: Text("Sub Total : "+widget.newOrderList[widget.index].subTotal)),
              Container(
                  margin: EdgeInsets.only(left: 10,),
                  width: MediaQuery.of(context).size.width,
                  child: Text("Total Bill : ৳"+widget.newOrderList[widget.index].Total_Amount)),
              Container(
                  margin: EdgeInsets.only(left: 10,bottom: 5),
                  width: MediaQuery.of(context).size.width,
                  child: Text("Delivery Charge : ৳"+widget.newOrderList[widget.index].deliveryCharge)),
              Container(
                height: 1,
                color: Colors.grey[300],
                width: MediaQuery.of(context).size.width,
              ),

              Container(
                  margin: EdgeInsets.only(left: 10,top: 10,bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Text("Shipping Information",style: TextStyle(fontSize: 16),)),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Text("Address : "+address['address'])),
              Container(
                  margin: EdgeInsets.only(left: 10,bottom: 5),
                  width: MediaQuery.of(context).size.width,
                  child: Text("Delivery Charge : "+widget.newOrderList[widget.index].deliveryCharge)),
              Container(
                height: 1,
                color: Colors.grey[300],
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                margin: EdgeInsets.only(left: 10,top: 10,bottom: 10),
                width: MediaQuery.of(context).size.width,
                child: Text("Presprition",style: TextStyle(fontSize: 16)),
              ),
              Container(
                height: 350,
               width: MediaQuery.of(context).size.width,
               child: Image.network(pescription),
              ),

              Container(
                height:  detailsList.length *98.0,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: detailsList.length,
                    itemBuilder: (BuildContext context, int index){

                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdatePrice(name: detailsList[index].name,resID: detailsList[index].restaurantId,invoiceID: detailsList[index].invoiceId,productID: detailsList[index].productId, sellPrice: detailsList[index].price,quantity: detailsList[index].qty,buyPrice: detailsList[index].purchasePrice,)));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 3,bottom: 3),
                          height: 92,
                          child: Column(
                            children: [
                              Container(

                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      color: Colors.brown,
                                      height: 60,
                                      width: 60,
                                      child: Image.network("https://admin.duare.net/uploads/products/"+detailsList[index].image),
                                    ),
                                    Container(
                                      height: 90,
                                      margin: EdgeInsets.only(left: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width-100,
                                                child: Text(detailsList[index].name,style: TextStyle(fontWeight: FontWeight.w600),),
                                              ),
                                              Icon(Icons.edit),
                                            ],
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width-100,
                                            child:  Text("Quantity : "+detailsList[index].qty.toString(),),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width-100,
                                            child:   Text("Price : ৳"+detailsList[index].price.toString()),
                                          ),  Container(
                                            width: MediaQuery.of(context).size.width-100,
                                            child:  Text("Total Price : ৳"+detailsList[index].totalAmount.toString()),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width-100,
                                            child:  Text("Discount Price : ৳"+detailsList[index].discount.toString()),
                                          ),


                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 1,
                                color: Colors.green[300],
                              ),
                            ],
                          ),
                        ),
                      );
                }),
              ),

              Container(
                height: 20,
                margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    child: Text("Reject",style: TextStyle(fontSize: 18,color: Colors.red),),
                    onTap: (){
                      showAlertDialog(context,"Cancel",widget.newOrderList[widget.index].invoiceId);
                    },
                  ),
                  GestureDetector(
                    child: Text("Accept",style: TextStyle(fontSize: 18,color: Colors.green),),
                    onTap: (){
                      showAlertDialog(context,"Processing",widget.newOrderList[widget.index].invoiceId);
                    },
                  )

                ],),
              ),
            ],),
          ),
        ),
      ),

    );
  }
}
