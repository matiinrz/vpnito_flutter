import 'dart:async';
import 'package:flutter_v2ray_example/services/data/storage.dart';
import 'package:get/get.dart';
import '../constants.dart';


class ApiHelperImpl extends GetConnect{
  @override
  void onInit() {
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;
    addRequestModifier();
    httpClient.addResponseModifier((request, response) {
      if (response.statusCode == 401) {
        // Get.offNamed(Routes.LOGIN);
        // AuthService.to.logout();
      }
      /*printInfo(
        info: 'Status Code: ${response.statusCode}\n'
            'Data: ${response.bodyString?.toString() ?? ''}',
      );*/
      return response;
    });
  }
  void addRequestModifier() {
    httpClient.addRequestModifier<dynamic>((request) {
      if (Storage.hasData(Constants.token)) {
        request.headers['Authorization'] = "Bearer " + Storage.getValue(Constants.token);
      }

      printInfo(
        info: 'REQUEST ║ ${request.method.toUpperCase()}\n'
            'url: ${request.url}\n'
            'Headers: ${request.headers}\n'
            'Body: ${request.files?.toString() ?? ''}\n',
      );

      return request;
    });
  }

  // @override
  // Future<Response<PostResultResponse>> baseDelete(String url, params) {
  //   return delete(url + params);
  // }

  @override
  Future<Response> baseRawGet(String url) {
    return get(url);
  }
  @override
  Future<Response> baseDelete(String url, params) {
    return delete(url + params);
  }

  @override
  Future<Response> baseGet(String url, String params) {
    return get(url + params);
  }

  @override
  Future<Response<dynamic>> basePost(String url, data) {
    return post(url, data);
  }

  @override
  Future<Response> basePut(String url, data) {
    return put(url, data);
  }



}
