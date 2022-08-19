import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_smart_water/api/api.dart';
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/controller/app_controller.dart';
import 'package:web_smart_water/model/luong/street_model/street_model.dart';
import 'package:web_smart_water/model/template/template_model.dart';
import 'package:web_smart_water/ui/item/template_web/create_view.dart';
import 'package:web_smart_water/ui/item/template_web/list_view/header.dart';
import 'package:web_smart_water/ui/item/template_web/list_view/list_view.dart';
import 'package:web_smart_water/ui/screen/luong_smart_water/data.dart';
import 'package:web_smart_water/ui/widget/custom_scaffold.dart';
import 'package:web_smart_water/ui/widget/loading_screen.dart';
import 'package:web_smart_water/ui/widget/sweet_alert.dart';

class ListStreetsScreen extends StatefulWidget {
  const ListStreetsScreen({Key? key}) : super(key: key);

  @override
  _ListStreetsScreenState createState() => _ListStreetsScreenState();
}

class _ListStreetsScreenState extends State<ListStreetsScreen> {
  final GlobalKey<SfDataGridState> keyGridView = GlobalKey<SfDataGridState>();
  double widthGet = 0;
  RxList<TemplateModel> listModel = <TemplateModel>[].obs;
  RxList<TemplateModel> listAllModel = <TemplateModel>[].obs;
  late final RxList<TemplateModel> listDataModel;
  late final MenuCallback callback;

