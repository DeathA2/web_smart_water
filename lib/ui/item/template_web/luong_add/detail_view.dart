
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:get/get.dart';
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/controller/app_controller.dart';
import 'package:web_smart_water/model/template/template_model.dart';
import 'package:web_smart_water/ui/item/template_web/fields/field.dart';
import 'package:web_smart_water/ui/item/template_web/luong_add/detail.dart';
import 'package:web_smart_water/ui/widget/loading_screen.dart';
import 'package:web_smart_water/ui/widget/my_button.dart';
import 'package:web_smart_water/ui/widget/my_input.dart';
import 'package:web_smart_water/ui/widget/sweet_alert.dart';
class MyDetailView extends StatelessWidget{
  final TemplateModel model;
  final bool isNew;
  final TextStyle titleStyle =
  TextStyle(fontSize: ThemeConfig.smallSize, color: ThemeConfig.blackColor.withOpacity(0.7));
  final TextStyle contentStyle =
  TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87);
  MyDetailView({Key? key,required this.model,this.isNew = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
    model.isLoading.value?
    const LoadingScreen()
        :Container(
      width: model.getEditViewTemplate()['width']??Get.width * 0.75,
      height: Get.height * 0.75,
      // padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: ThemeConfig.defaultPadding/2),
            child: Divider(color: ThemeConfig.blackColor),
          ),
          _buildView(context),
          Padding(
            padding: EdgeInsets.symmetric(vertical: ThemeConfig.defaultPadding/2),
            child: Divider(color: ThemeConfig.blackColor),
          ),
          _buildListButton(context),
        ],
      ),
    ));
  }

  Widget _buildListButton(context){
    return  _buildCloseButton(context);
  }

  Widget _buildTitle(){
    return Text(
      "Chi tiết khách hàng",
      style: TextStyle(color: ThemeConfig.textColor,fontSize: ThemeConfig.headerSize),
    );
  }

  Widget _buildView(context) {
    return Center(
      child: SizedBox(
        width: Get.width * 0.7,
        height: Get.height * 0.5,
        child: SingleChildScrollView(
          child: _buildDetailMobile(),
          // child: (Get.width >= 1100) ? Column(
          //   children: [
          //     Row(
          //       children: [
          //         Expanded(
          //             child: Row(
          //               children: [
          //                 Text("Mã đường:   ", style: titleStyle,),
          //                 Text("${model.data['stress']}", style: contentStyle),
          //               ],
          //             )
          //         ),
          //         Expanded(
          //             child: Row(
          //               children: [
          //                 Text("Người quản lý:   ", style: titleStyle,),
          //                 Text("${model.data['username']}", style: contentStyle),
          //               ],
          //             )
          //         ),
          //         const Expanded(child: SizedBox())
          //       ],
          //     ),
          //     _buildSpace,
          //     Row(
          //       children: [
          //         Expanded(
          //             child: Row(
          //               children: [
          //                 Text("Id khách hàng:   ", style: titleStyle,),
          //                 Text("${model.data['idkh']}", style: contentStyle),
          //               ],
          //             )
          //         ),
          //         Expanded(
          //             child: Row(
          //               children: [
          //                 Text("Mã danh bộ:   ", style: titleStyle,),
          //                 Text("${model.data['danhbo']}", style: contentStyle),
          //               ],
          //             )
          //         ),
          //         const Expanded(child: SizedBox())
          //       ],
          //     ),
          //     _buildSpace,
          //     Row(
          //       children: [
          //         Expanded(
          //             child: Row(
          //               children: [
          //                 Text("Tên khách hàng:   ", style: titleStyle,),
          //                 Text("${model.data['tenkh']}", style: contentStyle),
          //               ],
          //             )
          //         ),
          //         Expanded(
          //             child: Row(
          //               children: [
          //                 Text("Số điện thoại:   ", style: titleStyle,),
          //                 Text("${model.data['sdt']}", style: contentStyle),
          //               ],
          //             )
          //         ),
          //         const Expanded(child: SizedBox())
          //       ],
          //     ),
          //     _buildSpace,
          //     Row(
          //       children: [
          //         Text("Địa chỉ:   ", style: titleStyle,),
          //         Text("${model.data['diachi']}", style: contentStyle),
          //       ],
          //     ),
          //     _buildSpace,
          //     Row(
          //       children: [
          //         Expanded(
          //             child: Row(
          //               children: [
          //                 Text("Loại giá:   ", style: titleStyle,),
          //                 Text("${model.data['loaigia']}", style: contentStyle),
          //               ],
          //             )
          //         ),
          //         Expanded(
          //             child: Row(
          //               children: [
          //                 Text("Số nhân khẩu:   ", style: titleStyle,),
          //                 Text("${model.data['sonk']}", style: contentStyle),
          //               ],
          //             )
          //         ),
          //         const Expanded(child: SizedBox())
          //       ],
          //     ),
          //     _buildSpace,
          //     Row(
          //       children: [
          //         Expanded(
          //             child: Row(
          //               children: [
          //                 Text("Serial module:   ", style: titleStyle,),
          //                 Text("${model.data['serialmodule']}", style: contentStyle),
          //               ],
          //             )
          //         ),
          //         Expanded(
          //             child: Row(
          //               children: [
          //                 Text("Serial đồng hồ:   ", style: titleStyle,),
          //                 Text("${model.data['serialdh']}", style: contentStyle),
          //               ],
          //             )
          //         ),
          //         const Expanded(child: SizedBox())
          //       ],
          //     ),
          //     _buildSpace,
          //     Row(
          //       children: [
          //         Expanded(
          //             child: Row(
          //               children: [
          //                 Text("Hiệu đồng hồ:   ", style: titleStyle,),
          //                 Text("${model.data['hieudh']}", style: contentStyle),
          //               ],
          //             )
          //         ),
          //         Expanded(
          //             child: Row(
          //               children: [
          //                 Text("Kích cỡ đồng hồ:   ", style: titleStyle,),
          //                 Text("${model.data['kichcodh']}", style: contentStyle),
          //               ],
          //             )
          //         ),
          //         Expanded(child: Row(
          //           children: [
          //             Text("Vị trí đồng hồ:   ", style: titleStyle,),
          //             Text("${model.data['vitridh']}", style: contentStyle,)
          //           ],
          //         ))
          //       ],
          //     ),
          //     _buildSpace,
          //     Row(
          //       children: [
          //         Expanded(
          //             child: Row(
          //               children: [
          //                 Text("Kinh độ:   ", style: titleStyle,),
          //                 Text("${model.data['longitude']}", style: contentStyle),
          //               ],
          //             )
          //         ),
          //         Expanded(
          //             child: Row(
          //               children: [
          //                 Text("Vĩ độ:   ", style: titleStyle,),
          //                 Text("${model.data['latitude']}", style: contentStyle),
          //               ],
          //             )
          //         ),
          //         const Expanded(child: SizedBox())
          //       ],
          //     ),
          //     _buildSpace,
          //   ],
          // ) : _buildDetailMobile(),
        ),
      ),
    );
  }

  final Widget _buildSpace = const SizedBox(height: 10);

  Widget _buildDetailMobile(){
    return ResponsiveGridRow(
      children: (model.getEditViewTemplate()['fields'] as List).map((e) => ResponsiveGridCol(
        lg: e['span'],
        child: DetailField(showLabel: true,field: e, view: isNew?'create':'edit', callback: (value) {
        }, model: model,),
      )).toList(),
    );
  }

  Widget _buildCloseButton(context) {
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
          'Close',
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