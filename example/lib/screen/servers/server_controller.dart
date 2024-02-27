
import 'package:flutter_v2ray_example/models/config_model.dart';
import 'package:flutter_v2ray_example/services/data_service.dart';
import 'package:get/get.dart';

import '../../models/server_model.dart';

class ServerController extends GetxController {

  RxInt? selectedConfig ;
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


  @override
  void onInit() async{
    super.onInit();

    // configs.value = await DataServices().getConfigs();

  }


}
