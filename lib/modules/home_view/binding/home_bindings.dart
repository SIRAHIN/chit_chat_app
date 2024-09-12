import 'package:chat_app_using_firebase/modules/home_view/controller/home_view_controller.dart';
import 'package:get/get.dart';

class HomeBindings extends Bindings{

 @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => HomeViewController(),);
  }
}