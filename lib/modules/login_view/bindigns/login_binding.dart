import 'package:get/get.dart';

class LoginBinding extends Bindings{
@override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LoginBinding>(() => LoginBinding(), fenix: true);
  }

}