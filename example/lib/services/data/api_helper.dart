import 'package:get/get.dart';

abstract class ApiHelper {

  Future<Response> baseGet(String url ,String params);
  Future<Response> basePost(String url , data);
  Future<Response> basePut(String url , data);
  Future<Response> baseDelete(String url , params);
  Future<Response> baseRawGet(String url);

}
