import 'dart:convert';

import 'package:duare_medicine/Dashboard/OrderDetails.dart';
import 'package:duare_medicine/Dashboard/ProductDetails.dart';
import 'package:duare_medicine/Model/OrderListModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OrderDashboard extends StatefulWidget {
  @override
  _OrderDashboardState createState() => _OrderDashboardState();
}

class _OrderDashboardState extends State<OrderDashboard>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;

  bool _isLoading = true;

 List<Delivered> newOrderList = List();
  List<Delivered> processingList = List();
  List<Delivered> pickupList = List();
  List<Delivered> deliveredList = List();

  List<OrderList> allDataList = List();
  String nameKey = "_key_name";
  String dataSharePre = '';
  Future<String> loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(nameKey);
  }

  Future getOrderFromAPI() async {
    dataSharePre = await loadData();
    final responce = await http.get("https://admin.duare.net/ajax/ordersListByRestaurant/"+dataSharePre);

    print(responce.statusCode);
    setState(() {
      _isLoading = false;
    });
  if(responce.statusCode==200){
    var data = json.decode(responce.body);

    var placedData = data["placed"];
    var processingData = data["processing"];
    var pickupData = data["pickup"];
    var deliveredata = data["delivered"];
print(processingData);

if(placedData != null){

  for(var note in placedData){
    newOrderList.add(Delivered.fromJson(note));
  }
}

    if(processingData != null){

      for(var note in processingData){
        processingList.add(Delivered.fromJson(note));
      }
    }

    if(pickupData != null){

      for(var note in pickupData){
        pickupList.add(Delivered.fromJson(note));
      }
    }

    if(deliveredata != null){

      for(var note in deliveredata){
        deliveredList.add(Delivered.fromJson(note));
      }
    }

  }
  }


  @override
  void initState() {
    // TODO: implement initState

   getOrderFromAPI();
    _controller = TabController(length: 4, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Dashboard"),
        bottom:   TabBar(
          controller: _controller,
          tabs: [
            Tab(
              text: 'New Order',
            ),
            Tab(
              text: 'Processing',
            ),
            Tab(
              text: 'PickUp',
            ),
            Tab(
              text: 'Delivered',
            ),
          ],
        ),
      ),
      body:  _isLoading ? Container(height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,child: Center(child: CircularProgressIndicator()),)  :  TabBarView(
        controller: _controller,
        children: [
          Container(
            child: newOrderList.length == 0 ? Text("No New Order"):  ListView.builder(
              //  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

                itemCount: newOrderList.length,
                itemBuilder: (BuildContext context, int index){
                  String date = DateFormat("dd/MM/yyyy hh:mm a").format(newOrderList[index].dateTime);

                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>OrderDetails(itemList:newOrderList[index].orderdetails ,newOrderList: newOrderList,index: index,)));
                    },
                    child: Container(
                     // height: 80,
                      margin: EdgeInsets.only(left: 10,top: 10,),
                      width: MediaQuery.of(context).size.width,
                      child: Column(

                        children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text("Invoice Number : "+newOrderList[index].invoiceId)),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text("Time : "+date)),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Text("Price : "+newOrderList[index].Total_Amount,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                Text(" Payment Type : "+newOrderList[index].paymentType),
                              ],
                            )),
SizedBox(
  height: 10,
),
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[300],)
                      ],),),
                  );

                }),
          ),
          Container(
            child: processingList.length == 0 ? Text("No Processing Order"):  ListView.builder(
              //  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

                itemCount: processingList.length,
                itemBuilder: (BuildContext context, int index){
                  String date = DateFormat("dd/MM/yyyy hh:mm a").format(processingList[index].dateTime);

                  return GestureDetector(
                    onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) =>ProductDetilas(itemList:processingList[index].orderdetails ,newOrderList: processingList,index: index,)));

                    },
                    child: Container(
                      // height: 80,
                      margin: EdgeInsets.only(left: 10,top: 10,),
                      width: MediaQuery.of(context).size.width,
                      child: Column(

                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text("Invoice Number : "+processingList[index].invoiceId)),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text("Time : "+date)),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Text("Price : "+processingList[index].Total_Amount,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  Text(" Payment Type : "+processingList[index].paymentType),
                                ],
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[300],)
                        ],),),
                  );

                }),
          ),
          Container(
            child: pickupList.length == 0 ? Text("No Pickup Order"):  ListView.builder(
              //  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

                itemCount: pickupList.length,
                itemBuilder: (BuildContext context, int index){
                  String date = DateFormat("dd/MM/yyyy hh:mm a").format(pickupList[index].dateTime);

                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>ProductDetilas(itemList:pickupList[index].orderdetails ,newOrderList: pickupList,index: index,)));
                    },
                    child: Container(
                      // height: 80,
                      margin: EdgeInsets.only(left: 10,top: 10,),
                      width: MediaQuery.of(context).size.width,
                      child: Column(

                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text("Invoice Number : "+pickupList[index].invoiceId)),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text("Time : "+date)),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Text("Price : "+pickupList[index].Total_Amount,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  Text(" Payment Type : "+pickupList[index].paymentType),
                                ],
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[300],)
                        ],),),
                  );

                }),
          ),
          Container(
            child: deliveredList.length == 0 ? Text("No Delivered Order"):  ListView.builder(
              //  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

                itemCount: deliveredList.length,
                itemBuilder: (BuildContext context, int index){
                  String date = DateFormat("dd/MM/yyyy hh:mm a").format(deliveredList[index].dateTime);

                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>ProductDetilas(itemList:deliveredList[index].orderdetails ,newOrderList: deliveredList,index: index,)));
                    },
                    child: Container(
                      // height: 80,
                      margin: EdgeInsets.only(left: 10,top: 10,),
                      width: MediaQuery.of(context).size.width,
                      child: Column(

                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text("Invoice Number : "+deliveredList[index].invoiceId)),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text("Time : "+date)),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Text("Price : "+deliveredList[index].Total_Amount,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  Text(" Payment Type : "+deliveredList[index].paymentType),
                                ],
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[300],)
                        ],),),
                  );

                }),
          ),

        ],
      ),
    );
  }
}
