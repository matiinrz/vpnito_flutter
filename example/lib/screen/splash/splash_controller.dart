import 'package:flutter_v2ray_example/screen/home/home_page.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  RxBool showBtn = false.obs;

  @override
  void onInit() {
    Future.delayed(Duration(seconds: 2), () {
      showBtn.value = true;
    });
    super.onInit();
  }
}
