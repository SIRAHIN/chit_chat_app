import 'package:chat_app_using_firebase/modules/home_view/view/home_view.dart';
import 'package:chat_app_using_firebase/modules/login_view/view/login_view.dart';
import 'package:chat_app_using_firebase/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthState extends StatelessWidget {
  const AuthState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
           return const HomeView();
          } else {
           return LoginView();
          }

        
        },
      ),
    );
  }
}
