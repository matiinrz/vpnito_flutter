import 'package:flutter_v2ray_example/screen/servers/server_controller.dart';
import 'package:get/get.dart';

import '../screen/home/home_controller.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ServerController>(() => ServerController());

  }
}
