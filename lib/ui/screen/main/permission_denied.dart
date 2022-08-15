import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_smart_water/config/theme_config.dart';

class PermissionDeniedScreen extends StatelessWidget{
  const PermissionDeniedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg2.jpg'),
                  fit: BoxFit.cover,
                )
            ),),
          Container(
            padding: EdgeInsets.all(ThemeConfig.defaultPadding),
              decoration: BoxDecoration(
                color: ThemeConfig.whiteColor,
                borderRadius: BorderRadius.circular(ThemeConfig.borderRadius/2)
              ),
              child: Text('Bạn không có quyền truy cập trang',style: ThemeConfig.defaultStyle.copyWith(color: ThemeConfig.hoverTextColor),))
        ],
      ),
    );
  }
}