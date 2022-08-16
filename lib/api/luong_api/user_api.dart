import 'package:dio/dio.dart';
import 'package:web_smart_water/api/api.dart';
import 'package:web_smart_water/controller/app_controller.dart';

mixin ListUserApi on BaseApi{
  Future<List<dynamic>> getListCustomerForEachAdmin() async{
    const url = '/api/Admin/getListCustomerForAdmin';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*', 'token': '1234567890'},
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


  Future<bool> createEditDataCustomer(data) async {
    const url = '/api/Admin/createEditCustomer';
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

  Future<bool> deleteDataCustomer(String street, String danhbo) async{
    const url = '/api/Admin/deleteCustomer';
    try {
      Response response = await dio.delete(url,queryParameters: {'street':street, 'danhbo':danhbo}, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*'},
      ));
      return true;
    } catch (e) {
      saveLog(e);
      return false;
    }
  }





  Future<bool> createEditStreet(data) async {
    const url = '/api/Admin/createEditStreet';
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

  Future<bool> deleteDataStreet(String code) async{
    const url = '/api/Admin/deleteCustomer';
    try {
      Response response = await dio.delete(url,queryParameters: {'code': code}, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*'},
      ));
      return true;
    } catch (e) {
      saveLog(e);
      return false;
    }
  }
}