import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/controller/app_controller.dart';
class MyDropdown2 extends StatefulWidget{
  const MyDropdown2({Key? key,this.title,required this.callback,required this.data,this.hintext = '',this.value = ''}) : super(key: key);
  final Map<dynamic,dynamic> data;
  final String hintext;
  final value;
  final MenuCallback callback;
  final Widget ?title;
  @override
  State<MyDropdown2> createState() => _MyDropdown2State();
}

class _MyDropdown2State extends State<MyDropdown2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ThemeConfig.greyColor),
        borderRadius: BorderRadius.circular(ThemeConfig.borderRadius/2)
      ),
      child: Row(
        children: [
          widget.title??const SizedBox(),
          (widget.value !='' || widget.value == null)?Expanded(child: DropdownButtonFormField(
            value: widget.value,
            isExpanded: true,
            hint: Text(widget.hintext,style: TextStyle(fontSize: ThemeConfig.labelSize),),
            decoration: InputDecoration(
              errorBorder: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                      color: ThemeConfig.buttonPrimary.withOpacity(0.5),width: 2)),
              enabledBorder: InputBorder.none,
              errorMaxLines: 1,
              errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 12),
              hintText: widget.hintext,
              contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              hintStyle: TextStyle(
                  color: ThemeConfig.greyColor,
                  fontSize: ThemeConfig.labelSize
              ),
            ),
            isDense: true,
            onChanged: (newValue) {
              widget.callback(newValue);
            },
            items: widget.data.keys.map((e) => DropdownMenuItem(
              value: e,
              child: Text(widget.data[e]),
            )).toList(),
          )):
          Expanded(child: DropdownButtonFormField(
            isExpanded: true,
            hint: Text(widget.hintext,style: TextStyle(fontSize: ThemeConfig.labelSize),),
            decoration: InputDecoration(
              errorMaxLines: 1,
              errorBorder: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                      color: ThemeConfig.buttonPrimary.withOpacity(0.5),width: 2)),
              enabledBorder: InputBorder.none,
              errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 12),
              hintText: widget.hintext,
              contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              hintStyle: TextStyle(
                  color: ThemeConfig.greyColor,
                  fontSize: ThemeConfig.labelSize
              ),
            ),
            isDense: true,
            onChanged: (newValue) {
              widget.callback(newValue);
            },
            items: widget.data.keys.map((e) => DropdownMenuItem(
              value: e,
              child: Text(widget.data[e]),
            )).toList(),
          ))
        ],
      ),
    );
  }
}