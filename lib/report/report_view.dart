import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_smart_water/report/template_report.dart';

import '../controller/report_controller.dart';

class MyReportView extends StatelessWidget{
  MyReportView({Key? key, required this.controller,}) : super(key: key);
  final ReportController controller;
  final RxBool isEdit = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => TemplateReport(
        isEdit: isEdit.value,controller: controller,)),
      // floatingActionButton: _buildActionButton(context),
    );
  }
}