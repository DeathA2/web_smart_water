import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/controller/app_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    appController.loadingData();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeConfig.whiteColor,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Container(
              ),
            ),
          ),
        ],
      ),
    );
  }
}
