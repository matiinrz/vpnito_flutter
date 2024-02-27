
import 'package:flutter_v2ray_example/models/config_model.dart';
import 'package:flutter_v2ray_example/services/data_service.dart';
import 'package:get/get.dart';

import '../../models/server_model.dart';

class ServerController extends GetxController {

  late ConfigModel selectedConfig;
  final premiumServers = <Server>[
    Server(
        name: 'England',
        flag: 'assets/england.png',
        domain: 'vpn.example.com',
        username: 'admin',
        password: 'admin',
        port: 1234,
        mtu: 1234),
    Server(
        name: 'United States',
        flag: 'assets/usa.jpg',
        domain: 'vpn.example.com',
        username: 'admin',
        password: 'admin',
        port: 1234,
        mtu: 1234),
    Server(
        name: 'Canada',
        flag: 'assets/canada.png',
        domain: 'vpn.example.com',
        username: 'admin',
        password: 'admin',
        port: 1234,
        mtu: 1234),
    Server(
        name: 'France',
        flag: 'assets/france.png',
        domain: 'vpn.example.com',
        username: 'admin',
        password: 'admin',
        port: 1234,
        mtu: 1234),
    Server(
        name: 'Ghana',
        flag: 'assets/ghana.png',
        domain: 'vpn.example.com',
        username: 'admin',
        password: 'admin',
        port: 1234,
        mtu: 1234),
  ];
  List<Server> freeServers = [
    Server(
        name: 'England',
        flag: 'assets/england.png',
        domain: 'vpn.example.com',
        username: 'admin',
        password: 'admin',
        port: 1234,
        mtu: 1234),
    Server(
        name: 'France',
        flag: 'assets/france.png',
        domain: 'vpn.example.com',
        username: 'admin',
        password: 'admin',
        port: 1234,
        mtu: 1234),
    Server(
        name: 'Ghana',
        flag: 'assets/ghana.png',
        domain: 'vpn.example.com',
        username: 'admin',
        password: 'admin',
        port: 1234,
        mtu: 1234),
  ];

  RxList<ConfigModel> configs = <ConfigModel>[].obs;


  @override
  void onInit() async{
    super.onInit();
    configs.value = await DataServices().getConfigs();

  }


}
