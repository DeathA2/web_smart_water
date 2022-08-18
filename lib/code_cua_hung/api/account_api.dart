import 'dart:convert';

import 'package:dio/dio.dart';
import '../../api/api.dart';
import '../../controller/app_controller.dart';

mixin AccountApi on BaseApi{
  Future<List<dynamic>> getListAccountConfig() async{
    const url = '/api/User/getListUser';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'text/plain', 'accept': '*/*', 'token':appController.token},
      ));
      if (response.statusCode == 200) {
        return jsonDecode(response.data) as List<dynamic>;
      } else {
        appController.errorLog = response.data['mess'];
        return [];
      }
    } catch (e) {
      saveLog(e);
      return [];
    }
  }
  Future<bool> createDataAccountConfig(data) async {
    const url = '/api/User/createUser';
    try {
      Response response = await dio.post(url, data: data, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*', 'token' : appController.token},
      ));
      return true;
    } catch (e) {
      saveLog(e);
      return false;
    }
  }
  Future<bool> updateDataAccountConfig(data) async {
    const url = '/api/User/editUser';
    try {
      Response response = await dio.post(url, data: data, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*', 'token' : appController.token},
      ));
      return true;
    } catch (e) {
      saveLog(e);
      return false;
    }
  }
  Future<bool> deleteDataAccountConfig(String user) async{
    const url = '/api/User/deleteUser';
    try {
      Response response = await dio.delete(url,queryParameters: {'user':user}, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*', 'token' : appController.token},
      ));
      return true;
    } catch (e) {
      saveLog(e);
      return false;
    }
  }
}