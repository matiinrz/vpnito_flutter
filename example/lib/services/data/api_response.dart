import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import '../../utils/strings.dart';
import '../../utils/utils.dart';
import '../models/result_response.dart';
import 'errors/api_error.dart';

class ApiResponse {
  static const ApiResponse instance = ApiResponse._internal();
  factory ApiResponse() => instance;
  const ApiResponse._internal();

  GetResultResponse? getResponse<T>(Response<dynamic> response) {
    final status = response.status;

    if (status.connectionError) {
      throw const ApiError(
        type: ErrorType.noConnection,
        error: Strings.noConnection,
      );
    }

    if (response.bodyString == null) throw const ApiError();

    try {
      String result = response.bodyString!;
      final res = jsonDecode(result);

      if (response.isOk) {
        if (res is Map) {
          if (res['errorcode'] != null &&
              res['errorcode'].toString().isNotEmpty) {
            if (res['errorcode'].toString() == 'invalidtoken') {
              throw const ApiError(
                type: ErrorType.response,
                error: Strings.unauthorize,
              );
            } else {
              Utils.showSnackbar(res['message']?.toString() ?? Strings.unknownError);
              // throw ApiError(
              //   type: ErrorType.response,
              //   error: res['msg']?.toString() ??
              //       (res['message']?.toString() ?? Strings.unknownError),
              // );
            }
          }
        }
        GetResultResponse result =GetResultResponse.fromJson(response.body);
        /*if (!result.status!) {
          throw ApiError(
            type: ErrorType.wrong,
            error: result.message,
          );
        }*/
        return result;
      } else {
        if (status.isServerError) {
          throw const ApiError();
        } else if (status.code == HttpStatus.requestTimeout) {
          throw const ApiError(
            type: ErrorType.connectTimeout,
            error: Strings.connectionTimeout,
          );
        } else if (response.unauthorized) {
          throw ApiError(
            type: ErrorType.unauthorize,
            error: res['msg']?.toString() ?? Strings.unauthorize,
          );
        } else {
          Utils.showSnackbar(res['message']?.toString() ?? Strings.unknownError);
          // throw ApiError(
          //   type: ErrorType.response,
          //   error: res['msg']?.toString() ?? Strings.unknownError,
          // );
        }
      }
    } on FormatException {
      Utils.showSnackbar(Strings.unknownError);
      // throw const ApiError(
      //   type: ErrorType.unknownError,
      //   error: Strings.unknownError,
      // );
    } on TimeoutException catch (e) {
      throw ApiError(
        type: ErrorType.connectTimeout,
        error: e.message?.toString() ?? Strings.connectionTimeout,
      );
    }
  }
}
