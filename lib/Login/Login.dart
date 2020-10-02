import 'dart:convert';
import 'package:duare_medicine/Dashboard/DashBoard.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  bool _isLoading = false;



  String nameKey = "_key_name";

  Future<void> saveData(String msg) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(nameKey, msg);
  }

  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  // ignore: missing_return


  String msg = 'ok';
  Future _login() async {



    final response =
    await http.post("https://admin.duare.net/api/shopApi/pharmacy_login.php",body: ({
      'user_name':user.text,
      'password':pass.text,
    }));

    if(response.statusCode==200){
      setState(() {
        _isLoading = false;
      });
      print(json.decode(response.body));

      var datauser = json.decode(response.body);

    //  Toast.show(datauser['message'], context);





      var user_id = datauser[0]["pharmacy_id"];
      saveData(user_id.toString());

      if (user_id == null) {
        setState(() {
          msg = "Login fail";
          Toast.show(msg, context);
          _isLoading = false;
        });
      } else {
        sendToken(user_id );
        //  await saveData(user_id);
        Navigator.of(context).pop();

        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>Dashboard()));
        setState(() {
          _isLoading = false;
        });
      }


    }else{

      setState(() {
        _isLoading = false;
      });
    }

  }

  sendToken(userid ) async {

    firebaseMessaging.getToken().then((token) {
      final vartoken = token.toString();
      pushToken(userid, vartoken);
    });
  }

  pushToken(userid, token) async{
    print(token);
    final response =
    await http.post("https://admin.duare.net/api/shopApi/update_token.php",body: ({
      'id':userid,
      'firebase_token':token,
    }));


    if(response.statusCode==200){
      print(json.encode(response.body));
      setState(() {
        _isLoading = false;

      });
    }

  }

  Widget getPageView(BuildContext context){
    return SingleChildScrollView(
      padding: EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: new Container(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: new Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                ),
                margin: EdgeInsets.only(right: 0, left: 0),
                child: new Wrap(
                  children: <Widget>[
                    Center(
                      child: Container(
                        alignment: Alignment(-1.0, 0.0),
                        padding: EdgeInsets.fromLTRB(30, 44, 30, 10),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: 'Eina_regular',
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        //color: Colors.white,
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: TextField(
                          controller: user,
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            labelText: 'Medicine Username',
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        //color: Colors.blueAccent,
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: TextField(
                          controller: pass,
                          obscureText: true,
                          decoration: new InputDecoration(
                            labelText: 'Your password',
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Center(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  Container(
                                                    //color: Colors.blueAccent,
                                                    width: double.infinity,

                                                    padding:
                                                    EdgeInsets.fromLTRB(
                                                        30, 10, 30, 10),
                                                    height: 80,
                                                    child: RaisedButton(
                                                      //padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                                      color: Color.fromRGBO(
                                                          12, 53, 238, 10),
                                                      onPressed: () {
                                                        _login();
                                                        setState(() {
                                                          _isLoading = true;
                                                        });

//
                                                        Text(
                                                          msg,
                                                          style: TextStyle(
                                                              fontSize: 20.0,
                                                              color:
                                                              Colors.red),
                                                        );
                                                      }, //
                                                      child: new Text(
                                                        "Login",
                                                        style: TextStyle(
                                                          fontFamily:
                                                          'Eina_regular',
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Center(
                      child: Container(
                        //color: Colors.white,
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: SizedBox(
                          height: 118,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Title(color: Colors.blue, child: Text("Login")),),
        body:Center(
            child: _isLoading ? CircularProgressIndicator() :
            getPageView(context))
    );
  }
}