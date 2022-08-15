import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:web_smart_water/config/app_config.dart';
String formatDateTime(String dateTime){
  try{
    return DateFormat(AppConfig.DATE_FOMAT).format(
        DateFormat(AppConfig.DATE_FOMAT).parse(dateTime)
    );
  }catch(e){
    return dateTime;
  }
}

String formatDateTime2(String dateTime,String format){
  try{
    return DateFormat(AppConfig.DATE_FOMAT).format(
        DateFormat(format).parse(dateTime)
    );
  }catch(e){
    return dateTime;
  }
}

String formatDateToString(DateTime date,String format){
  return DateFormat(format).format(date);
}

String formatDate(String dateTime){
  try{
    return DateFormat(AppConfig.DATE_FOMAT.toString().split(' ')[0]).format(
        DateFormat(AppConfig.DATE_FOMAT).parse(dateTime)
    );
  }catch(e){
    return dateTime;
  }
}

String formatDateTimeFromDate(DateTime date){
  return DateFormat(AppConfig.DATE_FOMAT.split(' ')[0]).format(date);
}

String getDayOfWeek(DateTime date){
  return DateFormat('EE').format(date);
}

String formatDateTimeFromDateWithDayOfWeek(DateTime date){
  return '${getDayOfWeek(date)} ${formatDateTimeFromDate(date)}';
}

String getMoneyFormat(dynamic money, {int precision = 0}) {
  if (money == null) return '';

  var controller = MoneyMaskedTextController(decimalSeparator: (precision == 0) ? '' : ',', thousandSeparator: ',', precision: precision);

  controller.updateValue(money * 1.0);

  return controller.text;
}

bool checkDateTime(DateTime dateTime){
  String date = DateFormat(AppConfig.DATE_USER_FOMAT).format(dateTime);
  DateTime start = DateFormat(AppConfig.DATETIME_USER_FOMAT).parse('$date 07:59');
  DateTime end = DateFormat(AppConfig.DATETIME_USER_FOMAT).parse('$date 17:00');
  if(dateTime.isBefore(end) && dateTime.isAfter(start)){
    return true;
  }
  else {
    return false;
  }
}

double getSize(double size) {
  if (Get.context == null) return size;
  var shortestSide = Get.width > 900 ? 900 : Get.width;
  if (shortestSide < 600) {
    return size * (shortestSide / 600);
  } else {
    return size;
  }
}