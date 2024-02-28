import 'package:flutter/material.dart';
import 'package:flutter_v2ray_example/models/config_model.dart';
import 'package:flutter_v2ray_example/models/server_model.dart';
import 'package:flutter_v2ray_example/screen/servers/server_controller.dart';
import 'package:flutter_v2ray_example/screen/servers/server_item_widget.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class ServerListPage extends GetView<ServerController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
      Navigator.of(context).pop();
      return true;
    }, child: Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Servers',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
          body: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.getConfigs();
                },
                child: const Text("Refresh"),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.getConfigsRealDelay();
                },
                child: const Text("Re-Ping"),
              ),
              ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.configs.length,
                    itemBuilder: (_, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54, width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            controller.setConfig(controller.configs[index]);
                            Get.back();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.white,
                                        // backgroundImage: AssetImage(
                                        //   "./assets/${controller.configs[index].flag}.png",
                                        // ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        controller.configs[index].name! ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                    ],
                                  ),
                                ),
                                controller.configs[index].ping == null
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        controller.configs[index].ping
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        );
      },
    ));
  }
}

/*class ServerListPage extends StatefulWidget {
  const ServerListPage({super.key});

  @override
  _ServerListPageState createState() => _ServerListPageState();
}

class _ServerListPageState extends State<ServerListPage> {


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Servers',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          children: [
            RichText(
                text: TextSpan(
                    text: 'Free ',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.w700),
                    children: [
                  TextSpan(
                      text: 'Servers',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.normal))
                ])),
            RichText(
                text: TextSpan(
                    text: 'Free ',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.w700),
                    children: [
                  TextSpan(
                      text: _serverController.configs.value?.length.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.normal))
                ])),
            const SizedBox(
              height: 20,
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: _serverController.configs.value!.length,
              itemBuilder: (_, index) {
                return Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            // CircleAvatar(
                            //   radius: 15,
                            //   backgroundColor: Colors.white,
                            //   backgroundImage: ExactAssetImage(
                            //     _serverController.configs[index].flag!,
                            //   ),
                            // ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              _serverController.configs.value?[index].name! ?? '',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        RoundCheckBox(
                          size: 24,
                          checkedWidget: const Icon(Icons.check, size: 18, color: Colors.white),
                          borderColor: _serverController.configs.value?[index] == selectedConfig
                              ? Theme.of(context).scaffoldBackgroundColor
                              : const Color.fromRGBO(37, 112, 252, 1),
                          checkedColor: const Color.fromRGBO(37, 112, 252, 1),
                          isChecked: _serverController.configs.value?[index] == selectedConfig,
                          onTap: (x) {
                            setState(() {
                              // selectedConfig = _serverController.configs.value?[index];
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, index) => const SizedBox(height: 10),
            )
          ],
        ),
      ),
    );
  }
}*/
