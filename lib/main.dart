
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:web_smart_water/config/app_config.dart';
import 'package:web_smart_water/config/route_config.dart';
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/controller/app_controller.dart';
void main() async{
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // appController.loadingData(false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GetMaterialApp(
      color: ThemeConfig.background2,
      debugShowCheckedModeBanner: false,
      localizationsDelegates:const[
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(
        fontFamily: ThemeConfig.fontFamily,
        backgroundColor:ThemeConfig.background2,
        textTheme: GoogleFonts.robotoTextTheme(textTheme).copyWith(
            headline1:ThemeConfig.headerStyle.copyWith(fontWeight: FontWeight.bold),
            bodyText1:ThemeConfig.defaultStyle,
            bodyText2: ThemeConfig.defaultStyle
        ),
      ),
      title: AppConfig.APP_NAME,
      initialRoute: '/login',
      getPages: RouteConfig().getRoute,
    );
  }
}