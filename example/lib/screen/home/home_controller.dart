import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';
import 'package:flutter_v2ray_example/models/config_model.dart';
import 'package:flutter_v2ray_example/screen/servers/server_controller.dart';
import 'package:flutter_v2ray_example/services/data_service.dart';
import 'package:get/get.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';



class HomeController extends GetxController {


  late Stream<String> durationStream;
  Rxn<ConfigModel>? serverConfig;
  Rx<ConfigModel>? selectedConfig ;
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

  String _getConfigFullConfig(String config) {
    return FlutterV2ray.parseFromURL(config).getFullConfiguration();
  }




  Future<void> fetchData() async {
    // _serverController.setConfigs(await DataServices().getConfigs());
    _serverController.configs.value = await DataServices().getConfigs();
    _serverController.refresh();
  }
  void connectV2ray() async {
    debugPrint("statussss : ${v2rayStatus.value.state}");
    debugPrint("configggggg : ${selectedConfig?.value.config}");
    if (await flutterV2ray.requestPermission()) {
      if(selectedConfig?.value.config != null){

        flutterV2ray.startV2Ray(
          remark: remark,
          config: _getConfigFullConfig(selectedConfig?.value.config ?? ""),
          proxyOnly: false,
        );

      }

    } else {
      if (Get.context!.mounted) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text('Permission Denied'),
          ),
        );
      }
    }
  }
  /*void delay() async {
    late int delay;
    if (v2rayStatus.value.state == 'CONNECTED') {
      delay = await flutterV2ray.getConnectedServerDelay();
    } else {
      delay = await flutterV2ray.getServerDelay(config: config.text);
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${delay}ms',
        ),
      ),
    );
  }*/

  void toggleV2rayConnection() async {
    if (v2rayStatus.value.state == "CONNECTED") {
      await flutterV2ray.stopV2Ray();
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text('VPN Disconnected'),
        ),
      );
    } else {
       connectV2ray();
    }
  }


}
