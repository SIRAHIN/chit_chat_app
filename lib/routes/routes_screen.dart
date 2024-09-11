import 'package:chat_app_using_firebase/modules/home_view/view/home_view.dart';
import 'package:chat_app_using_firebase/modules/login_view/bindigns/login_binding.dart';
import 'package:chat_app_using_firebase/modules/login_view/view/login_view.dart';
import 'package:chat_app_using_firebase/modules/registration_view/binding/registration_binding.dart';
import 'package:chat_app_using_firebase/modules/registration_view/view/registration_view.dart';
import 'package:chat_app_using_firebase/modules/splash_view/splash_view.dart';
import 'package:chat_app_using_firebase/routes/routes_name.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routes = [

 GetPage(
    name: RoutesName.splash,
    page: () => const SplashView(),
  ),
  GetPage(
    name: RoutesName.loginView,
    page: () =>  LoginView(),
    binding: LoginBinding()
  ),

    GetPage(
    name: RoutesName.registationView,
    page: () => const RegistrationView(),
    binding: RegistrationBinding()
  ),

   GetPage(
    name: RoutesName.homeView,
    page: () => const HomeView(),
  ),
];
