import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_smart_water/config/list_string_config.dart';
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/controller/app_controller.dart';
import 'package:web_smart_water/model/template/template_model.dart';
import 'package:web_smart_water/ui/widget/my_input.dart';

class DetailField extends StatelessWidget {
  const DetailField(
      {Key? key,
        this.showLabel = true,
        required this.field,
        required this.model,
        required this.callback,
        required this.view})
      : super(key: key);
  final Map field;
  final TemplateModel model;
  final MenuCallback callback;
  final String view;
  final bool showLabel;
  @override
  Widget build(BuildContext context) {
    return _buildFieldEdit();
  }

  final Widget _buildSpace = const SizedBox(height: 10);
  final Widget _buildSpaceRow = const SizedBox(width: 20);

  Widget _buildFieldEdit() {
    final TextStyle titleStyle =
    TextStyle(fontSize: ThemeConfig.smallSize, color: ThemeConfig.blackColor.withOpacity(0.7));
    final TextStyle contentStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: ThemeConfig.primaryColor);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(field['label'], style: titleStyle,),
              _buildSpaceRow,
              Flexible(child: Text(getInitValue(), style: contentStyle, softWrap: true,))
            ],
          ),
          _buildSpace
        ],
      ),
    );
  }

  String getInitValue() {
    if (field['type'] == 'dropdown') {
      return ListStringConfig.getValueInList(
          field['list_string'], model.getValue(field['field']));
    } else {
      return model.getValue(field['field']).toString();
    }
  }

  Widget _buildFieldList() {
    Alignment textAlign = (model.getValue(field['field']) is int ||
        model.getValue(field['field']) is double)
        ? Alignment.center
        : Alignment.centerLeft;
    return Align(
        alignment: textAlign,
        child: Text(model.getValue(field['field']).toString(),
            style: ThemeConfig.defaultStyle));
  }
}
