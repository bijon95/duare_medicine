import 'dart:convert';

import 'package:duare_medicine/Model/SubCatListModel.dart';
import 'package:duare_medicine/Product/AddProduct.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SubCategory extends StatefulWidget {
  @override
  _SubCatListState createState() => _SubCatListState();
}

class _SubCatListState extends State<SubCategory> {

  List<SubCatList> subcatList = List();
  bool _isLoading = true;

  Future getSubCat() async {
    final response = await http.get(
        "https://admin.duare.net/api/shopApi/all_subcategory.php");
    var data = jsonDecode(response.body);
    print(data);
    setState(() {
      _isLoading = false;
    });

    if(response.statusCode==200){
      for(var note in data){
        subcatList.add(SubCatList.fromJson(note));
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSubCat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All sub Category List"),),
      body:_isLoading ? CircularProgressIndicator(): SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 80),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              itemCount: subcatList.length,
              itemBuilder: (BuildContext context, int index){
            return GestureDetector(
              onTap: (){
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AddProduct(subcatId: subcatList[index].id,),),
                // );
              },
              child: Container(
                color: Colors.white,
                height: 85,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 10,top: 5,bottom: 5,right: 20),
                child: Column(
                  children: [Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 5
                        ),
                        height:75,
                        width: 75,
                        child:  Image.network(subcatList[index].image),
                      ),

                      Text(subcatList[index].subCategoryName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      Icon(Icons.arrow_forward,color: Colors.black26,),
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
      ),
    );
  }
}
