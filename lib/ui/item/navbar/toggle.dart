import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_smart_water/config/route_config.dart';
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/controller/app_controller.dart';
class ToggleItem extends StatelessWidget{
  const ToggleItem({Key? key, required this.callback,required this.scaffoldKey}) : super(key: key);
  final MenuCallback callback;
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: ThemeConfig.whiteColor,
      child: ListView(
        children: RouteConfig().getNavbar().map((item){
          if(item.children.isEmpty){
            return _buildSingleButton(item);
          }else{
            return _buildMultipleButton(item);
          }
        }).toList(),
      ),
    );
  }

  Widget _buildSingleButton(RouteModel model){
    return InkWell(
      onTap: (){
        appController.changeRoute(model);
        Get.back();
        callback(model);
      },
      child: Container(
        width: 300,
        padding: EdgeInsets.symmetric(horizontal: ThemeConfig.defaultPadding,vertical: ThemeConfig.defaultPadding/2),
        color: (model.group == appController.currentRoute.value.group)?ThemeConfig.hoverTextColor.withOpacity(0.3):ThemeConfig.whiteColor,
        child: Text(model.label,
          style: ThemeConfig.titleStyle.copyWith(color: ThemeConfig.blackColor,fontWeight: FontWeight.bold),),
      ),
    );
  }

  Widget _buildMultipleButton(RouteModel model){
    RxBool isExpand = (model.group == appController.currentRoute.value.group).obs;
    return ExpansionTile(
      onExpansionChanged: (bool expanded){
        isExpand.value = expanded;
      },
      initiallyExpanded: model.group == appController.currentRoute.value.group,
      trailing: model.children.isEmpty?const SizedBox()
          :Obx(() => Icon(isExpand.value?Icons.arrow_drop_up_outlined:Icons.arrow_drop_down_outlined,
        color: ThemeConfig.blackColor,)),
      title:Text(model.label,
        style: ThemeConfig.titleStyle.copyWith(color: ThemeConfig.blackColor,fontWeight: FontWeight.bold),),
      children: model.children.map((button)  => InkWell(
        onTap: (){
          appController.changeRoute(button);
          Get.back();
          callback(button);
        },
        child: Container(
            color: (button.route == appController.currentRoute.value.route)?ThemeConfig.hoverTextColor.withOpacity(0.3):ThemeConfig.whiteColor,
            alignment: Alignment.centerLeft,
            width: 300,
            padding: EdgeInsets.symmetric(vertical: ThemeConfig.defaultPadding/2,horizontal: 2*ThemeConfig.defaultPadding),
            child: Text(button.label,style: ThemeConfig.titleStyle.copyWith(color: ThemeConfig.blackColor),textAlign: TextAlign.left,)
        ),
      )).toList(),
    );
  }
}