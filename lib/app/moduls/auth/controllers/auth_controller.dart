import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class AuthController extends GetxController {


  final isSignInLoading = false.obs;
  final isSignUpLoading = false.obs;
  final isForgotPasswordLoading = false.obs;

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final confirmPassController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();




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
