import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v2ray_example/screen/home/home_controller.dart';
import 'package:flutter_vpn/flutter_vpn.dart';
import 'package:flutter_vpn/state.dart';
import 'package:get/get.dart';
import '../servers/server_item_widget.dart';
import '../servers/server_list_page.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
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
          body: StreamBuilder<FlutterVpnState>(
              stream: FlutterVpn.onStateChanged,
              builder: (context, snapshot) {
                final flutterVpnState =
                    snapshot.data ?? FlutterVpnState.disconnected;
                return Stack(
                  children: [
                    Positioned(
                        top: 50,
                        child: Opacity(
                            opacity: .1,
                            child: Image.asset(
                              'assets/background.png',
                              fit: BoxFit.fill,
                              height:
                              MediaQuery.of(context).size.height / 1.5,
                            ))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 25),
                          Center(
                              child: Text(
                                controller.connectionState(state: flutterVpnState),
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
                                          controller.connectionColorState(
                                              state: flutterVpnState),
                                          fontWeight: FontWeight.w600),
                                    ));
                              }),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () async {
                                print("object");
                                controller.fetchData();

                                // controller.connect();
                                /*controller
                                      .vpnConnectionDuration()
                                      .listen((event) {
                                    print(event);
                                  });*/
                              },
                              borderRadius: BorderRadius.circular(90),
                              child: AvatarGlow(
                                glowColor: flutterVpnState !=
                                    FlutterVpnState.connected
                                    ? Colors.transparent
                                    : controller.connectionColorState(
                                    state: flutterVpnState),
                                endRadius: 100.0,
                                duration: const Duration(milliseconds: 2000),
                                repeat: flutterVpnState !=
                                    FlutterVpnState.connected
                                    ? false
                                    : true,
                                showTwoGlows: true,
                                repeatPauseDuration:
                                const Duration(milliseconds: 100),
                                shape: BoxShape.circle,
                                child: Material(
                                  elevation: 0,
                                  shape: const CircleBorder(),
                                  color: controller.connectionColorState(
                                      state: flutterVpnState),
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
                                          controller.connectionButtonState(state: flutterVpnState),
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
                          Text(controller.connectionTime.toString(),style: Theme.of(context).textTheme.bodyLarge,),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ServerItemWidget(
                            flagAsset:
                            controller.serverConfig?.value?.flag ?? 'assets/logo.png',
                            label: controller.serverConfig?.value?.name ??
                                'No sever selected',
                            icon: Icons.arrow_forward_ios,
                            onTap: () async {
                              controller.selectedConfig = await Get.to(ServerListPage());

                              final res = await Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ServerListPage();
                              }));

                              if (res != null) {
                                controller.server = res;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          // FastestServerWidget(label: label, icon: icon, flagAsset: flagAsset, onTap: onTap),
                          const Spacer(),
                          TextButton.icon(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal:
                                  MediaQuery.of(context).size.width /
                                      4.5),
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
                );
              })),
    );
  }
}