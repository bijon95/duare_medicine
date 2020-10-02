
import 'package:duare_medicine/Category/CategoryList.dart';
import 'package:duare_medicine/Product/ProductList.dart';
import 'package:flutter/material.dart';
class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  CustomDialog({this.title, this.description, this.buttonText});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(8.0, 50.0, 10.0, 20.0),
          margin: EdgeInsets.only(
            top: 80.0,
          ),
          decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(14.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 20.0),
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              Text(title,style: TextStyle(fontSize: 18),),

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
                      fontSize: 14.0,
                      height: 2.0,
                    )),
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
                    color: Colors.blue,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if(buttonText=="View Category List"){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryList()));
                        }
                        else if(buttonText=="View Product List"){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductList()));
                        }
                        else if (buttonText=="View Sub category List"){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryList()));
                        }



                      },
                      child: Text(buttonText)),
                ),
              ),
              GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
            ],
          ),
        ),
      ],
    );
  }
}