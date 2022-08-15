import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/controller/app_controller.dart';
import 'package:web_smart_water/model/template/template_model.dart';
import 'package:web_smart_water/ui/widget/selection_button_2.dart';

class MyRelationField extends StatelessWidget{
  const MyRelationField({Key? key,this.showLabel = true,required this.field,required this.model,required this.callback,required this.view}) : super(key: key);
  final Map field;
  final TemplateModel model;
  final MenuCallback callback;
  final String view;
  final bool showLabel;
  @override
  Widget build(BuildContext context) {
    return view.compareTo('edit') ==0?_buildFieldEdit():_buildFieldList();
  }
  final Widget _buildSpace = const SizedBox(height: 10);
  Widget _buildFieldEdit(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          MyDropdown2(
              value: model.getValue(field['field'])??'',
              title: Text('${field['label']} ${field['required']??false?'*':''}',style:TextStyle(fontWeight: FontWeight.bold,fontSize: ThemeConfig.smallSize),),
              data: field['list_string'],callback: (value){
            model.setValue(field['field'], value);
          }),
          _buildSpace
        ],
      ),
    );
  }
  Widget _buildFieldList(){
    return Text(model.getValue(field['field']).toString(),style: ThemeConfig.defaultStyle,);
  }
}