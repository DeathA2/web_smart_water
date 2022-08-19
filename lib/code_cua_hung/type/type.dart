import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:web_smart_water/code_cua_hung/type/type_view.dart';
import '../../config/theme_config.dart';
import '../../controller/app_controller.dart';

class TypeScreen extends StatelessWidget{
  TypeScreen({Key? key}) : super(key: key);
  final RxString currentCategory = 'type'.obs;
  final Map<String,Widget> optionWidget = {
    'type':const ListTypeView(),
  };
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildTitle(),
        SizedBox(height: ThemeConfig.defaultPadding/2,),
        LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: (Get.width >= 1000) ? 100 : 0, vertical: (Get.width >= 1000) ? 10 : 0),
            child: ListTypeView(),
          );
        })
      ],
    );
  }
  Widget _buildTitle(){
    return Padding(
      padding: EdgeInsets.only(top: ThemeConfig.defaultPadding/2),
      child: Row(
        children: [
          Text('Cấu hình',style: ThemeConfig.defaultStyle.copyWith(
              fontWeight: FontWeight.bold,color:ThemeConfig.hoverTextColor
          ),),
          Icon(Icons.chevron_right, size: ThemeConfig.defaultSize,color: ThemeConfig.blackColor,),
          Text(appController.currentRoute.value.label,style: ThemeConfig.defaultStyle.copyWith(
              fontWeight: FontWeight.bold,color:ThemeConfig.blackColor
          ),),
        ],
      ),
    );
  }
}