import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:web_smart_water/controller/app_controller.dart';
import 'package:web_smart_water/model/template/template_model.dart';
import 'package:web_smart_water/ui/item/template_web/fields/dropdown_field.dart';
import 'package:web_smart_water/ui/item/template_web/fields/relation_field.dart';
import 'package:web_smart_water/ui/item/template_web/fields/text_field.dart';

class MyButtonFiled extends StatelessWidget{
  const MyButtonFiled({Key? key,required this.field,required this.model,required this.callback,required this.view}) : super(key: key);
  final Map field;
  final TemplateModel model;
  final MenuCallback callback;
  final String view;
  @override
  Widget build(BuildContext context) {
    switch(field['type']){
      case 'edit':
        return MyDropdownField(field: field, model: model, callback: callback, view: view);
      case 'delete':
        return MyRelationField(field: field, model: model, callback: callback, view: view);
      default:
        return MyTextField(field: field, model: model, callback: callback, view: view);
    }
  }

}