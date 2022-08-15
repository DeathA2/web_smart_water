
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:get/get.dart';
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/controller/app_controller.dart';
import 'package:web_smart_water/model/template/template_model.dart';
import 'package:web_smart_water/ui/item/template_web/fields/field.dart';
import 'package:web_smart_water/ui/widget/loading_screen.dart';
import 'package:web_smart_water/ui/widget/my_button.dart';
import 'package:web_smart_water/ui/widget/sweet_alert.dart';
class MyCreateView extends StatelessWidget{
  final TemplateModel model;
  final bool isNew;
  final TextStyle labelStyle =
  TextStyle(fontWeight: FontWeight.bold, fontSize: ThemeConfig.smallSize);
  MyCreateView({Key? key,required this.model,this.isNew = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        model.isLoading.value?
            const LoadingScreen()
        :Container(
          width: model.getEditViewTemplate()['width']??Get.width * 0.5,
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: ThemeConfig.defaultPadding/2),
                child: Divider(color: ThemeConfig.blackColor),
              ),
              _buildForm(context),
              _buildListButton(context),
            ],
          ),
        ));
  }

  Widget _buildListButton(context){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSaveButton(context),
        SizedBox(width: ThemeConfig.defaultPadding,),
        _buildCancelButton(context)
      ],
    );
  }

  Widget _buildTitle(){
    return Text(
      isNew?'Thêm mới ${model.getModelName()}':'${model.getValue('name')}',
      style: TextStyle(color: ThemeConfig.textColor,fontSize: ThemeConfig.headerSize),
    );
  }

  Widget _buildForm(context) {
    return ResponsiveGridRow(
      children: (model.getEditViewTemplate()['fields'] as List).map((e) => ResponsiveGridCol(
        lg: e['span'],
        child: MyField(field: e, view: isNew?'create':'edit', callback: (value) {
        }, model: model,),
      )).toList(),
    );
  }
  Widget _buildSaveButton(context) {
    return Obx(() => Center(
      child: MyButton(
        validate: model.isValidate.value,
        color: Colors.transparent,
        height: 40,
        width: 100,
        borderRadius: ThemeConfig.borderRadius/2,
        border: Border.all(color: model.isValidate.value?ThemeConfig.buttonPrimary:ThemeConfig.greyColor),
        margin:
        EdgeInsets.symmetric(horizontal: ThemeConfig.defaultHorPadding),
        childWidget: Text(
          'Save',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ThemeConfig.smallSize,
              color: model.isValidate.value?ThemeConfig.buttonPrimary:ThemeConfig.blackColor),
        ),
        callback: () async {
          if(!isNew) {
            model.update().then((value){
              if(value){
                model.updateData(model.data);
                appController.message = SweetAlert(
                  type: SweetAlertType.success,
                  message: 'Cập nhật ${model.getModelName()} thành công',
                  title: 'Thành công',
                );
                appController.pushNotificationStream.rebuildWidget(true);
                Navigator.of(context).pop(true);
              }else{
                appController.message = SweetAlert(
                  type: SweetAlertType.error,
                  message: 'Cập nhật ${model.getModelName()} không thành công',
                  title: 'Lỗi',
                );
                appController.pushNotificationStream.rebuildWidget(true);
              }
            });
          }else{
            model.create().then((value){
              if(value){
                model.updateData(model.data);
                appController.message = SweetAlert(
                  type: SweetAlertType.success,
                  message: 'Tạo ${model.getModelName()} thành công',
                  title: 'Thành công',
                );
                appController.pushNotificationStream.rebuildWidget(true);
                Navigator.of(context).pop(model);
              }else{
                appController.message = SweetAlert(
                  type: SweetAlertType.error,
                  message: 'Tạo ${model.getModelName()} không thành công',
                  title: 'Lỗi',
                );
                appController.pushNotificationStream.rebuildWidget(true);
              }
            });
          }
        },
      ),
    ));
  }

  Widget _buildCancelButton(context) {
    return Center(
      child: MyButton(
        isLoading: false,
        isCompleted: false,
        validate: true,
        color: Colors.transparent,
        border: Border.all(color: ThemeConfig.greyColor),
        height: 40,
        width: 100,
        borderRadius: ThemeConfig.borderRadius/2,
        margin:
        EdgeInsets.symmetric(horizontal: ThemeConfig.defaultHorPadding),
        childWidget: Text(
          'Cancel',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ThemeConfig.smallSize,
              color: ThemeConfig.textColor),
        ),
        callback: (){
          Navigator.of(context).pop();
        },
      ),
    );
  }
}