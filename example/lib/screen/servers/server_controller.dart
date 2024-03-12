import 'package:flutter/material.dart';
import 'package:flutter_v2ray_example/models/config_model.dart';
import 'package:get/get.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';

import '../../services/data_service.dart';

class ServerController extends GetxController {

  Rx<ConfigModel?> selectedConfig = Rx<ConfigModel?>(null);
  RxList<ConfigModel> configs = <ConfigModel>[].obs;

  String remark = "Default Remark";
  String? coreVersion;
  late final FlutterV2ray flutterV2ray = FlutterV2ray(
    onStatusChanged: (status) {
      v2rayStatus.value = status;
    },
  );
  var v2rayStatus = ValueNotifier<V2RayStatus>(V2RayStatus());

  @override
  void onInit() async {
    super.onInit();
    getConfigs();

   /* selectedConfig.listen((value) {
      if (value != null) _connectV2ray(_getConfigFullConfig(value.config!));
    });*/

    flutterV2ray.initializeV2Ray().then((value) async {
      coreVersion = await flutterV2ray.getCoreVersion();

    });
  }

  void setConfig(ConfigModel config) {
    selectedConfig.value = config;
  }

  void getConfigs() async {
    configs.value = await DataServices().getConfigs();
    getConfigsRealDelay();
  }

  String _getConfigFullConfig(String config) {
    return FlutterV2ray.parseFromURL(config).getFullConfiguration();
  }

  void getConfigsRealDelay() async {
    for (ConfigModel conf in configs) {
      int delay = await _checkRealDelay(_getConfigFullConfig(conf.config!));
      conf.ping = delay;
    }
    Get.reload();
    sortConfigsByPing();
  }

  void sortConfigsByPing() async {
    configs.sort((a, b) {
      if (a.ping == -1 && b.ping == -1) {
        return 0; // if both have -1, maintain current order
      } else if (a.ping == -1) {
        return 1; // move a to the end
      } else if (b.ping == -1) {
        return -1; // move b to the end
      } else if (a.ping == null) {
        return -1;
      } else {
        return a.ping!.compareTo(b.ping!); // normal comparison
      }
    });

    for (ConfigModel conf in configs) {
      debugPrint("Config Name: ${conf.name!} PING: ${conf.ping}");
    }
  }

  Future<int> _checkRealDelay(String configString) async {
    late int delay;
    if (v2rayStatus.value.state == 'CONNECTED') {
      delay = await flutterV2ray.getConnectedServerDelay();
    } else {
      delay = await flutterV2ray.getServerDelay(config: configString);
    }
    if (!Get.context!.mounted) {
      return -1;
    } else {
      return delay;
    }
  }

 /* void _connectV2ray(String configText) async {
    debugPrint(v2rayStatus.value.state);
    if (await flutterV2ray.requestPermission()) {
      flutterV2ray.startV2Ray(
        remark: remark,
        config: configText,
        proxyOnly: false,
      );
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

  @override
  void onClose() {
    disconnectV2ray();
    super.onClose();
  }*/

  void disconnectV2ray() {
    debugPrint("V2ray Stopped Working");
    flutterV2ray.stopV2Ray();
  }
}
