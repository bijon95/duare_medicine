
import 'package:duare_medicine/Category/CategoryList.dart';
import 'package:duare_medicine/Dashboard/OrderDashBoard.dart';
import 'package:duare_medicine/Login/Login.dart';
import 'package:duare_medicine/Product/AddProduct.dart';
import 'package:duare_medicine/Product/ProductList.dart';
import 'package:duare_medicine/Product/SubCatList.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class MainDrawer extends StatelessWidget {

  Future<void> removeData(context) async {
    String nameKey = "_key_name";
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    await sharedPreference
      ..remove(nameKey);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
            SizedBox(
              height: 40,
            ),


              ListTile(
                contentPadding: EdgeInsets.only(bottom:0.0,left: 15.0,right: 14.0),
                title: Text('Today Orders'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.0,
                ),
                onTap:(){
    Navigator.push(
    context, MaterialPageRoute(builder: (context) =>OrderDashboard()));
    }

              ),
              ListTile(
                contentPadding: EdgeInsets.only(top:0.0,left: 15.0,right: 14.0),
                title: Text('Medicine List'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.0,
                ),
                onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) =>ProductList()));
                }
              ),
              ListTile(
                contentPadding: EdgeInsets.only(top:0.0,left: 15.0,right: 14.0),
                title: Text('Add Medicine'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.0,
                ),
                onTap:(){

    Navigator.push(
    context, MaterialPageRoute(builder: (context) =>AddProduct()));
                }
              ),
              ListTile(
                title: Text('Category List'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.0,
                ),
                onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) =>CategoryList()));
                }
              ),

              SizedBox(height: 10.0),
              ListTile(
                title: Text('Help?'),
                onTap: (){
                  launch("tel://+8801750118555");
                },
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  removeData(context);
                },
                child: Row(children: [
                  SizedBox(width: 10,),
                  Icon( Icons.info_outline,size: 18,),
                  SizedBox(width: 10,),
                  Text('Log Out'),
                ],),
              ),
            

            ],
          ),
        ));
  }


}