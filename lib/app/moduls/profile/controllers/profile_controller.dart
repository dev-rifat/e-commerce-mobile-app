import 'package:e_com_cub/utils/images.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../global/view/widgets/success_message.dart';

class ProfileController extends GetxController {
  var userName = 'Unknown'.obs;
  var userEmail = 'rifat.dev@example.com'.obs;
  var userImage = AppImages.person.obs;
  var userContact = '+1 234 567 8901'.obs;
  var emergencyContact = '+1 987 654 3210'.obs;

  void updateUser({required String name, required String email, required String phone}) {
    userName.value = name;
    userEmail.value = email;
    userContact.value = phone;
  }

  void logout() {
    showSuccessMessage(message: 'Logged Out You have been logged out successfully.');
    Get.offAllNamed(Routes.SIGN_IN);
  }
}
