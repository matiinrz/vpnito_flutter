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
  Rxn<ConfigModel>? serverConfig;
  ConfigModel? selectedConfig;
  RxString connectionTime = '00.00.00'.obs;
  RxList configs = [].obs;
  final config = TextEditingController();
  bool proxyOnly = false;
  var v2rayStatus = ValueNotifier<V2RayStatus>(V2RayStatus());
  final bypassSubnetController = TextEditingController();
  List<String> bypassSubnets = [];
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

  void navigateToServerListPage() async {
    ConfigModel? selectedConfig = await Get.to(ServerListPage());
    print("naviiiiiii");
    // اگر کاربر سروری انتخاب کرده باشد
    if (selectedConfig != null) {
      print("yessssssssss");

      // انجام عملیات مربوط به سرور انتخاب شده در HomeController
      // مثلا ذخیره اطلاعات در یک متغیر
      serverConfig = selectedConfig.obs as Rxn<ConfigModel>?;

      // یا انجام هر عملیات دلخواه دیگر...
    }
  }

  Future<void> fetchData() async {
    // _serverController.setConfigs(await DataServices().getConfigs());
    _serverController.configs.value = await DataServices().getConfigs();
    _serverController.refresh();
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
}
