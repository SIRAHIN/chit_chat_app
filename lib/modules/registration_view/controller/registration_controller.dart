import 'package:chat_app_using_firebase/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  final isLoading = false.obs;

  AuthServices service = AuthServices();

  Future<bool> registration() async {
    // Ensure that loading state is set to true
    isLoading.value = true;

    // Validate password match
    if (passwordController.text != cpasswordController.text) {
      isLoading.value = false;
      Get.snackbar('Password Mismatch', 'Passwords do not match');
      // Clear the password fields for user to re-enter
      passwordController.clear();
      cpasswordController.clear();
      return false;
    }

    try {
      // Proceed with registration
      UserCredential user = await service.registrationWithEmailandPass(
          emailController.text, passwordController.text);

      // Check if the registration was successful
      if (user.user != null && user.user!.email == emailController.text) {
        isLoading.value = false;
        return true;
      } else {
        isLoading.value = false;
        return false;
      }
    } catch (ex) {
      // Handle registration errors
      isLoading.value = false;
      Get.snackbar('Registration Error', ex.toString());
      return false;
    }
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    emailController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    super.dispose();
  }
}