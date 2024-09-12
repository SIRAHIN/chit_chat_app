import 'dart:io';

import 'package:chat_app_using_firebase/services/data_services/data_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeViewController  extends GetxController{

 
 TextEditingController messageController = TextEditingController();

 DataServices dataServices = DataServices();
 FirebaseAuth auth = FirebaseAuth.instance;


  Stream<QuerySnapshot<Object?>> getAllMessage () {
    return dataServices.get_messages(); 
 }
 

 // Send Message Func //
 void handleSendMessage() async {
   // inital holding message before clean //
  final message = messageController.text;
  // Clear the text field immediately //
  messageController.clear();
  
  // Send the inital holding message asynchronously //
  await dataServices.sendMessage(message);
}




// Handle Image func //
void handleSendImage(ImageSource source) async {
  final imageUrl = await uploadImage(source);
  if (imageUrl != null) {
    await dataServices.sendImageMessage(imageUrl);
  }
}
 

 // Upload Image Func //
 Future<String?> uploadImage(ImageSource source) async {
  final ImagePicker _picker = ImagePicker();
  final XFile? pickedFile = await _picker.pickImage(source: source);

  if (pickedFile == null) return null;

  File file = File(pickedFile.path);
  try {
    final ref = FirebaseStorage.instance.ref().child('chat_images/${DateTime.now().millisecondsSinceEpoch}');
    await ref.putFile(file);
    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  } catch (e) {
    print('Error uploading image: $e');
    return null;
  }
}



 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    messageController.clear();
    messageController.dispose();
  }
}