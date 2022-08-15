// import 'package:lda_web/all_file.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lda_web/ui/item/template_web/report/header.dart';
//
// class MyReportView extends StatelessWidget{
//   MyReportView({Key? key, required this.controller,}) : super(key: key);
//   final ReportController controller;
//   final RxBool isEdit = false.obs;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ListViewHeaderReport(
//             callback: (param){
//               if(param != true){
//                 isEdit.value = param['is_edit'];
//               }
//             },
//             controller: controller,
//             ),
//           Expanded(
//               child: Obx(() => TemplateReport(
//                 isEdit: isEdit.value,controller: controller,))),
//         ],
//       ),
//       // floatingActionButton: _buildActionButton(context),
//     );
//   }
// }