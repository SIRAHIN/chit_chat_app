import 'package:chat_app_using_firebase/components/my_text_field_widget.dart';
import 'package:chat_app_using_firebase/modules/registration_view/controller/registration_controller.dart';
import 'package:chat_app_using_firebase/routes/routes_name.dart';
import 'package:chat_app_using_firebase/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationView extends GetView<RegistrationController> {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Give You Information To',
              style: customTextStyle(
                  fontsize: 20, fontColor: Colors.deepPurpleAccent),
            ),
            Text(
              'Chit-Chat',
              style:
                  customTextStyle(fontsize: 30, fontColor: Colors.deepPurple),
            ),
            const SizedBox(
              height: 20,
            ),
             my_txt_field(
              controller: controller.emailController,
              hintText: 'Email',
              isobscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
             my_txt_field(
              controller: controller.passwordController,
              hintText: 'Password',
              isobscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
             my_txt_field(
               controller: controller.cpasswordController,
              hintText: 'Confirm Password',
              isobscureText: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already you have any Account? '),
                TextButton(
                    style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.all(0))),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Login Now')),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 150,
              child: MaterialButton(
                color: Colors.deepPurple,
                child: Obx(
                () => 
                  controller.isLoading.value == true ? const Center(child: CircularProgressIndicator()) : Text(
                    'Registration',
                    style: customTextStyle(fontColor: Colors.white, fontsize: 18),
                  ),
                ),
                onPressed: ()  async{
                 var isRegistrationSuccess = await controller.registration();

                 if(isRegistrationSuccess){
                  Get.toNamed(RoutesName.loginView);
                 } else {
                  Get.snackbar('Opps', 'Registartion Unsuccess');
                  Get.toNamed(RoutesName.registationView);
                 }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
