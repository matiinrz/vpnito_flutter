import 'dart:ffi';

import 'package:flutter_v2ray_example/models/config_model.dart';
import 'package:get/get.dart';

class ServerController extends GetxController {
  RxList<ConfigModel> configs = RxList<ConfigModel>();

  void setConfigs(List<ConfigModel> apiConfigs) {
    configs.value = apiConfigs;
  }
}
