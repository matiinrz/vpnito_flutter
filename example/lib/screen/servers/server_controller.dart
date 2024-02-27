import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_v2ray_example/models/config_model.dart';
import 'package:flutter_v2ray_example/services/data_service.dart';
import 'package:get/get.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';

class ServerController extends GetxController {

  RxInt? selectedConfig ;

  // RxList<ConfigModel> configs = <ConfigModel>[].obs;

  RxList<ConfigModel> configs = <ConfigModel>[
    ConfigModel(
      id: 1,
      config: "vless://4b774008-0447-452f-82d7-6010af7ae83c@www.speedtest.net:443?security=tls&sni=moein.savarkaraan.ir&fp=chrome&type=grpc&serviceName=@Polproxy,@Polproxy,@Polproxy,@Polproxy,@Polproxy#%D8%B1%D8%A7%DB%8C%DA%AF%D8%A7%D9%86%20%7C%20VLESS%20%7C%20@polproxy%20%7C%20CA%F0%9F%87%A8%F0%9F%87%A6%20%7C%200%EF%B8%8F%E2%83%A36%EF%B8%8F%E2%83%A3",
      country: "canada",
      flag: "CA",
      name: "config bega rafte",
      sortOrder: 1,
      createdAt: "2024-02-04T12:16:01.000000Z",
      updatedAt: "2024-02-04T12:16:01.000000Z",
    ),
    ConfigModel(
      id: 1,
      config: "vless://8044853f-ff06-40e3-ab5a-613ad2e8ddf0@c204afd3-f187-43ee-0e42-3d2a90455e1b.fastkala.site:443?security=tls&sni=far.mafi.network&fp=chrome&type=ws&path=/OeZfxfx9HiitdBhMXK3mgHR1&host=far.mafi.network#%F0%9F%9F%A1%20MTN%20-%20Irancell%20-%206",
      country: "Finland",
      flag: "fl",
      name: "Config ali",
      sortOrder: 1,
      createdAt: "2024-02-04T12:16:01.000000Z",
      updatedAt: "2024-02-04T12:16:01.000000Z",
    ),
    ConfigModel(
      id: 1,
      config: "vless://c8ce2cf9-e311-412e-936b-730a11c4e560@104.18.203.232:2087?security=tls&sni=mehdi3.honarestan-hegmataneh.com&fp=chrome&type=grpc#%D8%B1%D8%A7%DB%8C%DA%AF%D8%A7%D9%86%20%7C%20VLESS%20%7C%20@EliV2ray%20%7C%20CA%F0%9F%87%A8%F0%9F%87%A6%20%7C%200%EF%B8%8F%E2%83%A34%EF%B8%8F%E2%83%A3",
      country: "Canada",
      flag: "ca",
      name: "Config mofti",
      sortOrder: 1,
      createdAt: "2024-02-04T12:16:01.000000Z",
      updatedAt: "2024-02-04T12:16:01.000000Z",
    ),
  ].obs;


  // V2ray Stuffs
  String remark = "Default Remark";
  var v2rayStatus = ValueNotifier<V2RayStatus>(V2RayStatus());
  String? coreVersion;
  late final FlutterV2ray flutterV2ray = FlutterV2ray(
    onStatusChanged: (status) {
      v2rayStatus.value = status;
    },
  );

  @override
  void onInit() async {
    super.onInit();
    // configs.value = await DataServices().getConfigs();
    flutterV2ray.initializeV2Ray().then((value) async {
      coreVersion = await flutterV2ray.getCoreVersion();
    });
    getConfigsRealDelay();
  }

  void getConfigsRealDelay() async {
    debugPrint("Get Config Real Delay Called");

    for (ConfigModel conf in configs) {
      V2RayURL parser = FlutterV2ray.parseFromURL(conf.config!);

      int delay = await _checkRealDelay(parser.getFullConfiguration());
      debugPrint("Config Name: ${conf.name!} PING: $delay");
      conf.ping = delay;
    }
    sortConfigsByPing();
  }

  void sortConfigsByPing() async {
    debugPrint("Sort Config By Ping");
    configs.sort((a, b) {
      if (a.ping == -1 && b.ping == -1) {
        return 0; // if both have -1, maintain current order
      } else if (a.ping == -1) {
        return 1; // move a to the end
      } else if (b.ping == -1) {
        return -1; // move b to the end
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


}
