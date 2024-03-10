import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';
import 'package:flutter_v2ray_example/models/config_model.dart';
import 'package:flutter_v2ray_example/screen/servers/server_controller.dart';
import 'package:flutter_v2ray_example/services/data_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {


  late Stream<String> durationStream;
  Rxn<ConfigModel>? serverConfig;
  Rx<ConfigModel>? selectedConfig;
  RxString connectionTime = '00.00.00'.obs;
  RxList configs = [].obs;
  var v2rayStatus = ValueNotifier<V2RayStatus>(V2RayStatus());
  String? coreVersion;

  String remark = "Default Remark";

  final _serverController = Get.put(ServerController());




  late final FlutterV2ray flutterV2ray = FlutterV2ray(
    onStatusChanged: (status) {
      v2rayStatus.value = status;
    },
  );

  @override
  void onInit() async {
    super.onInit();
    fetchData();
    print("oninit");
    flutterV2ray.initializeV2Ray().then((value) async {
      coreVersion = await flutterV2ray.getCoreVersion();
    });
  }

  Future<void> fetchData() async {
    // _serverController.setConfigs(await DataServices().getConfigs());
    _serverController.configs.value = await DataServices().getConfigs();
    _serverController.refresh();
  }
  Future<void> connect() async {

  }


}
