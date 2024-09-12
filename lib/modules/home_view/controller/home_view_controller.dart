import 'package:chat_app_using_firebase/services/data_services/data_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewController  extends GetxController{

 

 
 TextEditingController messageController = TextEditingController();

 DataServices dataServices = DataServices();
 FirebaseAuth auth = FirebaseAuth.instance;



  void sendMesaage () async{
  await dataServices.send_messages(messageController.text).then((value) {
    messageController.clear();
  },);

  }


 
   Stream<QuerySnapshot<Object?>> getAllMessage () {
    return dataServices.get_messages(); 
 }

 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    messageController.clear();
    messageController.dispose();
  }
}