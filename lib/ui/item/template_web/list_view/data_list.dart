import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/controller/app_controller.dart';
import 'package:web_smart_water/model/template/template_model.dart';
import 'package:web_smart_water/ui/item/template_web/list_view/search.dart';
import 'package:web_smart_water/ui/widget/custom_table_source.dart';

class MyDaTaList extends StatefulWidget{
  const MyDaTaList({Key? key, required this.keyGridView,required this.listDataModel,required this.template,required this.typeModel}) : super(key: key);
  final RxList<TemplateModel> listDataModel;
  final TemplateModel typeModel;
  final GlobalKey<SfDataGridState> keyGridView;
  final Map<dynamic,dynamic> template;
  @override
  State<MyDaTaList> createState() => _MyDaTaListState();
}

class _MyDaTaListState extends State<MyDaTaList> {
  final DataGridController _dataGridController = DataGridController();
  late CustomDataSource _dataSource;
  List<String> sumCol =[];
  final filter = {};
  String search = '';
  RxList<TemplateModel> dataList = <TemplateModel>[].obs;
  List<String> column = [];
  final Map<String,List> allFilter = {};
  late Map<String, double> columnWidths = {};
  final RxInt _rowsPerPage = 15.obs;
  @override
  void initState() {
    column.addAll(
        (widget.template['fields'] as List).map((e) => e['field']).toList().cast<String>()
    );
    _setData();
    super.initState();
  }
  void _setData(){
    getColumns();
    dataList.clear();
    dataList.addAll(widget.listDataModel);
    _dataSource = CustomDataSource(
      modelType: widget.typeModel,
        callback: (value){
          _setData();
        },
      listAllModel: widget.listDataModel,
      list: dataList,
        listColumn: column,
        context: context);
    for (String col in column) {
      if(widget.typeModel.isFilter(col)) {
        allFilter[col] = _getAllValueByKey(col);
      }
    }
  }

  void getColumns(){
    for (String key in column) {
      columnWidths[key] = double.nan;
      filter[key] = [];
    }
  }

  void getKeysFromMap(Map map) {
    if(column.isEmpty) {
      // Get all keys
      for (var key in map.keys) {
        column.add(key);
        columnWidths[key] = double.nan;
        filter[key] = [];
      }
    }else {
      for (String key in column) {
        // column.add(key);
        columnWidths[key] = double.nan;
        filter[key] = [];
      }
    }
  }

  List<dynamic> _getAllValueByKey(String key){
    List<dynamic> result =[];
    for(TemplateModel item in widget.listDataModel){
      if(!result.contains(item.getValue(key))){
        result.add(item.getValue(key));
      }
    }
    return result;
  }

  void _getDataByFilter(){
    dataList.clear();
    dataList.addAll(widget.listDataModel);
    for(String col in column) {
      if(filter[col].isNotEmpty) {
        dataList.value = dataList.where((element) =>
            filter[col].contains(
                element.getValue(col))).toList();
      }
    }
    _dataSource = CustomDataSource(
        modelType: widget.typeModel,
        callback: (value){
          _setData();
        },
        listAllModel: widget.listDataModel,
        list: dataList,
        listColumn: column,
        context: context);
  }

