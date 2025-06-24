import 'package:e_com_cub/app/moduls/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';




class GlobalBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}