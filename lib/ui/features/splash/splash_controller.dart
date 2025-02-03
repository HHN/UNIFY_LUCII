import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:lucii/ui/features/auth/login/login_screen.dart';
import 'package:lucii/ui/features/auth/sign_up/sign_up_screen.dart';
import 'package:lucii/utils/network_util.dart';

import '../../helper/global_variables.dart';

class SplashController extends GetxController {
  RxBool hasLocalAuth = false.obs;

  @override
  Future<void> onReady() async {
    super.onReady();
    NetworkCheck.isOnline().then((value) {
      if (value) {
        Future.delayed(const Duration(seconds: 3), () async {
          GlobalVariables.profileBox = await Hive.openBox('profile');

          //checking of hive
          // print(GlobalVariables.profileBox!.get("interests"));
          // print(GlobalVariables.profileBox!.get("professionalBackground"));
          // print(GlobalVariables.profileBox!.get("locations"));
          // if(GlobalVariables.profileBox!.containsKey("email")){
          //   Get.off(() => const RootScreen());
          // } else {
          //   Get.off(() => const LoginScreen());
          // }
          Get.to(() => const LoginScreen());
          // var loggedIn = GetStorage().read(PreferenceKey.isLoggedIn);
          // if (loggedIn) {
          //   Get.offAll(() => const RootScreen());
          // } else {
          //   Get.off(() => const RootScreen());
          // }
        });
      }
    });
  }
}