  void _searchGlobal(){
    List<TemplateModel> currentList = [];
    _getDataByFilter();
    currentList.addAll(dataList);
    if(search.isNotEmpty){
      currentList = dataList.where((element) {
        bool flag = false;
        for(String col in column){
          if((element.getValue(col).toString().toLowerCase()).contains(search.toLowerCase())) {
            flag = true;
          }
        }
        return flag;
      }).toList();
    }
    dataList.clear();
    dataList.addAll(currentList);
    _dataSource = CustomDataSource(
        modelType: widget.typeModel,
        callback: (value){
          _setData();
        },
        listAllModel: widget.listDataModel,
        search:search,
        list: dataList,
        listColumn: column,
        context: context);
  }
  // end function
  Widget _buildTable(context) {
    int numRow = widget.listDataModel.length;
    if(numRow > _rowsPerPage.value){
      numRow = _rowsPerPage.value;
    }
    return  Obx(() => SizedBox(
      height: 40*numRow + 100,
      child: SfDataGrid(
        key: widget.keyGridView,
        allowSorting: true,
        allowTriStateSorting: true,
        showCheckboxColumn: widget.template['show_checkbox']??false,
        rowHeight: 40,
        highlightRowOnHover: true,
        rowsPerPage: _rowsPerPage.value,
        // checkboxColumnSettings: DataGridCheckboxColumnSettings(
        //   width: 100,
        //   label: _buildActionDropdown(),
        // ),
        navigationMode: GridNavigationMode.cell,
        selectionMode: SelectionMode.none,
        gridLinesVisibility: GridLinesVisibility.horizontal,
        headerGridLinesVisibility: GridLinesVisibility.horizontal,
        columnWidthMode: appController.isSmall.value?ColumnWidthMode.none:ColumnWidthMode.fill,
        controller: _dataGridController,
        source: _dataSource,
        footer: _dataSource.listModel.isEmpty?Container(
            color: Colors.grey[400],
            child: Center(
                child: Text(
                  'No data',
                  style: ThemeConfig.defaultStyle.copyWith(fontWeight: FontWeight.bold),
                ))):null,
        columns: (widget.template['fields'] as List).map((field) => _buildColumn(field)).toList(),
      ),
    ));
  }
  GridColumn _buildColumn(Map<String,dynamic> field){
    return field['field'] != 'action_button'?GridColumn(
        columnName: field['field'],
        minimumWidth: 150,
        label: Padding(
          padding: EdgeInsets.symmetric(horizontal: ThemeConfig.defaultPadding/2),
          child: Row(
            children: [
              Expanded(child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    (field['label'] as String).toUpperCase(),
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    style: ThemeConfig.defaultStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: ThemeConfig.defaultSize,
                        color: ThemeConfig.textColor
                    ),
                  )
              )),
              widget.typeModel.isFilter(field['field'])?InkWell(
                onTap:() => _showMyDialog(field),
                child: Icon((filter[field['field']] as List).isNotEmpty?Icons.filter_list_alt:Icons.filter_alt_outlined,size: ThemeConfig.defaultSize,color: ThemeConfig.blackColor,),
              ):const SizedBox()
            ],
          ),
        )
    ):GridColumn(
        columnName: field['field'],
        minimumWidth: 150,
        label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12.0),
            child:Text(
              (field['label'] as String).toUpperCase(),
              style: ThemeConfig.defaultStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: ThemeConfig.defaultSize,
                  color: ThemeConfig.textColor
              ),
            )));
  }
  @override
  Widget build(BuildContext context) {
    _searchGlobal();
    return Obx(() => Column(
      children: [
        widget.template['show_search']?SearchListView(callback: (value){
          setState(() {
            search = value;
          });
        }):const SizedBox(),
        SfDataGridTheme(
            data: SfDataGridThemeData(
                rowHoverColor: ThemeConfig.hoverColor,
                brightness: Brightness.light,
                headerColor: ThemeConfig.greyColor.withOpacity(0.1)),
            child: _buildTable(context)),
        widget.listDataModel.length > _rowsPerPage.value?_buildPaging():const SizedBox()
      ],
    ));
  }
  Widget _buildPaging(){
    return SfDataPagerTheme(
      data: SfDataPagerThemeData(
        itemColor: ThemeConfig.whiteColor,
        selectedItemColor: ThemeConfig.primaryColor,
        itemBorderRadius: BorderRadius.circular(5),
        backgroundColor: ThemeConfig.whiteColor,
      ),
      child:SfDataPager(
        visibleItemsCount: _rowsPerPage.value,
        delegate: _dataSource,
        availableRowsPerPage: const [50],
        onRowsPerPageChanged: (int? rowsPerPage) {
          setState(() {
            _rowsPerPage.value = rowsPerPage!;
            _dataSource.updateDataGriDataSource();
          });
        },
        pageCount: (dataList.length / _rowsPerPage.value).ceil().toDouble()==0?1:(dataList.length / _rowsPerPage.value).ceil().toDouble(),
        direction: Axis.horizontal,
      ),
    );
  }

  Widget _buildActionDropdown(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: PopupMenuButton<int>(
        icon: Icon(Icons.more_horiz_outlined,color: ThemeConfig.whiteColor,size: 20,),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Row(
              children: [
                const Icon(
                  Icons.delete_outline,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  'Delete',
                  style: ThemeConfig.defaultStyle.copyWith(
                    color: ThemeConfig.textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
        onSelected: (value) async{
          if(value ==1){
            showDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Text('Delete ${widget.typeModel.getValue('name')}'),
                  content: Text('Do you want to delete ${widget.typeModel.getValue('name')}'),
                  actions: [
                    CupertinoDialogAction(
                        onPressed:(){
                          Navigator.of(context).pop();
                          for (DataGridRow element in _dataGridController.selectedRows) {
                            (element as CustomDataGridRow).model.delete().then((value){
                              if(value){
                                widget.listDataModel.remove(element.model);
                              }
                            });
                          }
                        },
                        child: const Text('Delete')
                    ),
                    CupertinoDialogAction(
                        onPressed:(){
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel')
                    )
                  ],
                );
              },
            ).then((value){
              widget.listDataModel.refresh();
              _setData();
            });
          }
        },
      ),
    );
  }

  Future<void> _showMyDialog(Map<String,dynamic> field) async {
    // bool selectAll = false;
    List? currentFilter = allFilter[field['field']];

    TextEditingController search = TextEditingController();
    search.addListener(() {
      if(search.text.isNotEmpty){
        setState(() {
          currentFilter = allFilter[field['field']]?.where((element) => (element.toString().toLowerCase()).contains(search.text.toLowerCase())).toList();
        });
      }else{
        setState(() {
          currentFilter = allFilter[field['field']];
        });
      }
    });
    return await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(field['label']),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return   SizedBox(
                width: 500,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged:(value){
                          if(value.isNotEmpty){
                            setState(() {
                              currentFilter = allFilter[field['field']]?.where((element) => (element.toString().toLowerCase()).contains(value.toLowerCase())).toList();
                            });
                          }else{
                            setState(() {
                              currentFilter = allFilter[field['field']];
                            });
                          }
                        },
                        style:  TextStyle(fontSize: ThemeConfig.defaultSize),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          contentPadding: ThemeConfig.contentPadding,
                          counter: const SizedBox(),
                          hintText: 'Tìm kiếm',
                          hintStyle: TextStyle(
                              color: ThemeConfig.greyColor,
                              fontSize: ThemeConfig.smallSize
                          ),
                          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Colors.redAccent)),
                          focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: BorderSide(color: ThemeConfig.greyColor)),
                        ),
                      ),
                      InkWell(
                        onTap:(){
                          setState(() {
                            if((filter[field['field']] as List).length != currentFilter?.length){
                              filter[field['field']] = currentFilter;
                            }
                            else{
                              filter[field['field']] = [];
                            }
                          });
                        },
                        child: ListTile(
                          leading: Checkbox(value: (filter[field['field']] as List).length == currentFilter?.length, onChanged: (bool? value) {
                            setState(() {
                              // selectAll = value!;
                              if(value!){
                                filter[field['field']] = currentFilter;
                              }
                              else{
                                filter[field['field']] = [];
                              }
                            });
                          },),
                          title: const Text('Chọn tất cả'),
                        ),
                      ),
                      Divider(thickness:1,color: ThemeConfig.greyColor,),
                      ListBody(
                          children:  currentFilter!.map((e){
                            return Column(
                              children: [
                                InkWell(
                                  onTap:(){
                                    setState(() {
                                      if((filter[field['field']] as List).contains(e)){
                                        (filter[field['field']] as List).remove(e);
                                      }else{
                                        (filter[field['field']] as List).add(e);
                                      }
                                    });
                                  },
                                  child: ListTile(
                                    leading: Checkbox(value: (filter[field['field']] as List).contains(e), onChanged: (bool? value) {
                                      setState(() {
                                        if(value!){
                                          (filter[field['field']] as List).add(e);
                                        }
                                        else{
                                          // selectAll = false;
                                          (filter[field['field']] as List).remove(e);
                                        }
                                      });
                                    },),
                                    title: Text((e.toString()=='' || e == null)?'(Blank)':e.toString()),
                                  ),
                                ),
                                Divider(thickness:1,color: ThemeConfig.greyColor,)
                              ],
                            );
                          }).toList()
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Áp dụng'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {

                });
              },
            ),
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}