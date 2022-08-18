import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:web_smart_water/api/luong_api/user_api.dart';
import 'package:web_smart_water/code_cua_hung/api/account_api.dart';
import 'package:web_smart_water/code_cua_hung/api/login_api.dart';
import 'package:web_smart_water/config/app_config.dart';
import 'package:web_smart_water/controller/app_controller.dart';

import '../code_cua_hung/api/admin_history_api.dart';
import '../code_cua_hung/api/type_api.dart';

class BaseApi {
  Dio dio = Dio(BaseOptions(
    baseUrl: AppConfig.BASE_URL,
    connectTimeout: 300000,
    receiveTimeout: 300000,
  ));

  void saveLog(e) async {
    if (e.response != null) {
      if (e.response.statusCode == 500 ||
          e.response.statusCode == 502 ||
          e.response.statusCode == 404) {
        appController.errorLog = 'Lỗi hệ thống vui lòng thử lại sau!';
      } else if (e.response.statusCode == 401 ||
          e.response.statusCode == 403 ||
          e.response.statusCode == 404) {
        appController.errorLog = 'Bạn không có quyền thực hiện thao tác!';
      } else if (e.response.statusCode == 400) {
        appController.errorLog = 'Vui lòng kiểm tra lại thông tin đăng nhập';
      }
    } else {
      bool hasInternet = await InternetConnectionChecker().hasConnection;
      if (hasInternet) {
        appController.errorLog = e.error.message;
      } else {
        appController.errorLog = 'Kiểm tra lại kết nối mạng';
      }
    }
  }
}

class Api extends BaseApi
    with LogInApi,AccountApi,ListUserApi,TypeApi,AdminHistoryApi{}

final Api api = Api();