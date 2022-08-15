import 'package:flutter/material.dart';
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/controller/app_controller.dart';
import 'package:web_smart_water/ui/widget/my_input.dart';
class MyDropDown extends StatefulWidget{
  final List<String> data;
  final String title;
  final String hintText;
  final bool disable;
  String initValue;
  final MenuCallback callback;

  MyDropDown({Key? key,
    this.title = '',
    required this.data,
    this.hintText = '',
    this.initValue = '',
    required this.callback,
    this.disable = false,}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyDropDownState();

}

class MyDropDownState extends State<MyDropDown>{
  final TextEditingController controller = TextEditingController();
  final GlobalKey _menuKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectWidget = _showPopup();
    controller.text = widget.initValue;
    return MyInput(
      callback: (){
        if(!widget.disable){
          dynamic state = _menuKey.currentState;
          state.showButtonMenu();
        }
      },
      suffix: selectWidget,
      controller: controller,
      hasTitle: true,
      title:Text(widget.title,style:TextStyle(fontWeight: FontWeight.bold,fontSize: ThemeConfig.smallSize),),
      hintText: widget.hintText,
      keyboardType:TextInputType.text,
      readOnly: true, callbackUpdate: (param) {
        widget.callback(widget.initValue);
    },
    );
  }

  _showModelBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (BuildContext context,StateSetter setState){
            return Container(
              color: Colors.white,
              child:  Wrap(
                children: widget.data.map((e) =>
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: ThemeConfig.greyColor)
                          )
                      ),
                      child: ListTile(
                          title: Text(e, style: const TextStyle(fontWeight: FontWeight.w900,),textAlign: TextAlign.center,),
                          onTap: (){
                            widget.initValue = e;
                            widget.callback(widget.initValue);
                            setState(() {});
                            Navigator.of(context).pop();
                          }),
                    )
                ).toList(),
              ),
            );
          });
        }).then((value){
          setState(() {

          });
    });
  }

  PopupMenuItem _buildDropdownActionItem(String value){
    return PopupMenuItem<String>(
      value: value,
      child: Text(
        value,
        style: TextStyle(
          color: ThemeConfig.textColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  _showPopup(){
    return PopupMenuButton(
      key: _menuKey,
      padding: EdgeInsets.zero,
      icon: Icon(Icons.arrow_drop_down,color: ThemeConfig.whiteColor,size: 20,),
      itemBuilder: (context) => widget.data.map((e) => _buildDropdownActionItem(e)).toList(),
      onSelected: (value) async{
        widget.initValue = value.toString();
        widget.callback(widget.initValue);
        setState(() {});
      },
    );
  }


}