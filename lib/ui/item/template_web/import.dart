import 'dart:html';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/model/template/template_model.dart';
import 'package:web_smart_water/ui/widget/my_button.dart';
import 'package:web_smart_water/ui/widget/selection_button_2.dart';
import 'package:web_smart_water/ui/widget/theme.dart';

class ImportScreen extends StatelessWidget{
  ImportScreen({Key? key,required this.typeModel,required this.listDataModel}) : super(key: key);
  final RxList<TemplateModel> listDataModel;
  final TemplateModel typeModel;
  late Sheet sheet;
  final RxBool isReadFileSuccess = false.obs;
  final RxBool isLoading = false.obs;
  RxString fileName = ''.obs;
  int totalRecordImport = 0;
  List<TemplateModel> listError = [];
  List<TemplateModel> listSuccess = [];
  FilePickerResult ?filePickerResult;
  Map<String,String> mapColumn = {};
  List<String> columns = [];
  List<DataColumn> listCol = [];
  List<String> rowData = [];
  RxBool hasFile = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyTheme(
        isLoading: isLoading,
        body: _buildMain(context),
      ),
    );
  }

  Widget _buildMain(context){
    return Container(
      padding: EdgeInsets.all(ThemeConfig.defaultPadding),
      child: ListView(
        children: [
          Text('Import ${typeModel.getModelName()}',
            style: TextStyle(fontSize: ThemeConfig.headerSize,fontWeight: FontWeight.bold),
          ),
          SizedBox(height: ThemeConfig.defaultPadding/2,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                child: MyButton(
                  validate: true,
                  height: 40,
                  width: 200,
                  borderRadius: ThemeConfig.borderRadius,
                  color: ThemeConfig.buttonPrimary,
                  callback: ()=> _readExcel(context),
                  childWidget: Text('Choose file',style: TextStyle(color: ThemeConfig.whiteColor),),
                ),
              ),
              SizedBox(width: ThemeConfig.defaultPadding,),
              Obx(() => Text(
                fileName.value,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: ThemeConfig.labelSize
                ),
              ))
            ],
          ),
          SizedBox(height: ThemeConfig.defaultPadding/2,),
          Text('Preview template:',
            style: TextStyle(fontSize: ThemeConfig.titleSize,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),
          ),
          Obx(() => fileName.isNotEmpty?_buildPreviewExcel():const SizedBox()),
          Obx(() => (isReadFileSuccess.value)?_buildMapCol():const SizedBox()),
          Obx(() =>  (isReadFileSuccess.value)?_buildButton():const SizedBox()),

        ],
      ),
    );
  }
  Future<void> _readExcel(context) async{
    isReadFileSuccess.value = false;
    filePickerResult =
    await FilePicker.platform.pickFiles();

    if (filePickerResult != null) {
      fileName.value = filePickerResult?.files.single.name??'';
      hasFile.value = true;
      var data = filePickerResult?.files.single.bytes;
      var excel = Excel.decodeBytes(data!);
      sheet = excel.tables['Sheet1']!;
      try {
        listCol = [];
        rowData = [];
        mapColumn = {};
        for (int i = 0; i < sheet.maxCols; i++) {
          String col = sheet.row(0)[i]?.value;
          columns.add(col);
          mapColumn[col] = col.toString().toLowerCase();
          listCol.add(DataColumn(label: Text(col)),);
          String value = sheet.row(1)[i]!.value.toString();
          rowData.add(value);
        }
        isReadFileSuccess.value = true;
      }catch(e){
        isReadFileSuccess.value = false;
      }
    }else{
      fileName.value = '';
    }
  }

  Widget _buildPreviewExcel(){
    return isReadFileSuccess.value?DataTable(
        horizontalMargin: 0,
        columnSpacing: 50,
        showCheckboxColumn: true,
        columns: listCol,
        rows: [
          DataRow(cells: rowData.map((e){
            return DataCell(Text(e));
          }).toList())
        ]
    ):const Text('Read data failure');
  }

  Widget _buildMapCol(){
    List<TableRow> rowData = [];
    rowData.add(TableRow(children: [
      _buildCell('Column name', true),
      _buildCell('Map to field', true),
    ]));
    mapColumn.forEach((key, value) {
      rowData.add(
          TableRow(children: [
            _buildCell(key),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: MyDropdown2(
                  value: typeModel.getAllField().contains(value)?value:'',
                  data: typeModel.getAllFieldMetadata(),
                  callback: (value){
                    mapColumn[key] = value.toString();
                  },
                ),
              ),
            )
          ])
      );
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Map column',style: TextStyle(fontSize: ThemeConfig.titleSize,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
        Table(
          border: TableBorder.symmetric(inside: BorderSide.merge(
          const BorderSide(color: Colors.grey),BorderSide.none
          )),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(),
            1: FlexColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: rowData,
        )
      ],
    );
  }

  Widget _buildCell(String value, [bool isHeader = false]) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          value,
          style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }

  Widget _buildButton(){
    return MyButton(
      margin: EdgeInsets.symmetric(vertical: ThemeConfig.defaultPadding/2),
      validate: true,
      height: 40,
      callback: _importExcel,
      color: ThemeConfig.buttonPrimary,
      childWidget: Text('Import',style: TextStyle(color: ThemeConfig.whiteColor),),
    );
  }

  Future<bool> _importExcel() async{
    isLoading.value = true;
    int index = 1;
    totalRecordImport = (sheet.maxRows - 1) < 0
        ? 0
        : sheet.maxRows - 1;
    for (index; index < sheet.maxRows; index++) {
      var row = sheet.row(index);
      int indexCol = 0;
      TemplateModel model = typeModel.getEmptyModel();
      mapColumn.forEach((key, value) {
        model.setValue(value, row[indexCol++]?.value.toString());
      });
      model.create().then((value){
        if(value){
          listSuccess.add(model);
          listDataModel.add(model);
        }else{
          listError.add(model);
        }
        if(totalRecordImport == listSuccess.length + listError.length) {
          Get.back();
          Fluttertoast.showToast(
              msg:
              "Import successfully ${listSuccess
                  .length}/$totalRecordImport record",
              toastLength: Toast.LENGTH_LONG,
              fontSize: ThemeConfig.defaultSize,
              backgroundColor: Colors.green,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 60,
              webShowClose: true,
              webPosition: 'right');
          listError.clear();
          listSuccess.clear();
          isLoading.value = false;
          hasFile.value = false;
        }
      });
    }
    return true;
  }

}