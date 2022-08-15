import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_smart_water/config/list_string_config.dart';
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/controller/app_controller.dart';
import 'package:web_smart_water/model/template/template_model.dart';
import 'package:web_smart_water/ui/item/template_web/fields/dropdown_field.dart';
import 'package:web_smart_water/ui/item/template_web/fields/text_field.dart';
class MyTextDropdownField extends StatelessWidget{
  const MyTextDropdownField({Key? key,this.showLabel = true,required this.field,required this.model,required this.callback,required this.view}) : super(key: key);
  final Map field;
  final TemplateModel model;
  final MenuCallback callback;
  final String view;
  final bool showLabel;
  @override
  Widget build(BuildContext context) {
    return (view.compareTo('edit') ==0 || view.compareTo('create') ==0)?_buildFieldEdit():_buildFieldList();
  }
  final Widget _buildSpace = const SizedBox(height: 10);

  Widget _buildFieldEdit(){
    return Column(
      children: [
        (view.compareTo('edit') == 0 &&  field['readOnly']==true)
            ?_buildEditReadOnly():view.compareTo('edit') == 0
            ?MyDropdownField(field: field, model: model, callback: callback, view: view)
            :MyTextField(field: field, model: model, callback: callback, view: view),
        _buildSpace
      ],
    );
  }
  Widget _buildFieldList(){
    return Text(ListStringConfig.getValueInList(field['list_string'],model.getValue(field['field'])),style: ThemeConfig.defaultStyle,);
  }

  Widget _buildEditReadOnly(){
    return MyTextField(showLabel:showLabel,field: field, model: model, callback: callback, view: view,);
  }
}