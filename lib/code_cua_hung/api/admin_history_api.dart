import 'package:dio/dio.dart';
import '../../api/api.dart';
import '../../controller/app_controller.dart';

mixin AdminHistoryApi on BaseApi{
  Future<List<dynamic>> getListHistoryAdmin(begin, end) async{
    const url = '/api/Admin/getListHistoryAdmin';
    try {
      Response response = await dio.get(url,queryParameters: {'begin':begin, 'end':end}, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*', 'token':appController.token},
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
}