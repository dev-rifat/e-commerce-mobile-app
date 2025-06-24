import 'package:get/get.dart';
import '../app/moduls/auth/view/screen/forgot_password.dart';
import '../app/moduls/auth/view/screen/sign_in.dart';
import '../app/moduls/auth/view/screen/sign_up.dart';
import '../app/moduls/starting/view/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH_SCREEN;
  static final routes = [


      GetPage(
        name: _Paths.SPLASH_SCREEN,
        page: () => const SplashScreen(),
      ),



    GetPage(
      name: _Paths.SIGN_IN,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => SignUpScreen(),
    ),

    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordScreen(),
    ),


      // GetPage(
      //   name: _Paths.MAIN,
      //   page: () => const ZoomMainDrawer(),
      // ),




  ];
}
