import 'package:AppsData/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    splashInit();
  }

   Future splashInit() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAndToNamed(Routes.DASHBOARDVIEW);
  }


}