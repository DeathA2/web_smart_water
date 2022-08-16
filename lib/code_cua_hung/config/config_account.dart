import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../../config/theme_config.dart';
import '../../controller/app_controller.dart';
import 'account_view.dart';

class ConfigAccountScreen extends StatelessWidget{
  ConfigAccountScreen({Key? key}) : super(key: key);
  final RxString currentCategory = 'account'.obs;
  final Map<String,Widget> optionWidget = {
    'account':const ListAccountView(),
  };
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildTitle(),
        SizedBox(height: ThemeConfig.defaultPadding/2,),
        LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
            child: ListAccountView(),
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