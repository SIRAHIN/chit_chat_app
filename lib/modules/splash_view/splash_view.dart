import 'package:chat_app_using_firebase/routes/routes_name.dart';
import 'package:chat_app_using_firebase/style/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
     Future.delayed(const Duration(seconds: 2), () {
        // getting user info from here // 
         User? user = FirebaseAuth.instance.currentUser;
         if(user != null){
          Get.offAllNamed(RoutesName.homeView);
        } else {
         Get.toNamed(RoutesName.loginView);
        }
     },);
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: SizedBox(
       width: double.infinity,
       child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
        const FaIcon(FontAwesomeIcons.twitch, size: 60, color: Colors.deepPurple,),
        const SizedBox(height: 10,),
        Text('Wecelcome to Chit-Chat', style: customTextStyle(
        fontsize: 25.0, fontColor: Colors.black
        ))
       ],
       ),
     ),
    );
  }
}