  final TextStyle titleStyle = TextStyle(
      fontSize: ThemeConfig.smallSize,
      color: ThemeConfig.blackColor.withOpacity(0.7),
      fontWeight: FontWeight.bold);
  final TextStyle contentStyle = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87);

  Future<List> getData() async {
    Street.count = {};
    User.streets = {};
    List<dynamic> data = await api.getListCustomerForEachAdmin();
    List<dynamic> streets = [];
    for (var user in data) {
      var name = user['user'];
      for (var sts in user['streets']) {
        var code = sts['code'];
        var customer = sts['customers'] as List;
        if (User.streets.containsKey(code)) {
          if (!User.streets.containsValue(name)) {
            User.streets['$code']?.add(name);
          }
        } else {
          User.streets.addAll({
            '$code': ['$name']
          });
        }
        if (Street.count.containsKey(code)) {
          Street.count.update(code, (value) => value+customer.length);
        } else {
          Street.count.addAll({
            code:customer.length
          });
        }
        streets.add(sts);
      }
    }
    return data;
  }

  Future<List<CustomersEachStreetModel>> getCustomersEachStreet(code) async {
    // User = {};
    List<dynamic> data = await api.getListCustomerForEachAdmin();
    List<dynamic> customers = [];
    for (var user in data) {
      for (var street in user['streets']) {
        if (street['code'] == code) {
          for (var customer in street['customers']) {
            customers.add(customer);
          }
        }
      }
    }
    return customers.map((e) => CustomersEachStreetModel.fromJson(e)).toList();
  }

  @override
  void initState() {
    widthGet = Get.width;
    super.initState();
  }

  void update() {
    StorageDirectory.notifications;
  }

  bool showList = false;
  String title = 'Danh sách đường phố';
  int typeReport = 1;
  @override
  Widget build(BuildContext context) {
    return (showList)
        ? _buildListCustomers()
        : FutureBuilder(
            future: getData(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const LoadingScreen();
              }
              return CustomScaffold(body: _buildMain(snapshot.data as List));
            }),
          );
  }

  Widget _buildSpace() {
    return const SizedBox(
      height: 10,
    );
  }

  Widget _buildSpaceRow() {
    return const SizedBox(
      width: 10,
    );
  }

  Widget _buildMain(user) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _buildTitle(),
          _buildTitleUseTemplate(),
          _buildGridView(user)
        ],
      ),
    );
  }

  Widget _buildGridView(street) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        for (int i = 0; i < User.streets.length; i++) _buildButton(street, i)
      ],
    );
  }

  Widget _buildButton(street, index) {
    var user = 0;
    var indexStreet = 0;
    String code = User.streets.keys.elementAt(index);
    while (true) {
      var currentStreet = street[user]['streets'] as List;
      indexStreet =
          currentStreet.indexWhere((element) => element['code'] == code);
      if (indexStreet != -1) {
        break;
      }
      user++;
    }
    String name = street[user]['streets'][indexStreet]['name'];
    return ConstrainedBox(
      constraints: const BoxConstraints(
          minWidth: 300,
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          minHeight: 0),
      child: Container(
        width: widthGet * 0.22,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                offset: Offset(5, 7),
                blurRadius: 12,
                color: Colors.black38,
              )
            ],
            border: Border.all(color: Colors.black12)),
        child: ClipRRect(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: const BoxDecoration(color: Colors.black12),
                child: Row(
                  children: [
                    Icon(Icons.map_rounded, color: ThemeConfig.primaryColor),
                    _buildSpaceRow(),
                    Text(
                      code,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: ThemeConfig.primaryColor),
                    )
                  ],
                ),
              ),
              const Divider(height: 1, color: Colors.black12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSpace(),
                    Row(
                      children: [
                        Text(
                          "Tên: ",
                          style: titleStyle,
                        ),
                        _buildSpaceRow(),
                        Text(
                          name,
                          style: contentStyle,
                        )
                      ],
                    ),
                    _buildSpace(),
                    Row(
                      children: [
                        Text(
                          "Số hộ khẩu: ",
                          style: titleStyle,
                        ),
                        _buildSpaceRow(),
                        Text(
                          Street.count[code].toString(),
                          style: contentStyle,
                        )
                      ],
                    ),
                    _buildSpace(),
                    Row(
                      children: [
                        Text(
                          "Người ghi số: ",
                          style: titleStyle,
                        ),
                        _buildSpaceRow(),
                        Text(
                          User.streets[code]?.join(", ") ?? "",
                          style: contentStyle,
                        )
                      ],
                    ),
                    _buildSpace(),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showList = true;
                            Street.code = code;
                            Street.user = User.streets[code]?.join(", ") ?? "";
                            Street.name = name;
                            Street.sumCustomer = Street.count[code].toString();
                            setState(() {});
                            /**/
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.hovered)) {
                                return ThemeConfig.primaryColor;
                              }
                              return Colors.white;
                            }),
                            foregroundColor: MaterialStateProperty.resolveWith(
                                (states) =>
                                    (states.contains(MaterialState.hovered)
                                        ? Colors.white
                                        : ThemeConfig.primaryColor)),
                            minimumSize:
                                MaterialStateProperty.all(const Size(0, 0)),
                            side: MaterialStateProperty.all(const BorderSide()),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(20)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                          child: const Icon(
                            Icons.more,
                            size: 17,
                            // color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              var model = await api.deleteDataStreet(code);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Text('Delete $name'),
                                    content:
                                        Text('Do you want to delete $name'),
                                    actions: [
                                      CupertinoDialogAction(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            if (model) {
                                              listModel.remove(model);
                                              listAllModel.remove(model);
                                              update();
                                              appController.message =
                                                  SweetAlert(
                                                type: SweetAlertType.success,
                                                message: 'Xóa $name thành công',
                                                title: 'Thành công',
                                              );
                                              appController
                                                  .pushNotificationStream
                                                  .rebuildWidget(true);
                                              // callback(true);
                                            } else {
                                              appController.message =
                                                  SweetAlert(
                                                type: SweetAlertType.error,
                                                message:
                                                    'Xóa $name không thành công',
                                                title: 'Lỗi',
                                              );
                                              appController
                                                  .pushNotificationStream
                                                  .rebuildWidget(true);
                                            }
                                          },
                                          child: const Text('Delete')),
                                      CupertinoDialogAction(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'))
                                    ],
                                  );
                                },
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return const Color(0xff841923);
                                }
                                return Colors.white;
                              }),
                              foregroundColor:
                                  MaterialStateProperty.resolveWith((states) =>
                                      (states.contains(MaterialState.hovered)
                                          ? Colors.white
                                          : ThemeConfig.primaryColor)),
                              minimumSize:
                                  MaterialStateProperty.all(const Size(0, 0)),
                              side:
                                  MaterialStateProperty.all(const BorderSide()),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(20)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                            child: const Icon(
                              Icons.delete,
                              size: 17,
                            )),
                      ],
                    ),
                    _buildSpace(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // _buildActionCreate(context) {
  //   return showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           scrollable: true,
  //           content: MyCreateView(
  //             model: StreetsModel().getEmptyModel(),
  //             isNew: true,
  //           ),
  //         );
  //       }).then((value) {
  //     if (value != null) {
  //       listDataModel.add(value);
  //       callback(true);
  //     }
  //   });
  // }

  Widget _buildTitleUseTemplate() {
    List<StreetsModel> _isEmpty = [];
    return ListViewHeader(
        typeModel: StreetsModel(),
        callback: (param) async {
          // if(param) {
          //   listDataModel.refresh();
          // }
        },
        keyGridView: keyGridView,
        listDataModel: _isEmpty.obs,
        template: StreetsModel().getListViewTemplate());
  }

  Widget _buildListCustomers() {
    Street.countCustomer = 0;
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSpace(),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  showList = false;
                  setState(() {});
                  /**/
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.hovered)) {
                      return ThemeConfig.primaryColor;
                    }
                    return Colors.white;
                  }),
                  foregroundColor: MaterialStateProperty.resolveWith((states) =>
                      (states.contains(MaterialState.hovered)
                          ? Colors.white
                          : ThemeConfig.primaryColor)),
                  minimumSize: MaterialStateProperty.all(const Size(0, 0)),
                  side: MaterialStateProperty.all(const BorderSide()),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 5)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.chevron_left,
                      size: 20,
                      // color: Colors.black,
                    ),
                    Icon(
                      Icons.home_rounded,
                      size: 20,
                      // color: Colors.black,
                    ),
                  ],
                ),
              ),
              _buildSpaceRow(),
              TextButton(
                onPressed: () {
                  showList = false;
                  setState(() {});
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith((states) => (states.contains(MaterialState.hovered))? ThemeConfig.primaryColor : ThemeConfig.hoverTextColor)
                ),
                child: const Text(
                  'Danh sách đường phố',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  // style: ThemeConfig.defaultStyle.copyWith(
                  //     fontWeight: FontWeight.bold,
                  //     color: ThemeConfig.hoverTextColor),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: ThemeConfig.defaultSize,
                color: ThemeConfig.blackColor,
              ),
              Text(
                Street.code,
                style: ThemeConfig.defaultStyle.copyWith(
                    fontWeight: FontWeight.bold, color: ThemeConfig.blackColor),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ResponsiveGridRow(
            children: [
              ResponsiveGridCol(lg: 3, child: _buildSmallInfor()),
              ResponsiveGridCol(lg: 9, child: _buildListCus()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallInfor() {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(border: Border.all()),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            width: Get.width,
            color: Colors.grey.withOpacity(0.25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on),
                _buildSpaceRow(),
                Text(
                  Street.code,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
          Container(
            padding: const EdgeInsets.all(30),
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tên khu vực",
                  style: titleStyle,
                ),
                Center(
                    child: Text(
                  Street.name,
                  style: contentStyle,
                )),
                Text(
                  "Tổng số hộ khẩu",
                  style: titleStyle,
                ),
                Center(
                    child: Text(
                  Street.sumCustomer,
                  style: contentStyle,
                )),
                Text(
                  "Nhân viên ghi nhận",
                  style: titleStyle,
                ),
                Center(
                    child: Text(
                  Street.user,
                  style: contentStyle,
                ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListCus() {
    return Column(
      children: [
        SingleChildScrollView(
          controller: ScrollController(),
          child: FutureBuilder(
            future: getCustomersEachStreet(Street.code),
            builder: ((context,
                AsyncSnapshot<List<CustomersEachStreetModel>> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const LoadingScreen();
              }
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: MyListView(
                    listDataModel: snapshot.data!.obs,
                    template: CustomersEachStreetModel().getListViewTemplate(),
                    typeModel: CustomersEachStreetModel()),
              );
            }),
          ),
        ),
      ],
    );
  }
}
