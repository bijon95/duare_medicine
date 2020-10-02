import 'dart:convert';

import 'package:duare_medicine/Model/ProductListModel.dart';
import 'package:duare_medicine/Product/EditProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductList extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<ProductList> {
  String dataSharePre = '';
  String nameKey = "_key_name";

  Future<String> loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(nameKey);
  }

  List<Product> productListMain = List();

  List<Product> _displayProduct = List();

  List<Product> productList = List();
  bool _isLoading = true;

  Future productDelete(
    idd,
  ) async {
    final response = await http.post(
        "https://admin.duare.net/api/shopApi/product_delete.php",
        body: {'id': idd});
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      // _showToast(context);

      Navigator.pop(context);
      Navigator.pop(context);
      //__mainPageState.getProduct();
      getProduct();
    }
    print(data);
  }


  Future availablityChange (
     String idd,String  avility
      ) async {

    var status = 'available';

    if (avility == "available") {
      status = 'unavailable';
    }
    final response = await http.post(
        "https://admin.duare.net/api/shopApi/editProductAvailablility.php",
        body: {'id': idd,
          'availability': status,

        });

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      // _showToast(context);

      Navigator.pop(context);

      //__mainPageState.getProduct();
      Fluttertoast.showToast(
          msg: "Successfully Changed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
      );
  getProduct();
    }
    print(data);
  }


  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to favorite'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void getProduct() async {
    dataSharePre = await loadData();
    setState(() {
      _isLoading = true;
    });
    final responce = await http.get(
        "https://admin.duare.net/api/shopApi/all_product_list.php?shop_id=" +
            dataSharePre);
    setState(() {
      _isLoading = false;
    });

    if (responce.statusCode == 200) {
      var data = json.decode(responce.body);

      for (var note in data) {
        productListMain.add(Product.fromJson(note));
      }
      setState(() {
        productList = productListMain.reversed.toList();
        _displayProduct.clear();
      });
    } else {
      print("Something Wrong");
    }
  }

  Future editProduct(id, availity) async {
    var status = 'available';
    print(id);
    if (availity == "available") {
      status = 'unavailable';
    }
    final response = await http
        .post('https://admin.duare.net/api/shopApi/product_edit.php', body: {
      'id': "22206",
      'availability': 'available',
    });

    var data = json.decode(response.body);
    print(data);
  }

  cupertinoView(
      String name,
      String description,
      String size,
      String company,
      String buyPrice,
      String sellPrice,
      String discPrice,
      String available,
      String openTime,
      String closeTime,
      String id,
      String img,
      String subcatId) {
    final action = CupertinoActionSheet(
      title: Text(
        name + id,
        style: TextStyle(fontSize: 18),
      ),
      message: Text(
        company + " " + size,
        style: TextStyle(fontSize: 14.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Edit"),
          isDefaultAction: true,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProduct(
                          name: name,
                          description: description,
                          size: size,
                          comName: company,
                          purchagePrice: buyPrice,
                          sellingprice: sellPrice,
                          discountPercent: discPrice,
                          availible: available,
                          openingTime: openTime,
                          closingTime: closeTime,
                          image: img,
                          id: id,
                          subCatId: subcatId,
                        )));
          },
        ),
        CupertinoActionSheetAction(
          child: Text(available=="available" ? "Set Unavailable" : "Set Available"),
          isDefaultAction: true,
          onPressed: () {
            availablityChange(id, available);
          },
        ),
        CupertinoActionSheetAction(
          child: Text("Delete"),
          isDestructiveAction: true,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => dialogContent(
                      context,
                      "Want to delete " + name,
                      size + " " + company,
                      id,
                    ));
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
  }

  dialogContent(
    context,
    title,
    description,
    id,
  ) {
    return AlertDialog(
      content: Container(
        //height: MediaQuery.of(context).size.height/2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 18, color: Colors.black45),
            ),

            SizedBox(height: 16.0),
            // Text(
            //   title,
            //   style: TextStyle(fontSize: 24.0),
            // ),
            // SizedBox(height: 16.0),
            Container(
              child: Text(description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.0, height: 2.0, color: Colors.black45)),
            ),
            SizedBox(
              height: 24.0,
            ),
            Center(
              // alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(
                  bottom: 20.0,
                ),
                width: 180.0,
                decoration: BoxDecoration(
                  color: Colors.red[400],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: FlatButton(
                    onPressed: () {
                      productDelete(id);
                    },
                    child: Text('Delete')),
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                )),
          ],
        ),
      ),
    );
  }

  TextEditingController controller = new TextEditingController();

  onSearchTextChanged(String text) async {
    _displayProduct.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    productList.forEach((userDetail) {
      if (userDetail.name.toUpperCase().contains(text.toUpperCase()) ||
          userDetail.description.toUpperCase().contains(text.toUpperCase()))
        _displayProduct.add(userDetail);
    });

//    productList.forEach((note) {
//      if (note.name.contains(text) || note.name.contains(text))
//        _displayProduct.add(note);
//    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
      ),
      body: _isLoading
          ? Container(height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,child: Center(child: CircularProgressIndicator()),)
          : SingleChildScrollView(
              child: Container(
              margin: EdgeInsets.only(bottom: 100),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: controller,
                      decoration: new InputDecoration(
                          hintText: 'Search Product', border: InputBorder.none),
                      onChanged: onSearchTextChanged,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 120,
                    child: _displayProduct.length == 0
                        ? ListView.builder(
                            itemCount: productList.length,
                            itemBuilder: (BuildContext contxt, int index) {
                              return GestureDetector(
                                onTap: () {
                                  cupertinoView(
                                      productList[index].name,
                                      productList[index].description,
                                      productList[index].size,
                                      productList[index].medicineCompany,
                                      productList[index].purchasePrice,
                                      productList[index].price,
                                      productList[index].discountPercent,
                                      productList[index].availability,
                                      productList[index].openingTime,
                                      productList[index].closingTime,
                                      productList[index].id,
                                      productList[index].image,
                                      productList[index].subCategoryId);
                                },
                                child: Container(
                                  color: Colors.white,
                                  height: 95,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(
                                      left: 10, top: 5, bottom: 5, right: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            height: 75,
                                            width: 75,
                                            child: Image.network(
                                                "https://admin.duare.net/uploads/products/" +
                                                    productList[index].image),
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(left: 20),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      120,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                          margin: EdgeInsets.only(left: 5),
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              150,
                                                          child: Text(
                                                            productList[index]
                                                                .name,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14),
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                          )),
                                                      Icon(Icons.edit)
                                                    ],
                                                  )),
                                              Container(

                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                    150,
                                                child: Text(
                                                  productList[index].description,
                                                  overflow:
                                                  TextOverflow
                                                      .fade,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 14),
                                                  maxLines: 1,
                                                ),
                                              ),
                                              Container(

                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                    150,
                                                child: Text(
                                                  productList[index]
                                                      .medicineCompany +
                                                      "  ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 14),
                                                  overflow:
                                                  TextOverflow
                                                      .fade,
                                                  maxLines: 1,

                                                ),
                                              ),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      150,
                                                  child: Row(
                                                    children: [

                                                      Text(
                                                        productList[index].size+" ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 14),
                                                      ),
                                                     Text(productList[index].availability=="available" ? "In Stock" : "Stock Out",style: TextStyle(color: productList[index].availability=="available" ? Colors.green: Colors.red[300]),),
                                                    ],
                                                  )),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    150,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        child: Text(
                                                      "Buy ৳ " +
                                                          productList[index]
                                                              .purchasePrice,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14),
                                                    )),
                                                    Container(
                                                        child: Text(
                                                      "  Sell ৳ " +
                                                          productList[index]
                                                              .price,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14),
                                                    )),
                                                    Container(
                                                        child: Text(
                                                      "  Discount ৳ " +
                                                          productList[index]
                                                              .discountPercent,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14),
                                                    )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
