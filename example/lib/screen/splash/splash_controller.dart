import 'package:flutter_v2ray_example/screen/home/home_page.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{

  @override
  void onInit() {
    Future.delayed(Duration(seconds: 1),() => Get.to(HomePage()),);
    super.onInit();
  }
}