import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';
import 'package:flutter_v2ray_example/models/config_model.dart';
import 'package:flutter_v2ray_example/models/server_model.dart';
import 'package:flutter_v2ray_example/screen/servers/server_controller.dart';
import 'package:flutter_v2ray_example/services/data_service.dart';
import 'package:flutter_vpn/flutter_vpn.dart';
import 'package:flutter_vpn/state.dart';
import 'package:get/get.dart';
import '../servers/server_list_page.dart';

class HomeController extends GetxController {
  late Stream<String> durationStream;
  CharonErrorState charonState = CharonErrorState.NO_ERROR;
  Server? server;
  ConfigModel? serverConfig;
  RxString connectionTime = '00.00.00'.obs;
  RxList configs = [].obs;

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
    durationStream = vpnConnectionDuration();
    flutterV2ray.initializeV2Ray().then((value) async {
      coreVersion = await flutterV2ray.getCoreVersion();
    });
  }

  @override
  void onReady() async {
    super.onReady();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        print("Controller Configs${_serverController.configs}");
      },
    );
  }

  setServerSelected() {
    print("serverConfig :  $serverConfig");
    serverConfig = ServerController().selectedConfig.value;
    print("serverConfig2 :  $serverConfig");
  }

  final config = TextEditingController();
  bool proxyOnly = false;
  var v2rayStatus = ValueNotifier<V2RayStatus>(V2RayStatus());
  final bypassSubnetController = TextEditingController();
  List<String> bypassSubnets = [];
  String? coreVersion;

  String remark = "Default Remark";

  final _serverController = Get.put(ServerController());

  Future<void> fetchData() async {
    // _serverController.setConfigs(await DataServices().getConfigs());
    _serverController.configs.value = await DataServices().getConfigs();
    _serverController.refresh();
  }

  /*Future<void> fetchData() async {
    const String apiUrl = 'http://mortred.snapplr.top/api/configs';
    print("Start fetching data");
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);

      } else {
        print('Error1: ${response.statusCode}');
      }
    } catch (error) {
      print('Error2: $error');
    }
  }*/

  void connect() async {
    if (await flutterV2ray.requestPermission()) {
      flutterV2ray.startV2Ray(
        remark: remark,
        config: config.text,
        proxyOnly: proxyOnly,
        bypassSubnets: bypassSubnets,
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

  void importConfig() async {
    if (await Clipboard.hasStrings()) {
      try {
        final String link =
            (await Clipboard.getData('text/plain'))?.text?.trim() ?? '';
        final V2RayURL v2rayURL = FlutterV2ray.parseFromURL(link);
        remark = v2rayURL.remark;
        config.text = v2rayURL.getFullConfiguration();
        if (Get.context!.mounted) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(
              content: Text(
                'Success',
              ),
            ),
          );
        }
      } catch (error) {
        if (Get.context!.mounted) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text(
                'Error: $error',
              ),
            ),
          );
        }
      }
    }
  }

  void delay() async {
    late int delay;
    if (v2rayStatus.value.state == 'CONNECTED') {
      delay = await flutterV2ray.getConnectedServerDelay();
    } else {
      delay = await flutterV2ray.getServerDelay(config: config.text);
    }
    if (!Get.context!.mounted) return;
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(
          '${delay}ms',
        ),
      ),
    );
  }

  void bypassSubnet() {
    bypassSubnetController.text = bypassSubnets.join("\n");

    showDialog(
      context: Get.context!,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Subnets:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: bypassSubnetController,
                maxLines: 5,
                minLines: 5,
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  bypassSubnets =
                      bypassSubnetController.text.trim().split('\n');
                  if (bypassSubnets.first.isEmpty) {
                    bypassSubnets = [];
                  }
                  Get.back();
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String connectionState({FlutterVpnState? state}) {
    switch (state) {
      case FlutterVpnState.connected:
        return 'You are connected';
      case FlutterVpnState.connecting:
        return 'VPN is connecting';
      case FlutterVpnState.disconnected:
        return 'You are disconnected';
      case FlutterVpnState.disconnecting:
        return 'VPN is disconnecting';
      case FlutterVpnState.error:
        return 'Error getting status';
      default:
        return 'Getting connection status';
    }
  }

  String connectionButtonState({FlutterVpnState? state}) {
    switch (state) {
      case FlutterVpnState.connected:
        return 'Connected';
      case FlutterVpnState.connecting:
        return 'Connecting';
      case FlutterVpnState.disconnected:
        return 'Disconnected';
      case FlutterVpnState.disconnecting:
        return 'Disconnecting';
      case FlutterVpnState.error:
        return 'Error';
      default:
        return 'Disconnected';
    }
  }

  Color connectionColorState({FlutterVpnState? state}) {
    switch (state) {
      case FlutterVpnState.connected:
        return const Color.fromRGBO(37, 112, 252, 1);
      case FlutterVpnState.connecting:
        return const Color.fromRGBO(87, 141, 240, 1);
      case FlutterVpnState.disconnected:
      case FlutterVpnState.disconnecting:
        return Colors.grey;

      default:
        return Colors.red;
    }
  }

  Stream<String> vpnConnectionDuration() async* {
    if (server == null) {
      yield 'Please select a server!';
      return;
    }
    debugPrint('called');
    yield 'Connecting...';
    // Connect to VPN service
    await FlutterVpn.connectIkev2EAP(
      server: server!.domain!,
      username: server!.username!,
      password: server!.password!,
      name: server!.name!,
      mtu: server!.mtu!,
      port: server!.port!,
    );

    // Get current time
    DateTime startTime = DateTime.now();

    // Wait for VPN to connect
    FlutterVpn.prepare();

    // Create a timer that emits the duration of the VPN connection every second
    Timer.periodic(const Duration(seconds: 1), (timer) async* {
      // Get current time
      DateTime now = DateTime.now();

      // Calculate duration of VPN connection
      Duration duration = now.difference(startTime);

      // Format duration as 00.00.00
      String formattedDuration =
          "${duration.inHours.toString().padLeft(2, '0')}.${(duration.inMinutes % 60).toString().padLeft(2, '0')}.${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
      debugPrint(formattedDuration);
      // Emit the formatted duration
      yield formattedDuration;
    });
  }
}
