import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/controller/app_controller.dart';
import 'package:web_smart_water/controller/home_controller.dart';
import 'package:web_smart_water/ui/item/footer/footer.dart';
import 'package:web_smart_water/ui/item/navbar/navbar.dart';

import '../../item/navbar/toggle.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeController controller = Get.put(HomeController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => appController.isLoading.value
        ?const Center(child: CircularProgressIndicator())
        :
    Scaffold(
      key: _scaffoldKey,
      drawer: ToggleItem(
        scaffoldKey: _scaffoldKey,
        callback: (value) {
          appController.changeRoute(value);
        },
      ),
      body: Column(
        children: [
          NavbarItem(
            scaffoldKey: _scaffoldKey,
            callback: (value) {
              appController.changeRoute(value);
            },
          ),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ThemeConfig.defaultPadding / 2),
                  child: Stack(
                      children: [
                        _buildWidgetFocus(),
                        StreamBuilder(
                            stream: appController.pushNotificationStream.rebuildStream,
                            initialData: false,
                            builder: (context, snapshot){
                              if(snapshot.data == true){
                                return Positioned(
                                    bottom: ThemeConfig.defaultPadding,
                                    right: ThemeConfig.defaultPadding,
                                    child: appController.message);
                              }else{
                                return const SizedBox();
                              }
                            })
                      ]
                  ))),
          const FooterItem()
        ],
      ),
    ));
  }

  Widget _buildWidgetFocus() {
    return appController.currentRoute.value.screen;
  }
}
