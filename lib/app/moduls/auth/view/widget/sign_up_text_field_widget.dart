import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../global/view/widgets/cudtom_pass_field.dart';
import '../../../../global/view/widgets/custom_input_field.dart';
import '../../controllers/auth_controller.dart';

userEmailField(controller, {Color? borderColor}) {
  return CustomInputField(
    hitText: AppString.text_enter_email_address.tr,
    controller: controller,
    isHideLabelText: true,
    prefixIcon: Icon(
      Icons.email_outlined,
      color: AppColor.hintColor.withOpacity(0.6),
    ),
    borderColor:borderColor ?? Colors.transparent,
    hintStyle: AppStyle.normal_text_black.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return AppString.the_email_field_is_required;
      } else if (value.isEmpty || !RegExp(emailExp()).hasMatch(value)) {
        return AppString.please_insert_a_valid_email_address.tr;
      } else {
        return null;
      }
    },
  );
}
emailExp() {
  const pattern =
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
  return pattern;
}


final passwordRegex = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&*!]).{8,}$'
);

userNameField(controller) {
  return CustomInputField(
    hitText: AppString.text_user_name.tr,
    controller: controller,
    isHideLabelText: true,
    prefixIcon: Icon(
      CupertinoIcons.person_alt_circle,
      color: AppColor.hintColor.withOpacity(0.6),
    ),
    borderColor: Colors.transparent,
    hintStyle: AppStyle.normal_text_black.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return AppString.the_first_name_field_is_required;
      } else {
        return null;
      }
    },
  );
}

userPhoneNumberField(controller) {
  return CustomInputField(
    hitText: AppString.text_enter_phone_number.tr,
    controller: controller,
    errorBorderColor: Colors.transparent,
    isHideLabelText: true,

    prefixIcon: Icon(
      CupertinoIcons.phone_circle,
      color: AppColor.hintColor.withOpacity(0.6),
    ),
    borderColor: Colors.transparent,
    textInputType: TextInputType.number,
    hintStyle: AppStyle.normal_text_black.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),


  );
}

userPasswordField({String? hintText, TextEditingController? controller}) {
  return PasswordInputField(
    controller: controller ?? Get.find<AuthController>().passwordController,
    borderColor: Colors.transparent,
    hintStyle: AppStyle.normal_text_black.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),
    hitText: hintText ?? "Enter password",
    validator: (value) {
      if (value == null || value.isEmpty) {
        return AppString.the_password_field_is_required;
      } else if (!passwordRegex.hasMatch(value)) {
        return "Weak password. Use A-Z, a-z, 0-9 & symbol.";
      }
      return null;
    },
    prefixIcon: Icon(
      Icons.lock_open_outlined,
      color: AppColor.hintColor.withOpacity(0.6),
    ),
  );
}

userConfirmPasswordField({String? hintText, TextEditingController? controller}) {
  final authController = Get.find<AuthController>();
  final confirmController = controller ?? authController.confirmPassController;

  return PasswordInputField(
    controller: confirmController,
    borderColor: Colors.transparent,
    hintStyle: AppStyle.normal_text_black.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),
    hitText: hintText ?? "Enter confirm password",
    validator: (value) {
      final password = authController.passwordController.text.trim();
      final confirmPassword = value?.trim() ?? '';

      if (confirmPassword.isEmpty) {
        return AppString.the__confirm_password_field_is_required;
      } else if (password != confirmPassword) {
        return "Passwords do not match";
      }
      return null;
    },
    prefixIcon: Icon(
      Icons.lock_open_outlined,
      color: AppColor.hintColor.withOpacity(0.6),
    ),
  );
}

Divider divider() {
  return const Divider(
    color: AppColor.disableColor,
  );
}
