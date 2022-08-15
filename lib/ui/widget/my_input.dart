import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/controller/app_controller.dart';
class MyInput extends StatefulWidget {
  final bool hasTitle;
  final title;
  bool obscureText;
  final bold;
  final String hintText;
  String ?initValue;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffix;
  late EdgeInsetsGeometry? padding;
  final int maxLength;
  final double? fontSize;
  final contendPadding;
  final int maxLine;
  final validate;
  final readOnly;
  final TextEditingController ?controller;
  final FocusNode? focus;
  final MenuCallback callbackUpdate;
  final GestureTapCallback? callback;
  final TextAlign textAlign;

  MyInput(
      {Key? key,
      required this.keyboardType,
        this.textAlign = TextAlign.left,
      this.title,
      this.hasTitle = false,
      this.hintText = '',
      this.obscureText = false,
      this.prefixIcon,
      this.focus,
      this.suffix,
      this.padding,
      this.fontSize,
      this.maxLine = 1,
      this.contendPadding,
        this.controller,
      this.bold = FontWeight.normal,
      this.validate = true,
      this.maxLength = 100,

        required this.callbackUpdate,
      this.callback, this.initValue,
      this.readOnly = false})
      : super(key: key);

  @override
  _MyInputState createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: ThemeConfig.greyColor),
        borderRadius: BorderRadius.circular(ThemeConfig.borderRadius/2)
      ),
      child: Row(
        children: [
         widget.hasTitle?widget.title:const SizedBox(),
          Expanded(child: TextFormField(
            validator: (value) {
              if ((value == null || value == '') && widget.validate) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: widget.controller,
            initialValue: widget.initValue,
            focusNode: widget.focus,
            onTap: widget.callback,
            readOnly: widget.readOnly,
            textAlign: widget.textAlign,
            style: TextStyle(
                fontSize: widget.fontSize ?? ThemeConfig.defaultSize,
                fontWeight: widget.bold),
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            maxLines: widget.maxLine,
            onChanged: (value){
              widget.callbackUpdate(value);
            },
            decoration: InputDecoration(
              filled: true,
                fillColor: widget.readOnly?ThemeConfig.greyColor.withOpacity(0.3):Colors.transparent,
                suffixIcon: widget.suffix,
                contentPadding:EdgeInsets.symmetric(horizontal: ThemeConfig.defaultPadding),
                hintText: widget.hintText,
                hintStyle: TextStyle(
                    fontSize: ThemeConfig.labelSize,
                    fontWeight: FontWeight.normal),
              errorBorder: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                      color: ThemeConfig.buttonPrimary.withOpacity(0.5),width: 2)),
              enabledBorder: InputBorder.none,
            ),
          )),
        ],
      ),
    );
  }
}
