import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v2ray_example/models/config_model.dart';
import 'package:flutter_v2ray_example/res/colors.dart';
import 'package:flutter_v2ray_example/res/theme.dart';
import 'package:flutter_v2ray_example/screen/home/home_controller.dart';
import 'package:flutter_v2ray_example/screen/home/home_page.dart';
import 'package:flutter_v2ray_example/screen/servers/server_controller.dart';
import 'package:flutter_v2ray_example/screen/splash/splash_controller.dart';
import 'package:get/get.dart';
import '../servers/server_item_widget.dart';
import '../servers/server_list_page.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
                child: Opacity(
                    opacity: 0.1,
                    child: Image.asset(
                      'assets/background.png',
                      fit: BoxFit.contain,
                    ))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Obx(
                () {
                  return Column(
                    children: [
                      SizedBox(height: Get.height * 0.2),
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("./assets/logo.png"))),
                      ),
                      SizedBox(height: Get.height * 0.15),
                      Center(
                        child: Text(
                          "Version 1.0.0",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      Expanded(
                          child: SizedBox(
                        height: 30,
                      )),
                      controller.showBtn.value
                          ? AnimatedContainer(
                              curve: Curves.easeInCubic,
                              duration: Duration(seconds: 2),
                              width: Get.width * 0.8,
                              height: Get.height * 0.07,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: AppColors.primaryColor,
                              ),
                              child: InkWell(
                                  onTap: () {
                                    Get.off(HomePage());
                                  },
                                  child: Center(
                                      child: Text("Get Start !",
                                          style: AppTheme
                                              .theme.textTheme.titleMedium
                                              ?.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 18.0)))),
                            )
                          : Container()
                    ],
                  );
                },
              ),
            ),
          ],
        ));
  }
}
