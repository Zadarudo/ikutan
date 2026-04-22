import 'package:get/get.dart';
import 'package:ikutan/controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // fenix: true means GetX will recreate the controller
    // if it was disposed, instead of reusing the dead instance
    Get.put<AuthController>(AuthController(), permanent: false);
  }
}