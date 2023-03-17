import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DioService {
  static const baseApi = "https://620a799192946600171c5aa7.mockapi.io";

  static final BaseOptions _baseDioOption = BaseOptions(
      baseUrl: baseApi,
      headers: {'Content-type': 'application/json; charset=UTF-8'},
      connectTimeout: const Duration(seconds: 10), // 20 seconds
      receiveTimeout: const Duration(seconds: 10)
  );


  Future<String?> get({required String api, required Map<String, dynamic> params}) async {
    Dio dio = Dio(_baseDioOption);

    try {
      Response response = await dio.get(api, queryParameters: params);
      if (response.statusCode == 200) {
        return jsonEncode(response.data);
      }
      return null;
    } on DioError catch (e) {
      if(e.response?.data == null) {
        EasyLoading.showInfo('Internal server error or Please check your internet connection !!!', duration: const Duration(seconds: 5), dismissOnTap: true);
      }
      log('This is dio error --- ${jsonEncode(e.response?.data)}');
      return jsonEncode(e.response?.data);
    }
  }

  Future<String?> post({required String api, required Map<String, dynamic> params}) async {
    Dio dio = Dio(_baseDioOption);

    try {
      Response response = await dio.post(api, data: params);
      log(response.data.toString());
      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonEncode(response.data);
      }
      return null;
    } on DioError catch (e) {
      if(e.response?.data == null) {
        EasyLoading.showInfo('Internal server error or Please check your internet connection !!!', duration: const Duration(seconds: 5), dismissOnTap: true);
      }
      log(jsonEncode(e.response?.data));
      return jsonEncode(e.response?.data);
    }
  }

  Future<String?> postFormData({required String api, required FormData formData}) async {
    Dio dio = Dio(_baseDioOption);
    try {
      Response response = await dio.post(api, data: formData);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonEncode(response.data);
      }
      return response.data;
    } on DioError catch (e) {
      if(e.response?.data == null) {
        EasyLoading.showInfo('Internal server error or Please check your internet connection !!!', duration: const Duration(seconds: 5), dismissOnTap: true);
      }
      log(jsonEncode(e.response?.data));
      return jsonEncode(e.response?.data);
    }
  }

  Future<String?> putFormData({required String api, required FormData formData}) async {
    Dio dio = Dio(_baseDioOption);
    try {
      Response response = await dio.put(api, data: formData);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonEncode(response.data);
      }
      return response.data;
    } on DioError catch (e) {
      log(jsonEncode(e.response?.data));
      return jsonEncode(e.response?.data);
    }
  }

  Future<String?> put({required String api, required Map<String, dynamic> params}) async {
    Dio dio = Dio(_baseDioOption);

    try {
      Response response = await dio.put(api, data: jsonEncode(params));
      if (response.statusCode == 200) {
        return jsonEncode(response.data);
      }
      EasyLoading.dismiss();
      return null;
    } on DioError catch (e) {
      log(jsonEncode(e.response?.data));
      return jsonEncode(e.response?.data);
    }
  }

  Future<String?> delete({required String api, required Map<String, dynamic> params}) async {
    Dio dio = Dio(_baseDioOption);

    try {
      Response response = await dio.delete(api, data: jsonEncode(params));
      if (response.statusCode == 200 || response.statusCode == 204) {
        return jsonEncode(response.data);
      }
      EasyLoading.dismiss();
      return null;
    } on DioError catch (e) {
      log(jsonEncode(e.response?.data));
      return jsonEncode(e.response?.data);
    }
  }

}
