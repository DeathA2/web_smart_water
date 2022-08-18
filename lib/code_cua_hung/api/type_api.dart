import 'dart:convert';
import 'package:dio/dio.dart';
import '../../api/api.dart';
import '../../controller/app_controller.dart';

mixin TypeApi on BaseApi{
  Future<List<dynamic>> getListType() async{
    const url = '/api/Admin/listType';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*'},
      ));
      if (response.statusCode == 200) {
        return response.data;
      } else {
        appController.errorLog = response.data['mess'];
        return [];
      }
    } catch (e) {
      saveLog(e);
      return [];
    }
  }
  Future<bool> createType(data) async {
    const url = '/api/Admin/createType';
    try {
      Response response = await dio.post(url, data: data, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*'},
      ));
      return true;
    } catch (e) {
      saveLog(e);
      return false;
    }
  }
  Future<bool> updateType(data) async {
    const url = '/api/Admin/editType';
    try {
      Response response = await dio.post(url, data: data, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*'},
      ));
      return true;
    } catch (e) {
      saveLog(e);
      return false;
    }
  }
  Future<bool> deleteType(String code) async{
    const url = '/api/Admin/deleteType';
    try {
      Response response = await dio.delete(url,queryParameters: {'code':code}, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*'},
      ));
      return true;
    } catch (e) {
      saveLog(e);
      return false;
    }
  }
}