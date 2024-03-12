import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v2ray_example/models/config_model.dart';
import 'package:flutter_v2ray_example/screen/home/home_controller.dart';
import 'package:flutter_v2ray_example/screen/servers/server_controller.dart';
import 'package:get/get.dart';
import '../servers/server_item_widget.dart';
import '../servers/server_list_page.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'VPNITO',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/logo.png',
              width: 30,
              height: 30,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        body: Obx(
          () => Stack(
            children: [
              Positioned(
                  top: 50,
                  child: Opacity(
                      opacity: .1,
                      child: Image.asset(
                        'assets/background.png',
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.height / 1.5,
                      ))),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    Center(
                        child: Text(
                          "connectionState",
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                    const SizedBox(height: 8),
                    FutureBuilder<List<NetworkInterface>>(
                        future: NetworkInterface.list(),
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? [];
                          final ip = data.isEmpty
                              ? '0.0.0.0'
                              : data.first.addresses.first.address;
                          return Center(
                              child: Text(
                                ip,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                    color:
                                    Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ));
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () async {
                          controller.toggleV2rayConnection();
                        },
                        borderRadius: BorderRadius.circular(90),
                        child: AvatarGlow(
                          glowColor: controller.v2rayStatus.value.state == "CONNECTED" ? Colors.blue : Colors.grey,
                          endRadius: 100.0,
                          duration: const Duration(milliseconds: 2000),
                          repeat: true,
                          showTwoGlows: true,
                          repeatPauseDuration:
                          const Duration(milliseconds: 100),
                          shape: BoxShape.circle,
                          child: Material(
                            elevation: 0,
                            shape: const CircleBorder(),
                            color: controller.v2rayStatus.value.state == "CONNECTED" ? Colors.blue : Colors.grey,
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.power_settings_new,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    controller.v2rayStatus.value.state == "CONNECTED" ? "CONNECTED" : "Tap To Connect",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Speed:'),
                        const SizedBox(width: 10),
                        Text(controller.v2rayStatus.value.uploadSpeed),
                        const Text('↑'),
                        const SizedBox(width: 10),
                        Text(controller.v2rayStatus.value.downloadSpeed),
                        const Text('↓'),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ServerItemWidget(
                      flagAsset: controller.selectedConfig?.value.flag != null ? "./assets/${controller.selectedConfig?.value.flag}.png" :
                      'assets/logo.png',
                      label: controller.selectedConfig?.value.name ??
                          'No sever selected',
                      icon: Icons.arrow_forward_ios,
                      onTap: () async {
                        Get.to(ServerListPage())?.then((selectedConfig) {
                          controller.selectedConfig = Rx<ConfigModel>(selectedConfig);
                          Get.reload();
                          Get.forceAppUpdate();
                        });
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Spacer(),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal:
                            MediaQuery.of(context).size.width / 4.5),
                        backgroundColor:
                        const Color.fromRGBO(37, 112, 252, 1),
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Get Premium',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 35),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
