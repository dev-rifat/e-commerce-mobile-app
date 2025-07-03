import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_layout.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../global/utils/app_layout_helper.dart';
import '../../../../global/utils/custom_spacer.dart';
import '../../../../global/view/widgets/custom_app_button.dart';
import '../../../../global/view/widgets/custom_onloading.dart';
import '../../controllers/auth_controller.dart';
import '../widget/common_widget.dart';
import '../widget/sign_in_widget.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    ResponsiveLayout.init(context);

    return Scaffold(
      body: Padding(
        padding: AppLayoutHelper.horizontalMargin(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTitleText(context),
                  customSpacerHeight(height: 30),

                  const TextFieldLayout(),

                  customSpacerHeight(height: 4),

                  _buildForgotPassword(),

                  customSpacerHeight(height: 30),

                  Obx(() => _buildLoginButton()),

                  customSpacerHeight(height: 24),

                  guestButtonLayout(),

                  customSpacerHeight(height: 30),

                  _buildNewUserCreate(context),

                  customSpacerHeight(height: 76),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText(BuildContext context) {
    return titleTextLayout(
      titleText: "Sign in\nto your account",
      subText: "",
      context: context,
      subTitleText: "Welcome Back You've Been Missed!",
    );
  }

  Widget _buildForgotPassword() {
    return Row(
      children: [
        const Spacer(),
        GestureDetector(
          onTap: () => Get.toNamed(Routes.FORGOT_PASSWORD),
          child: Text(
            "Forgot password?",
            style: AppStyle.normal_text_grey,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return CustomAppButton(
      text: "Login",
      widget: controller.isSignInLoading.value
          ? LoadingHelper.customLoading(
        color: AppColor.cardColor,
        sizeFactor: .8,
      )
          : Text(
        "Login",
        style: AppStyle.mid_large_text.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: ResponsiveLayout.scaleText(Dimensions.fontSizeMid),
        ),
      ),
      buttonRadius: Dimensions.radiusDefault,
      buttonColor: AppColor.primaryColor,
      onPressed: _handleLogin,
    );
  }

  void _handleLogin() {

    if(controller.emailController.text.isEmpty || controller.passwordController.text.isEmpty) {
      // For demo: autofill test data, replace with actual validation + login call
      controller.emailController.text = "rifat.dev@gmail.com";
      controller.passwordController.text = "12345678";
    }
    if (_formKey.currentState!.validate()) {
      controller.isSignInLoading(true);

      Timer(const Duration(seconds: 2), () {
        controller.isSignInLoading(false);
        controller.emailController.clear();
        controller.passwordController.clear();
        Get.offAllNamed(Routes.MAIN);
      });
    }
  }
  Widget _buildNewUserCreate(BuildContext context) {
    return createUserAccount(
      context: context,
      firstText: "New user? ",
      endText: AppString.text_sign_up,
      onAction: () {
        clearAuthTextField();
        Get.toNamed(Routes.SIGN_UP);
      },
    );
  }
}
