import 'dart:convert';
import 'dart:ui';

import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/show_dialog_sample.dart';
import 'auth_service.dart';
import 'constants.dart';
import 'data/api_helper.dart';
import 'models/result_response.dart';

class DataService extends GetxService {
  static DataService get to => Get.find();
  final ApiHelper _apiHelper = Get.find();
  final AuthService _authService = Get.find<AuthService>();

  bool showLoading = true;


  int serverTimeDifference=0;

  @override
  void onInit() {
    super.onInit();
  }


 int getTime(int unix){
   return unix + serverTimeDifference;
 }

  retryViewDialog(VoidCallback retryFunc, {bool canDismis = true}) {
    showDialogSample(
        canDismise: canDismis,
        widget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              width: 0.32 * Constants.widthApp,
              height: 0.32 * Constants.widthApp,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("./assets/items/icons/no-wifi.png"))),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  children: [
                    Text(
                      "پاسخی از سمت سرور دریافت نشد.",
                      // textDirection: TextDirection.rtl,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13.sm, color: Colors.black),
                    ),
                    Text(
                      "لطفا پس از بررسی اتصال اینترنت ، دوباره تلاش کنید",
                      // textDirection: TextDirection.rtl,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13.sm, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 45.h,
              child: InkWell(
                onTap: () {
                  Get.back();
                  retryFunc();
                },
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5.h),
                    width: 0.35 * Get.width,
                    height: 32.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7.r),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5.0,
                              spreadRadius: 1.0)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.refresh,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "تلاش دوباره",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11.0.sm,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            // SizedBox(
            //   height: 15.h,
            // ),
          ],
        ),
        width: 0.6 * Constants.widthApp,
        height: 0.4.sh);
  }



/*
  Future<bool?> editStudentProfile(Map<String, dynamic> data) async {
    return await _apiHelper
        .basePut('/User/UpdateConsultantProfile', jsonEncode(data))
        .futureValue(retryFunction: () {
      printInfo(info: "retry");
    }).then((result) {
      if (result.status == true) {
        Utils.showSnackbar("با موفقیت انجام شد", type: SnackBarType.success);
      }

      return result.status;
    });
  }
*/

  // Future<GetResultResponse> putActiveTest(ActiveTestParams data) async {
  //   print("jsonEncode(data.toJson())");
  //   print(jsonEncode(data.toJson()));
  //   return await _apiHelper
  //       // .basePut('/Test/ActivateTest', jsonEncode(data.toJson()))
  //       .basePut('/Test/AddConsultantTest', jsonEncode(data.toJson()))
  //       .futureValue(retryFunction: () {
  //     printInfo(info: "retry");
  //   });
  // }

  /*Future<GetResultResponse> putUpdateTest(UpdateTestParams data) async {
    print(" jsonEncode(data.toJson())");
    print(jsonEncode(data.toJson()));
    // return GetResultResponse(status: true);
    return await _apiHelper
        .basePut('/StudentTest/UpdateStudentTest', jsonEncode(data.toJson()))
        .futureValue(retryFunction: () {
      printInfo(info: "retry");
    });
  }*/
  // Future<GetResultResponse> putUpdateTest(UpdateConsultantTestParams data) async {
  //   print(" jsonEncode(data.toJson())");
  //   print(jsonEncode(data.toJson()));
  //   return await _apiHelper
  //       .basePut('/StudentTest/UpdateConsultantTest', jsonEncode(data.toJson()))
  //       .futureValue(retryFunction: () {
  //     printInfo(info: "retry");
  //   });
  // }

  /*Future<GetResultResponse> deleteActiveTest(
      DeleteTestStudentParams data) async {
    print("data");
    print(jsonEncode(data.toJson()));
    return await _apiHelper
        .basePut('/StudentTest/DeleteStudentTest', jsonEncode(data.toJson()))
        .futureValue(retryFunction: () {
      printInfo(info: "retry");
    });
  }*/
/*  Future<GetResultResponse> deleteActiveTest(
      DeleteConsultantTestParams data) async {
    print("data");
    print(jsonEncode(data.toJson()));
    return await _apiHelper
        // .basePut('/StudentTest/DeleteStudentTest', jsonEncode(data.toJson()))
        .basePut('/StudentTest/DeleteConsultantTest', jsonEncode(data.toJson()))
        .futureValue(retryFunction: () {
      printInfo(info: "retry");
    });
  }

  Future<List<ExamCategory>?> getExamCategories(
      {required VoidCallback retryFunc}) async {
    if (examCategories != null) {
      examCategories=splash?.examCategories;
      return examCategories;
    } else {
      GetResultResponse result = await _apiHelper
          .baseGet('/Definition/GetExamCategories', '')
          .futureValue(retryFunction: () {});
      List<ExamCategory>? examCategories2;
      if (result.status!) {
        examCategories2 = [];
        result.data.forEach((item) {
          examCategories2!.add(ExamCategory.fromJson(item));
        });
      }
      return examCategories2;
    }
  }*/


}

void LogPrint(Object object) async {
  int defaultPrintLength = 1020;
  if (object == null || object.toString().length <= defaultPrintLength) {
    print(object);
  } else {
    String log = object.toString();
    int start = 0;
    int endIndex = defaultPrintLength;
    int logLength = log.length;
    int tmpLogLength = log.length;
    while (endIndex < logLength) {
      print(log.substring(start, endIndex));
      endIndex += defaultPrintLength;
      start += defaultPrintLength;
      tmpLogLength -= defaultPrintLength;
    }
    if (tmpLogLength > 0) {
      print(log.substring(start, logLength));
    }
  }
}
