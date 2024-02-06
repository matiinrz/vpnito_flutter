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

  static void showSnackbar(String? message,
      {SnackBarType type = SnackBarType.error}) {
    // closeSnackbar();
    /*   Get.snackbar(message ?? "", message ?? "",
        backgroundColor: Colors.black12, animationDuration: Duration.zero,

        colorText: Colors.white, margin: EdgeInsets.all(10));*/
    // Get.rawSnackbar(
    //   // message: message,
    //   messageText: Center(
    //     child: Text(
    //       message ?? "",
    //       textDirection: TextDirection.rtl,
    //       style: TextStyle(color: Colors.white),
    //     ),
    //   ),
    //   animationDuration: Duration(milliseconds: 600),
    // );

    var colorr = type == SnackBarType.error
        ? Colors.red
        : type == SnackBarType.success
        ? Color(0xFF37D022)
        : Color(0xFFFFC42D);
    closeSnackbar();
    Get.showSnackbar(
      GetSnackBar(
        messageText: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            message ?? "",
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        titleText: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
                type == SnackBarType.error
                    ? 'خطا'
                    :type == SnackBarType.success?
                'موفق':"هشدار",
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.black)),
            SizedBox(
              width: 5,
            ),
            Icon(
              type == SnackBarType.error  ? Icons.error :
              type == SnackBarType.success?Icons.check_circle_rounded:
              Icons.warning,
              color: colorr,
            )
          ],
        ),
        borderWidth: 2,
        borderColor: colorr,
        // icon: const Icon(Icons.check_circle_outline_sharp,color: Colors.white),
        backgroundColor: Colors.white,
        overlayBlur: 3.5,
        borderRadius: 20,
        margin: EdgeInsets.only(left: 20, right: 20, top: 50),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      ),
    );
  }
  static void closeSnackbar() {
    if (Get.isSnackbarOpen == true) {
      Get.back();
    }
  }

}
enum SnackBarType { error, success, warning }