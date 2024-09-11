import 'package:chat_app_using_firebase/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginAuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final isLoading = false.obs;

  AuthServices service = AuthServices();

  Future<bool> signIn() async {
    try {
      isLoading.value = true;
      UserCredential user = await service.signinWithEmailandPass(
          emailController.text, passwordController.text);
      
      if (user.user != null && user.user!.email == emailController.text) {
        isLoading.value = false;
        return true;
      } else {
        isLoading.value = false;
        return false;
      }
    } catch (ex) {
      isLoading.value = false;
      Get.snackbar('Auth Exception', ex.toString());
      return false;
    }
  }
}
