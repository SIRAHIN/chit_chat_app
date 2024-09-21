import 'package:chat_app_using_firebase/components/my_text_field_widget.dart';
import 'package:chat_app_using_firebase/modules/login_view/controller/login_auth_controller.dart';
import 'package:chat_app_using_firebase/routes/routes_name.dart';
import 'package:chat_app_using_firebase/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginAuthController> {
   LoginView({super.key});

  LoginAuthController controllerLog = Get.put(LoginAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hi,We Missed You From',
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
                hintText: 'Email',
                controller: controller.emailController,
                isobscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              my_txt_field(
                hintText: 'Password',
                controller: controller.passwordController,
                isobscureText: true,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t you have any Account? '),
                  TextButton(
                      style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.all(0))),
                      onPressed: () {
                        Get.toNamed(RoutesName.registationView);
                      },
                      child: const Text('Registration Now')),
                ],
              ),
              SizedBox(
                width: 150,
                child: MaterialButton(
                  color: Colors.deepPurple,
                  child: Obx(
                   () => controller.isLoading.value == true ? const Center(child: CircularProgressIndicator()) :
                     Text(
                      'Login',
                      style: customTextStyle(fontColor: Colors.white, fontsize: 18),
                    ),
                  ),
                  onPressed: () async {
                  var isAccountExsit = await controller.signIn();
                  if(isAccountExsit){
                   Get.offAllNamed(RoutesName.homeView);
                  } else {
                   Get.toNamed(RoutesName.registationView);
                  }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
