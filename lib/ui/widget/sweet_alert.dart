import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/controller/app_controller.dart';

class SweetAlert extends StatefulWidget{
  const SweetAlert({Key? key,this.type = SweetAlertType.success,this.title = '',required this.message}) : super(key: key);
  final SweetAlertType type;
  final String message;
  final String title;

  @override
  State<SweetAlert> createState() => _SweetAlertState();
}

class _SweetAlertState extends State<SweetAlert> with TickerProviderStateMixin{
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _fadeAnimation;
  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1.0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
    Future.delayed(const Duration(milliseconds: 100)).then((value) => _controller.forward());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5)).then((value){
      if(appController.pushNotificationStream.push){
        appController.pushNotificationStream.rebuildWidget(false);
      }
    });

    return SlideTransition(
        position:_offsetAnimation,
        child: Container(
          width: 400,
          height: 70,
          decoration: BoxDecoration(
              color: getColor(),
              borderRadius: BorderRadius.circular(ThemeConfig.borderRadius/2)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: ThemeConfig.defaultPadding),
                  child: Image.asset(getIcon(),color: ThemeConfig.whiteColor,height: 30,width: 30,)
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,
                      style: ThemeConfig.titleStyle.copyWith(color: ThemeConfig.whiteColor,fontWeight: FontWeight.bold),
                    ),
                    Text(widget.message,
                      style: ThemeConfig.smallStyle.copyWith(color: ThemeConfig.whiteColor,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: ThemeConfig.defaultPadding/2),
                  child: GestureDetector(
                      onTap: () => appController.pushNotificationStream.rebuildWidget(false),
                      child: Icon(Icons.close,color: ThemeConfig.whiteColor,size: ThemeConfig.defaultSize,))
              ),
            ],
          ),
        )
    );
  }

  Color getColor(){
    switch(widget.type){
      case SweetAlertType.success:
        return ThemeConfig.successColor;
      case SweetAlertType.error:
        return ThemeConfig.errorColor;
      default:
        return ThemeConfig.warningColor;
    }
  }

  String getIcon(){
    switch(widget.type){
      case SweetAlertType.success:
        return 'assets/img/success.png';
      case SweetAlertType.error:
        return 'assets/img/error.png';
      default:
        return 'assets/img/warning.png';
    }
  }
}

enum  SweetAlertType{
  success,error,warning
}