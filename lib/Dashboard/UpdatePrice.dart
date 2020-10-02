import 'dart:convert';

import 'package:duare_medicine/Dashboard/OrderDashBoard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdatePrice extends StatefulWidget {
  String name;
  String resID;
  String invoiceID;
  String productID;
  String buyPrice;
  String sellPrice;
  String quantity;


  UpdatePrice({this.name,this.resID,this.invoiceID,this.productID,this.buyPrice,this.sellPrice,this.quantity});
  @override
  _UpdatePriceState createState() => _UpdatePriceState();
}

class _UpdatePriceState extends State<UpdatePrice> {

  bool _isLoading = false;
  TextEditingController update_buy_price = TextEditingController();
  TextEditingController update_sell_price = TextEditingController();
  TextEditingController update_quantity = TextEditingController();


  Future priceUpdate()async{
    final response  = await http.post("https://admin.duare.net/ajax/editPriceForMedicine",body: ({
      'restaurant_id':widget.resID,
      'invoice_id':widget.invoiceID,
      'product_id':widget.productID,
      'purchasePrice':update_buy_price.text ,
      'sellingPrice':update_sell_price.text,
      'qty':update_quantity.text,
    }));

    var data  = json.decode(response.body);

    setState(() {
      _isLoading = false;
    });
    if(response.statusCode==200){
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>OrderDashboard()));
    }
    print(data);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update_buy_price.text=widget.buyPrice;
    update_quantity.text = widget.quantity;
    update_sell_price.text  =widget.sellPrice;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Price '+widget.name),),
      body: _isLoading ?Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(child: CircularProgressIndicator()),) : SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 10,right: 10),
        child: Column(children: [
          Text(widget.name),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: update_buy_price,
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
              labelText: 'Buy Price',
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(0),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: update_sell_price,
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
              labelText: 'Sell Price',
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(0),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
       GestureDetector(
         onTap: (){
           setState(() {
             _isLoading = true;
           });
           priceUpdate();
         },
         child: Container(
              color: Colors.blueAccent,
              height: 48,
              width: MediaQuery.of(context).size.width - 60,
              child: Center(
                  child: Text(
                    "Update Price",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )),
            ),
       ),
        ],),
      ),
    ),);
  }
}
