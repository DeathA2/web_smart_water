import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import "package:collection/collection.dart";
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../api/api.dart';
import '../config/app_config.dart';
import '../model/template/template_model.dart';
import '../utils/utils.dart';

class ReportController extends GetxController{
  RxBool isLoading = false.obs;
  late final RxList<TemplateModel> listDataModel = List<TemplateModel>.empty().obs;
  late TemplateModel typeModel = TemplateModel();
  final GlobalKey<SfDataGridState> keyGridView = GlobalKey<SfDataGridState>();
  late Map<dynamic,dynamic> template = {};
  late String titleName = '';
  late bool changeDate = true;
  late bool selectb2e = true;
  double rowHeight = 70;
  bool byShift  = false;
  String shift = '1';
  late String url = '';
  String urlUpdateApi = '';
  final TextEditingController beginController = TextEditingController();
  final TextEditingController endController= TextEditingController();
  DateTime begin = DateTime.now();
  DateTime end = DateTime.now();

  Future loadData() async{
   isLoading = true.obs;
   listDataModel.clear();
   List historyData = await api.getListHistoryAdmin(formatDateToString(begin, AppConfig.FORMAT_DATE_API),
       formatDateToString(end, AppConfig.FORMAT_DATE_API));
   listDataModel.addAll(historyData.map((e) => typeModel.fromJson(e)).toList());
   isLoading = false.obs;
  }

  Future<bool> updateReport() async{
    return false;
  }
}