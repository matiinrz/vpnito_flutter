import 'package:flutter/material.dart';
import 'package:flutter_v2ray_example/utils/strings.dart';
import 'package:get/get.dart';

import '../widgets/custom_loading_widget.dart';

class Utils {
  const Utils._();


  static void showDialog(
      String? message,textStyle, {
        String title = Strings.error,
        bool success = false,
        VoidCallback? onTap,
      }) =>
      Get.defaultDialog(
        barrierDismissible: false,
        onWillPop: () async {
          Get.back();

          onTap?.call();

          return true;
        },
        title: success ? Strings.success : title,
        content: Text(
          message ?? Strings.somethingWentWrong,
          textAlign: TextAlign.center,
          maxLines: 6,
        ),
        confirm: Align(
          alignment: Alignment.centerRight,
          child: CustomInkwellWidget.text(
            onTap: () {
              Get.back();

              onTap?.call();
            },
            title: Strings.ok,
            textStyle: textStyle,
          ),
        ),
      );

}