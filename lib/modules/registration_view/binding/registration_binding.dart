import 'package:chat_app_using_firebase/modules/registration_view/controller/registration_controller.dart';
import 'package:get/get.dart';

class RegistrationBinding extends Bindings{
 @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => RegistrationController(), fenix: true);
  }
}