//                  Container(
//                    height: 1,
//                    width: MediaQuery.of(context).size.width,
//                    color: Colors.grey[300],
//                  ),
                                    ],
                                  ),
                                ),
                              );
                            })
                        : ListView.builder(
                            itemCount: _displayProduct.length,
                            itemBuilder: (BuildContext contxt, int index) {
                              return GestureDetector(
                                onTap: () {
                                  cupertinoView(
                                      _displayProduct[index].name,
                                      _displayProduct[index].description,
                                      _displayProduct[index].size,
                                      _displayProduct[index].medicineCompany,
                                      _displayProduct[index].purchasePrice,
                                      _displayProduct[index].price,
                                      _displayProduct[index].discountPercent,
                                      _displayProduct[index].availability,
                                      _displayProduct[index].openingTime,
                                      _displayProduct[index].closingTime,
                                      _displayProduct[index].id,
                                      _displayProduct[index].image,
                                      _displayProduct[index].subCategoryId);
                                },
                                child: Container(
                                  color: Colors.white,
                                  height: 90,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(
                                      left: 10, top: 5, bottom: 5, right: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            height: 75,
                                            width: 75,
                                            child: Image.network(
                                                "https://admin.duare.net/uploads/products/" +
                                                    _displayProduct[index]
                                                        .image),
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(left: 20),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      120,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              150,
                                                          child: Text(
                                                            _displayProduct[
                                                                    index]
                                                                .name,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14),
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                          )),
                                                      Icon(Icons.edit)
                                                    ],
                                                  )),
                                              Text(
                                                _displayProduct[index]
                                                    .description,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14),
                                              ),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      150,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        _displayProduct[index]
                                                                .medicineCompany +
                                                            "  ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14),
                                                      ),
                                                      Text(
                                                        _displayProduct[index]
                                                            .size,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 14),
                                                      ),
                                                      Text(_displayProduct[index].availability=="available" ? "In Stock" : "Stock Out",style: TextStyle(color: _displayProduct[index].availability=="available" ? Colors.green: Colors.red[300]),),
                                                    ],
                                                  )),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    150,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        child: Text(
                                                      "Buy ৳ " +
                                                          _displayProduct[index]
                                                              .purchasePrice,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14),
                                                    )),
                                                    Container(
                                                        child: Text(
                                                      "  Sell ৳ " +
                                                          _displayProduct[index]
                                                              .price,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14),
                                                    )),
                                                    Container(
                                                        child: Text(
                                                      "  Discount ৳ " +
                                                          _displayProduct[index]
                                                              .discountPercent,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14),
                                                    )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
//                  Container(
//                    height: 1,
//                    width: MediaQuery.of(context).size.width,
//                    color: Colors.grey[300],
//                  ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                  ),
                ],
              ),
            )),
    );
  }
}
