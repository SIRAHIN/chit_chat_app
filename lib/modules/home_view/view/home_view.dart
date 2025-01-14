import 'package:chat_app_using_firebase/routes/routes_name.dart';
import 'package:chat_app_using_firebase/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:AppBar(
      title: const Text('This is appbar'),
      actions: [
       IconButton(onPressed: () async {
         AuthServices service = AuthServices();
         await service.signOut();
         Get.offAllNamed(RoutesName.loginView);
       }, icon: const FaIcon(FontAwesomeIcons.arrowRightFromBracket))
      ],
     ),
    );
  }
}