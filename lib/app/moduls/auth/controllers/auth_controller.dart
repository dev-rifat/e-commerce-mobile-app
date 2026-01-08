import 'package:e_com_cub/app/moduls/profile/controllers/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class AuthController extends GetxController {
  final ProfileController _profileController = Get.find<ProfileController>();

  final isSignInLoading = false.obs;
  final isSignUpLoading = false.obs;
  final isForgotPasswordLoading = false.obs;

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final confirmPassController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() {
    isSignInLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      _profileController.updateUser(
        name: userNameController.text,
        email: emailController.text,
        phone: phoneController.text,
      );
      isSignInLoading.value = false;
      Get.offAllNamed(Routes.MAIN);
    });
  }


  void signUp() {
    isSignUpLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      _profileController.updateUser(
        name: userNameController.text,
        email: emailController.text,
        phone: phoneController.text,
      );
      isSignUpLoading.value = false;
      Get.offAllNamed(Routes.MAIN);
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }
}
