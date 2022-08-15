import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Row,Border;
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/model/template/template_model.dart';
import 'package:web_smart_water/ui/item/template_web/create_view.dart';
import 'package:web_smart_water/ui/item/template_web/import.dart';

import '../../../../controller/app_controller.dart';

class ListViewHeader extends StatelessWidget{
  ListViewHeader({Key? key,this.titleName,required this.callback,required this.keyGridView,required this.listDataModel,required this.template,required this.typeModel}) : super(key: key);
  final RxList<TemplateModel> listDataModel;
  final TemplateModel typeModel;
  final GlobalKey<SfDataGridState> keyGridView;
  final Map<dynamic,dynamic> template;
  final MenuCallback callback;
  final String ?titleName;
  final RxBool isEdit = false.obs;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ThemeConfig.defaultPadding/4),
      margin: EdgeInsets.only(bottom: ThemeConfig.defaultPadding),
      color: ThemeConfig.greyColor.withOpacity(0.2),
      child: Row(
        children: [
          Expanded(child: Text(
            titleName??'${typeModel.getModelName()}',
            style: ThemeConfig.defaultStyle.copyWith(fontWeight: FontWeight.bold),
          )),
          _buildHeaderButton(context),
        ],
      ),
    );
  }
  Widget _buildHeaderButton(context){
    if((template['buttons'] as List).isEmpty){
      return const SizedBox();
    }else{
      return Obx(() => _buildHeaderActionDropdown(context));
    }
  }
  Widget _buildHeaderActionDropdown(context){
    return isEdit.value?_buildEditActionButton(context):Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFirstButton((template['buttons'] as List)[0], context),
          (template['buttons'] as List).length >2?PopupMenuButton<dynamic>(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.arrow_drop_down,color: ThemeConfig.blackColor,size: 20,),
            itemBuilder: (context) => (template['buttons'] as List).getRange(1,(template['buttons'] as List).length).map((e) => _buildDropdownActionItem(e,context)).toList(),
            onSelected: (value) async{
              switch(value){
                case 'create':
                  _buildActionCreate(context);
                  break;
                case 'import':
                  _buildActionImport(context);
                  break;
                default:
                  _buildActionExport(context);
              }
            },
          ):const SizedBox()
        ],
      ),
    );
  }
  PopupMenuItem _buildDropdownActionItem(Map<String,dynamic> button,context){
    return PopupMenuItem(
      value: button['type'],
      child: Row(
        children: [
          Icon(
            (button['icon'] as IconData),
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            (button['label'] as String),
            style: TextStyle(
              color: ThemeConfig.textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditActionButton(context){
    return Row(
      children: [
        _buildCancelButton(),
        _buildSaveButton(),
      ],
    );
  }

  Widget _buildCancelButton(){
    return InkWell(
      onTap: () async {
        for(TemplateModel model in listDataModel){
          model.initValue();
        }
        isEdit.value = false;
        callback({'is_edit':false});
      },
      child: Container(
        width: 150,
        padding: EdgeInsets.symmetric(vertical: ThemeConfig.defaultPadding/4,horizontal: ThemeConfig.defaultPadding/2),
        margin: EdgeInsets.symmetric(horizontal: ThemeConfig.defaultPadding/2),
        decoration: BoxDecoration(
          color: ThemeConfig.greyColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(ThemeConfig.borderRadius/2)
        ),
        child: Row(
          children: [
            Icon(
             Icons.cancel_outlined,
              size: 20,
              color: ThemeConfig.whiteColor,
            ),
            const SizedBox(width: 10),
            Text(
              'Cancel',
              style: TextStyle(
                color: ThemeConfig.whiteColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton(){
    return InkWell(
      onTap: (){
        isEdit.value = false;
        callback({'is_edit':false});
      },
      child: Container(
        width: 150,
        padding: EdgeInsets.symmetric(vertical: ThemeConfig.defaultPadding/4,horizontal: ThemeConfig.defaultPadding/2),
        margin: EdgeInsets.symmetric(horizontal: ThemeConfig.defaultPadding/2),
        decoration: BoxDecoration(
            color: ThemeConfig.buttonPrimary.withOpacity(0.9),
            borderRadius: BorderRadius.circular(ThemeConfig.borderRadius/2)
        ),
        child: Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 20,
              color: ThemeConfig.whiteColor,
            ),
            const SizedBox(width: 10),
            Text(
              'Save',
              style: TextStyle(
                color: ThemeConfig.whiteColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstButton(Map<String,dynamic> button,context){
    return InkWell(
      onTap: (){
        switch(button['type']){
          case 'create':
            _buildActionCreate(context);
            break;
          case 'import':
            _buildActionImport(context);
            break;
          case 'edit':
            _buildActionEdit(context);
            break;
          default:
            _buildActionExport(context);
        }
      },
      child: Container(
        padding: EdgeInsets.all(ThemeConfig.defaultPadding/4),
        decoration: BoxDecoration(
          border:Border.all(color: ThemeConfig.greyColor)
        ),
        child: Icon(
          (button['icon'] as IconData),
          size: ThemeConfig.titleSize,
          color: ThemeConfig.blackColor,
        ),
      ),
    ) ;
  }

  _buildActionCreate(context){
    return  showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            content: MyCreateView(model: typeModel.getEmptyModel(),isNew: true,),
          );
        }).then((value){
      if(value != null){
        listDataModel.add(value);
        callback(true);
      }
    });
  }
  _buildActionEdit(context){
    isEdit.value = true;
    callback({'is_edit':true});
  }
  _buildActionImport(context){
    return  showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return ImportScreen(typeModel: typeModel,listDataModel: listDataModel);
        }).then((value){
          callback(true);
    });
  }

  _buildActionExport(context){
    return  _exportExcel(context);
  }

  Future<void> _exportExcel(context) async {
    final Workbook workbook = keyGridView.currentState!.exportToExcelWorkbook();
    final Style globalStyle = workbook.styles.add('globalStyle');
    globalStyle.fontName = 'Times New Roman';
    final Worksheet sheet = workbook.worksheets[0];
    sheet.insertRow(1, 1, ExcelInsertOptions.formatAsAfter);
    sheet.insertRow(1, 1, ExcelInsertOptions.formatAsAfter);
    sheet.getRangeByName('B1:H1').merge();
    sheet.getRangeByName('B1:H1').cellStyle.hAlign = HAlignType.left;
    sheet.getRangeByName('B1:H1').cellStyle.bold = true;
    sheet.getRangeByName('B1').setText('List ${typeModel.getModelName()}');
    bool checkColDelete = (typeModel.getListViewTemplate()['fields'] as List).where((element) => element['field'] == 'action_button').isNotEmpty;
    if(checkColDelete) {
      sheet.deleteColumn(
          (typeModel.getListViewTemplate()['fields'] as List).length);
    }
    final List<int> bytes = workbook.saveAsStream();
    String path = await FileSaver.instance.saveFile('List ${typeModel.getModelName()}',Uint8List.fromList(bytes),'xlsx',mimeType: MimeType.MICROSOFTEXCEL);
    print(path);
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Download successfully'),
          content: Text('Download successfully'),
          actions: [
            CupertinoDialogAction(
                onPressed: Get.back,
                child: const Text('OK')
            )
          ],
        );
      },
    );

  }
}