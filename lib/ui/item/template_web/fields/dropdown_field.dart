import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_smart_water/config/list_string_config.dart';
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/controller/app_controller.dart';
import 'package:web_smart_water/model/template/template_model.dart';
import 'package:web_smart_water/ui/item/template_web/fields/text_field.dart';
import 'package:web_smart_water/ui/widget/selection_button_2.dart';
class MyDropdownField extends StatelessWidget{
  const MyDropdownField({Key? key,this.showLabel = true,required this.field,required this.model,required this.callback,required this.view}) : super(key: key);
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
        (view.compareTo('edit') == 0 &&  field['readOnly']==true)?_buildEditReadOnly():Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: MyDropdown2(
              value: model.getValue(field['field'])??'',
              hintext: field['label'],
              title: showLabel?
              Container(
                alignment: Alignment.center,
                width: Get.width * 0.1,
                height: 50,
                decoration: BoxDecoration(
                    color: ThemeConfig.greyColor.withOpacity(0.2),
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(ThemeConfig.borderRadius/2)
                    )
                ),
                child: Text(
                  '${field['label']} ${field['required']??false?'*':''}',
                  style: ThemeConfig.smallStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              )
                  :const SizedBox(),
              data: ListStringConfig.getListString(field['list_string']),callback: (value){
            model.setValue(field['field'], value);
          }),
        ),
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