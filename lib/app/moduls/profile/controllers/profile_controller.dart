import 'package:e_com_cub/utils/images.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../global/view/widgets/success_message.dart';

class UserController extends GetxController {
  var userName = 'Rifat Hasan'.obs;
  var userEmail = 'rifat.dev@example.com'.obs;
  var userImage = AppImages.person.obs;
  var userContact = '+1 234 567 8901'.obs;
  var emergencyContact = '+1 987 654 3210'.obs;

  void logout() {
    showSuccessMessage(message: 'Logged Out You have been logged out successfully.');
    Get.offAllNamed(Routes.SIGN_IN);
  }
}
