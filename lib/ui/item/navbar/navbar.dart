import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_smart_water/config/route_config.dart';
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/controller/app_controller.dart';
class NavbarItem extends StatefulWidget{
  const NavbarItem({Key? key,required this.callback,required this.scaffoldKey}) : super(key: key);
  final MenuCallback callback;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<NavbarItem> createState() => _NavbarItemState();
}

class _NavbarItemState extends State<NavbarItem> {
  @override
  void initState() {
    // window.addEventListener('resize',(event){
    //   checkResponsive();
    // });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return _buildNavbar();
  }

  // void checkResponsive(BoxConstraints constraints){
  //   appController.isSmall.value = (constraints.maxWidth <= 1200);
  // }

  Widget _buildNavbar(){
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      // checkResponsive(constraints);
      return Container(
        height: 70,
        decoration: BoxDecoration(
            color: ThemeConfig.primaryColor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            constraints.maxWidth <= 1200?_buildToggle():_buildListLeftButton(),
            _buildListRightButton()
          ],
        ),
      );
    },);
  }

  Widget _buildListLeftButton(){
    return Container(
      child: Row(
        children: [
          _buildLogo(),
          Row(
            children: RouteConfig().getNavbar().map((item){
              if(item.children.isEmpty){
                return _buildSingleButton(item);
              }else{
                return _buildMultipleButton(item,item.children);
              }
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildLogo(){
    return const SizedBox(width: 50,);
  }

  Widget _buildListRightButton(){
    final RouteModel route = RouteModel(route: '/admin', label: 'admin',group: '/admin',children: [
        RouteModel(route: '/logout', label: 'Đăng xuất',group: '/admin',children: [],screen: Container())
    ],screen: Container());
    return GestureDetector(
      onTapUp: (TapUpDetails details) async{
        double left = details.globalPosition.dx - details.localPosition.dx + ThemeConfig.defaultPadding/2;
        double top = details.globalPosition.dy - details.localPosition.dy + 50;
        await showMenu<RouteModel>(
          context: context,
          position: RelativeRect.fromLTRB(left,top,left,top),      //position where you want to show the menu on screen
          items: _buildDropdownList(route.children),
          elevation: 8.0,
        ).then<void>((RouteModel ?value) async{
          if(value != null) {
            await appController.resetLoginData();
            Get.offAllNamed('/login');
          }
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: ThemeConfig.defaultPadding/2),
        padding: EdgeInsets.symmetric(vertical: ThemeConfig.defaultPadding/2,horizontal: ThemeConfig.defaultPadding),
        decoration: BoxDecoration(
            color: (route.group == appController.currentRoute.value.group)?ThemeConfig.whiteColor.withOpacity(0.2):Colors.transparent,
            borderRadius: BorderRadius.circular(ThemeConfig.borderRadius/2)
        ),
        child: Row(
          children: [
            Text(route.label,style: ThemeConfig.titleStyle.copyWith(color: ThemeConfig.whiteColor,fontWeight: FontWeight.bold),),
            Icon(Icons.arrow_drop_down,color: ThemeConfig.whiteColor,size: 20,)
          ],
        ),
      ),
    );

  }

  Widget _buildSingleButton(RouteModel main){
    return Obx(() => InkWell(
      onTap: (){
        appController.changeRoute(main);
        widget.callback(main);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: ThemeConfig.defaultPadding/2),
        padding: EdgeInsets.symmetric(vertical: ThemeConfig.defaultPadding/2,horizontal: ThemeConfig.defaultPadding),
        decoration: BoxDecoration(
            color: main.group == appController.currentRoute.value.group?ThemeConfig.whiteColor.withOpacity(0.2):Colors.transparent,
            borderRadius: BorderRadius.circular(ThemeConfig.borderRadius/2)
        ),
        child: Text(main.label,style: ThemeConfig.titleStyle.copyWith(color: ThemeConfig.whiteColor,fontWeight: FontWeight.bold),),
      ),
    ));
  }

  Widget _buildMultipleButton(RouteModel main,List<RouteModel>listButton){
    return Obx(() => GestureDetector(
      onTapUp: (TapUpDetails details) async{
        double left = details.globalPosition.dx - details.localPosition.dx + ThemeConfig.defaultPadding/2;
        double top = details.globalPosition.dy - details.localPosition.dy + 50;
        await showMenu<RouteModel>(
          context: context,
          position: RelativeRect.fromLTRB(left,top,left,top),      //position where you want to show the menu on screen
          items: _buildDropdownList(listButton),
          elevation: 8.0,
        ).then<void>((RouteModel ?value) {
          if(value != null) {
            appController.changeRoute(value);
            widget.callback(value);
          }
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: ThemeConfig.defaultPadding/2),
        padding: EdgeInsets.symmetric(vertical: ThemeConfig.defaultPadding/2,horizontal: ThemeConfig.defaultPadding),
        decoration: BoxDecoration(
            color: (main.group == appController.currentRoute.value.group)?ThemeConfig.whiteColor.withOpacity(0.2):Colors.transparent,
          borderRadius: BorderRadius.circular(ThemeConfig.borderRadius/2)
        ),
        child: Row(
          children: [
            Text(main.label,style: ThemeConfig.titleStyle.copyWith(color: ThemeConfig.whiteColor,fontWeight: FontWeight.bold),),
            Icon(Icons.arrow_drop_down,color: ThemeConfig.whiteColor,size: 20,)
          ],
        ),
      ),
    ));
  }

  List<PopupMenuItem<RouteModel>> _buildDropdownList(List<RouteModel>listButton){
    return listButton.map((button) => PopupMenuItem(
      value: button,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ThemeConfig.defaultPadding/4,horizontal: ThemeConfig.defaultPadding/2),
        child: Text(button.label,style: ThemeConfig.defaultStyle.copyWith(color: ThemeConfig.blackColor),),
      ),
    )).toList();
  }

  Widget _buildToggle(){
    return Row(
      children: [
        _buildLogo(),
        InkWell(
          onTap: (){
            widget.scaffoldKey.currentState!.openDrawer();
          },
          child: Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ThemeConfig.whiteColor,
              borderRadius: BorderRadius.circular(ThemeConfig.borderRadius/2)
            ),
            child: Icon(Icons.menu,color: ThemeConfig.blackColor,size: ThemeConfig.titleSize,),
          ),
        ),
      ],
    );
  }
}