import 'dart:convert';

import 'package:dio/dio.dart';

import '../../utils/custom_interceptors.dart';

class UsersService {
  final String _baseUrl = "https://reqres.in/";
  final Dio _dio = Dio();

  UsersService() {
    _dio.interceptors.add(CustomInterceptors());
  }

  Future<Map<String, dynamic>> listUsers() async {
    try {
      var response = await _dio.get("${_baseUrl}api/users/");
      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = json.decode(ex.response.toString())["errorMessage"];
      throw Exception(errorMessage);
    }
  }
}
