
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_smart_water/ui/item/template_web/list_view/data_list.dart';
import 'package:web_smart_water/ui/item/template_web/list_view/header.dart';

import '../../../../model/template/template_model.dart';

class MyListView extends StatelessWidget{
  MyListView({Key? key,required this.listDataModel,required this.template,required this.typeModel}) : super(key: key);
  final GlobalKey<SfDataGridState> keyGridView = GlobalKey<SfDataGridState>();
  final RxList<TemplateModel> listDataModel;
  final TemplateModel typeModel;
  final Map<dynamic,dynamic> template;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListViewHeader(
          callback: (param) async{
            if(param) {
              listDataModel.refresh();
            }
          },
          keyGridView: keyGridView,
          typeModel: typeModel,
          listDataModel: listDataModel,
          template: template,),
        Obx(() => listDataModel.isNotEmpty?MyDaTaList(
          keyGridView: keyGridView,
          typeModel: typeModel,
          listDataModel: listDataModel,
          template: template,):const SizedBox())
      ],
    );
  }
}