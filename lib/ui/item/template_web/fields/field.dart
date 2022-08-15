import 'package:flutter/cupertino.dart';
import 'package:web_smart_water/controller/app_controller.dart';
import 'package:web_smart_water/model/template/template_model.dart';
import 'package:web_smart_water/ui/item/template_web/fields/boolean.dart';
import 'package:web_smart_water/ui/item/template_web/fields/dropdown_field.dart';
import 'package:web_smart_water/ui/item/template_web/fields/relation_field.dart';
import 'package:web_smart_water/ui/item/template_web/fields/text_dropdown_field.dart';
import 'package:web_smart_water/ui/item/template_web/fields/text_field.dart';

class MyField extends StatelessWidget{
  const MyField({Key? key,this.showlabel = true,required this.field,required this.model,required this.callback,required this.view}) : super(key: key);
  final Map field;
  final bool showlabel;
  final TemplateModel model;
  final MenuCallback callback;
  final String view;
  @override
  Widget build(BuildContext context) {
    switch(field['type']){
      case 'dropdown':
        return MyDropdownField(showLabel:showlabel,field: field, model: model, callback: callback, view: view);
      case 'relation':
        return MyRelationField(showLabel:showlabel,field: field, model: model, callback: callback, view: view);
      case 'text_dropdown_field':
        return MyTextDropdownField(showLabel:showlabel,field: field, model: model, callback: callback, view: view);
      case 'boolean':
        return MyBooleanField(showLabel:showlabel,field: field, model: model, callback: callback, view: view);
      default:
        return MyTextField(showLabel:showlabel,field: field, model: model, callback: callback, view: view,);
    }
  }

}