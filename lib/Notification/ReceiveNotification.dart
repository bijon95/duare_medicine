
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'model/message.dart';
class Notifi extends StatefulWidget {
  @override
  _NotifiState createState() => _NotifiState();
}

class _NotifiState extends State<Notifi> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _firebaseMessaging.configure(
//
//      onMessage:(Map<String, dynamic> message){
//        print(message);
//
//
//      }
//
//    );




    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
