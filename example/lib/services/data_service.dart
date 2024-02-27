import 'dart:convert';

import 'package:flutter_v2ray_example/models/config_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DataServices extends GetxService {
  static DataServices get to => Get.find();
  List<ConfigModel> configs = [];


  @override
  void onInit() {
    super.onInit();
  }

  Future<List<ConfigModel>> getConfigs() async {

    const String apiUrl = 'https://mortred.snapplr.top/api/configs';

    print("Start fetching data");
    try {
      print("Start fetching data 2");

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {

        List<dynamic> jsonDataArray = json.decode(response.body);
        List<ConfigModel> configList = [];

        for (var jsonArray in jsonDataArray) {
          List<ConfigModel> tempList = jsonArray.map<ConfigModel>((json) => ConfigModel.fromJson(json)).toList();
          configList.addAll(tempList);
        }
        configs.addAll(configList);
        print(configs);
        return configs;
      } else {
        print('Error1: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error2: $error');
      return [];
    }
  }


}