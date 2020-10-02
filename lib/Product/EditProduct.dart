import 'dart:convert';
import 'dart:io';
import 'package:duare_medicine/Dialog/CustomDialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProduct extends StatefulWidget {
  String name, subCatId, resId, description, size, comName, purchagePrice, sellingprice, discountPercent, openingTime, closingTime, availible, image, id;
EditProduct({this.name, this.subCatId, this.resId, this.description, this.size, this.comName, this.purchagePrice, this.sellingprice, this.discountPercent, this.openingTime, this.closingTime, this.availible, this.image, this.id,});
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<EditProduct> {
  TextEditingController et_name = TextEditingController();
  TextEditingController et_desc = TextEditingController();
  TextEditingController et_size = TextEditingController();
  TextEditingController et_complanyName = TextEditingController();
  TextEditingController et_byuPrice = TextEditingController();
  TextEditingController et_sellingPrice = TextEditingController();
  TextEditingController et_discountPercent = TextEditingController();
  TextEditingController et_available = TextEditingController();
  TextEditingController et_openingTime = TextEditingController();
  TextEditingController et_closingTime = TextEditingController();
  String base64Image ;
  bool _isLoading=false;
  File galaryFile;
  String imgUrl;
  String errorText ="";



  selectImgFromGalary()async{
    File tempFile  =await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    setState(() {
      galaryFile = tempFile;
    });
  }

  error(text) {
    setState(() {
      errorText = text;
    });
  }


  String dataSharePre = '';
  String nameKey = "_key_name";



  Future<String> loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(nameKey);
  }

  Future editProduct() async {
    dataSharePre = await loadData();
    setState(() {
      _isLoading = true;
    });
    print(widget.id);
    var postUri = Uri.parse("https://admin.duare.net/api/shopApi/product_edit.php");
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['name'] =et_name.text ;
   request.fields['subCategory_id'] =widget.subCatId;
    request.fields['restaurant_id'] =dataSharePre;
    request.fields['description'] =et_desc.text;
    request.fields['size'] =et_size.text;
    request.fields['company_name'] =et_complanyName.text;
    request.fields['purchasePrice'] =et_byuPrice.text;
    request.fields['sellingPrice'] =et_sellingPrice.text;
    request.fields['discount_percent'] =et_discountPercent.text;
    request.fields['opening_time'] =et_openingTime.text;
    request.fields['closing_time'] =et_closingTime.text;
 //   request.fields['availability'] =et_available.text;
    request.fields['id'] = widget.id ;

    if( galaryFile != null){
      print('Not null');
      http.MultipartFile multipartFile =
      await http.MultipartFile.fromPath('image', galaryFile.path);
      request.files.add(multipartFile);
    }else{
      print('image null');
//      http.MultipartFile multipartFile =
//      await http.MultipartFile.fromPath('image', null);
//      request.files.add(multipartFile);
    }


//    final responce = await http.post("https://admin.duare.net/api/shopApi/product_add.php", body: {
//      'name':et_name.text,
//      'subCategory_id':widget.subcatId,
//      'restaurant_id':'25',
//      'description':et_desc.text,
//      'size':et_size.text,
//      'company_name':et_complanyName.text,
//      'purchasePrice':et_byuPrice.text,
//      'sellingPrice':et_sellingPrice.text,
//      'discount_percent':et_discountPercent.text,
//      'opening_time':'6:00:00',
//      'closing_time':'23:00:00',
//      'availability':'available',
//    'image':null});
    request.send().then((result) async {

      http.Response.fromStream(result)
          .then((response) {


        if (response.statusCode == 200)
        {
          print("Uploaded! ");
          print('response.body '+response.body);
          var data = json.decode(response.body);
          var message = data['message'];
          showDialog(
              context: context,
              builder: (context) => CustomDialog(title: message,description: et_name.text+"\n"+message.toString(),buttonText: "View Product List",));

        }
        else{
          errorText = "Something Wrong";
        }

        return response.body;

      });
    }).catchError((err) => print('error : '+err.toString()))
        .whenComplete(()
    {});
    setState(() {
      _isLoading = false;
    });

  }
  @override
  void initState() {
    // TODO: implement initState

    et_name.text = widget.name;
    et_desc.text = widget.description;
    et_size.text = widget.size;
    et_complanyName.text = widget.comName;
    et_byuPrice.text = widget.purchagePrice;
    et_sellingPrice.text = widget.sellingprice;
    et_discountPercent.text = widget.discountPercent;
    et_available.text = widget.availible;
    et_openingTime.text = widget.openingTime;
    et_closingTime.text = widget.closingTime;
    imgUrl = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
      ),
      body: _isLoading ? CircularProgressIndicator() : SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: et_name,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  labelText: 'Product Name',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: et_desc,
                keyboardType: TextInputType.multiline,
                minLines: null,
                decoration: new InputDecoration(
                  labelText: 'Product Description',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: et_size,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  labelText: 'Size',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: et_complanyName,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  labelText: 'Company Name',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: et_byuPrice,
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
                controller: et_sellingPrice,
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
              TextField(
                controller: et_discountPercent,
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: 'Discount Percent',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(0),
                  ),
                ),
              ),
//              SizedBox(
//                height: 10,
//              ),
//              TextField(
//                controller: et_available,
//                keyboardType: TextInputType.number,
//                decoration: new InputDecoration(
//                  labelText: 'Available ',
//                  border: new OutlineInputBorder(
//                    borderRadius: new BorderRadius.circular(0),
//                  ),
//                ),
//              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: et_openingTime,
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: 'Opening Time',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: et_closingTime,
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: 'Closing Time',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: (){
                  selectImgFromGalary();
                },
                child: galaryFile !=null ?  Container(
                  height: 100,
                  width: 100,
                  child: Image.file(galaryFile),
                ) : Container(
                  height: 100,
                  width: 100,
                  child: widget.image.length>2 ? Image.network("https://admin.duare.net/uploads/products/"+widget.image): Icon(Icons.image,size: 30,),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Text(errorText),
              GestureDetector(
                onTap: () async{

               //   galaryFile!= null ? addProduct() : error("Please Add an Image");

                  editProduct();


                },
                child: Container(
                  color: Colors.blueAccent,
                  height: 48,
                  width: MediaQuery.of(context).size.width - 60,
                  child: Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
