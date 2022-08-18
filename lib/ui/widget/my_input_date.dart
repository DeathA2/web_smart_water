
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/app_config.dart';
import '../../config/theme_config.dart';
import '../../controller/app_controller.dart';
class MyInputDate extends StatefulWidget{
  late TextEditingController controller;
  late DateTime date;
  final String label;
  final MenuCallback functionCallBack;
  final EdgeInsets ?padding;
  MyInputDate({Key? key,required this.controller,required this.date,required this.functionCallBack,this.label = '',this.padding}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MyInputDateState();
}

class _MyInputDateState extends State<MyInputDate>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.date,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != widget.date) {
      setState(() {
        widget.date = picked;
        widget.controller.text = DateFormat(AppConfig.DATE_USER_FOMAT).format(picked);
        widget.functionCallBack(widget.date);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
   return InkWell(
     onTap: () => _selectDate(context),
     child: Container(
       padding: widget.padding??EdgeInsets.symmetric(horizontal: 20),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(widget.label,style: ThemeConfig.smallStyle.copyWith(fontWeight: FontWeight.bold),),
           TextFormField(
             style: ThemeConfig.defaultStyle,
             controller: widget.controller,
             decoration: InputDecoration(
                 enabled: false,
                 hintText: widget.label,
                 hintStyle: ThemeConfig.labelStyle,
                 suffixIcon: const Icon(Icons.calendar_today),
                 contentPadding: ThemeConfig.contentPadding,
                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
             ),
           ),
         ],
       ),
     ),
   );
  }
}