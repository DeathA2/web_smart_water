import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:web_smart_water/api/api.dart';
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/controller/app_controller.dart';
import 'package:web_smart_water/model/luong/street_model/street_model.dart';
import 'package:web_smart_water/model/template/template_model.dart';
import 'package:web_smart_water/ui/item/template_web/create_view.dart';
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
    User.streets = {};
    List<dynamic> data = await api.getListCustomerForEachAdmin();
    List<dynamic> streets = [];
    for (var user in data) {
      var name = user['user'];
      for (var sts in user['streets']) {
        var code = sts['code'];
        if (User.streets.containsKey(code)) {
          if (!User.streets.containsValue(name)) {
            User.streets['$code']?.add(name);
          }
        } else {
          User.streets.addAll({
            '$code': ['$name']
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
        if (street['code'] == code){
          for (var customer in street['customers'])
            {
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

  //
  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //     future: getData(),
  //     builder: (BuildContext context,
  //         AsyncSnapshot<List<StreetsModel>> snapshot) {
  //       if (snapshot.connectionState != ConnectionState.done) {
  //         return const Center(child: LoadingScreen());
  //       }
  //       return MyListView(
  //           listDataModel: snapshot.data!.obs,
  //           template: StreetsModel().getListViewTemplate(),
  //           typeModel: StreetsModel());
  //     },
  //   );
  // }
  bool showList = false;
  int _index = 0;
  String title = 'Danh sách đường phố';
  int typeReport = 1;
  @override
  Widget build(BuildContext context) {
    return (showList) ? _buildListCustomers() : FutureBuilder(
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        const SizedBox(
          height: 20,
        ),
        _buildGridView(user)
      ],
    );
  }

  Widget _buildGridView(street) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        for (int i = 0; i < User.streets.length; i++) _buildButton(street, i)

        // Container(
        //   width: widthGet * 0.25,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(5),
        //       border: Border.all(color: Colors.black12)),
        //   child: ClipRRect(
        //     child: Column(
        //       children: [
        //         Container(
        //           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        //           decoration:
        //           BoxDecoration(color: Colors.grey.withOpacity(0.2)),
        //           child: Row(
        //             children: [
        //               const Icon(Icons.map_rounded),
        //               _buildSpaceRow(),
        //               Text(
        //                 User.streets.keys.elementAt(1),
        //                 style: const TextStyle(
        //                     fontWeight: FontWeight.bold, fontSize: 18),
        //               )
        //             ],
        //           ),
        //         ),
        //         const Divider(height: 1, color: Colors.black12),
        //         Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 20),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisAlignment: MainAxisAlignment.spaceAround,
        //             children: [
        //               _buildSpace(),
        //               Row(
        //                 children: [
        //                   Text(
        //                     "Tên: ",
        //                     style: titleStyle,
        //                   ),
        //                   _buildSpaceRow(),
        //                   Text(
        //                     "${street[0]['streets'][1]['name']}",
        //                     style: contentStyle,
        //                   )
        //                 ],
        //               ),
        //               _buildSpace(),
        //               Row(
        //                 children: [
        //                   Text(
        //                     "Mô tả: ",
        //                     style: titleStyle,
        //                   ),
        //                   _buildSpaceRow(),
        //                   Text(
        //                     "null",
        //                     style: contentStyle,
        //                   )
        //                 ],
        //               ),
        //               _buildSpace(),
        //               Row(
        //                 children: [
        //                   Text(
        //                     "Người ghi số: ",
        //                     style: titleStyle,
        //                   ),
        //                   _buildSpaceRow(),
        //                   Text(
        //                     User.streets[User.streets.keys.elementAt(1)]?.join(", ") ?? "",
        //                     style: contentStyle,
        //                   )
        //                 ],
        //               ),
        //               _buildSpace(),
        //               Row(
        //                 mainAxisSize: MainAxisSize.max,
        //                 mainAxisAlignment: MainAxisAlignment.end,
        //                 children: [
        //                   MaterialButton(
        //                       onPressed: () {},
        //                       shape: Border.all(),
        //                       // iconSize: 20,
        //                       child: const Icon(Icons.skip_next)
        //                   ),
        //                   const SizedBox(
        //                     width: 10,
        //                   ),
        //                   MaterialButton(
        //                       onPressed: () async {
        //                         var model = await api.deleteDataStreet(User.streets.keys.elementAt(1));
        //                         showDialog(
        //                           context: context,
        //                           builder: (context) {
        //                             return CupertinoAlertDialog(
        //                               title: Text('Delete ${street[0]['streets'][1]['name']}'),
        //                               content: Text('Do you want to delete ${street[0]['streets'][1]['name']}'),
        //                               actions: [
        //                                 CupertinoDialogAction(
        //                                     onPressed:() {
        //                                       Navigator.of(context).pop();
        //
        //                                         if(model){
        //                                           listModel.remove(model);
        //                                           listAllModel.remove(model);
        //                                           // updateDataGriDataSource();
        //                                           appController.message = SweetAlert(
        //                                             type: SweetAlertType.success,
        //                                             message: 'Xóa ${street[0]['streets'][1]['name']} thành công',
        //                                             title: 'Thành công',
        //                                           );
        //                                           appController.pushNotificationStream.rebuildWidget(true);
        //                                           // callback(true);
        //                                         }else{
        //                                           appController.message = SweetAlert(
        //                                             type: SweetAlertType.error,
        //                                             message: 'Xóa ${street[0]['streets'][1]['name']} không thành công',
        //                                             title: 'Lỗi',
        //                                           );
        //                                           appController.pushNotificationStream.rebuildWidget(true);
        //                                         }
        //
        //                                     },
        //                                     child: const Text('Delete')
        //                                 ),
        //                                 CupertinoDialogAction(
        //                                     onPressed:(){
        //                                       Navigator.of(context).pop();
        //                                     },
        //                                     child: const Text('Cancel')
        //                                 )
        //                               ],
        //                             );
        //                           },
        //                         );
        //                       },
        //                       shape: Border.all(),
        //                       // iconSize: 20,
        //                       child: const Icon(Icons.delete, color: Colors.red,)),
        //                 ],
        //               ),
        //               _buildSpace(),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // )
      ],
    );
  }

  Widget _buildButton(street, index) {
    var user = 0;
    var indexStreet = 0;
    // bool _hasData = false;
    String code = User.streets.keys.elementAt(index);
    while (true) {
      var currentStreet = street[user]['streets'] as List;
      // var currentStreet = sts as List;
      indexStreet =
          currentStreet.indexWhere((element) => element['code'] == code);
      if (indexStreet != -1) {
        break;
      }
      user++;
    }
    String name = street[user]['streets'][indexStreet]['name'];
    return Container(
      width: widthGet * 0.25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black12)),
      child: ClipRRect(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
              child: Row(
                children: [
                  const Icon(Icons.map_rounded),
                  _buildSpaceRow(),
                  Text(
                    code,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
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
                        "Mô tả: ",
                        style: titleStyle,
                      ),
                      _buildSpaceRow(),
                      Text(
                        "null",
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
                      MaterialButton(
                          minWidth: 0,
                          padding: EdgeInsets.all(15),
                          onPressed: () {
                            showList = true;
                            Street.code = code;
                            Street.user = User.streets[code]?.join(", ") ?? "";
                            Street.name = name;
                            setState(() {
                            });
                          },
                          shape: Border.all(),
                          // iconSize: 20,
                          child: const Icon(Icons.skip_next)),
                      const SizedBox(
                        width: 20,
                      ),
                      MaterialButton(
                          minWidth: 0,
                          padding: EdgeInsets.all(15),
                          onPressed: () async {
                            var model = await api.deleteDataStreet(code);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: Text('Delete $name'),
                                  content: Text('Do you want to delete $name'),
                                  actions: [
                                    CupertinoDialogAction(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          if (model) {
                                            listModel.remove(model);
                                            listAllModel.remove(model);
                                            // updateDataGriDataSource();
                                            // notifyListeners();
                                            appController.message = SweetAlert(
                                              type: SweetAlertType.success,
                                              message: 'Xóa $name thành công',
                                              title: 'Thành công',
                                            );
                                            appController.pushNotificationStream
                                                .rebuildWidget(true);
                                            // callback(true);
                                          } else {
                                            appController.message = SweetAlert(
                                              type: SweetAlertType.error,
                                              message:
                                                  'Xóa $name không thành công',
                                              title: 'Lỗi',
                                            );
                                            appController.pushNotificationStream
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
                          shape: Border.all(),
                          // iconSize: 20,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
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
    );
  }

  _buildActionCreate(context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            content: MyCreateView(
              model: StreetsModel().getEmptyModel(),
              isNew: true,
            ),
          );
        }).then((value) {
      if (value != null) {
        listDataModel.add(value);
        callback(true);
      }
    });
  }

  Widget _buildTitle() {
    if (_index == 0) {
      return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            color: Colors.grey.withOpacity(0.5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Danh sách đường phố',
              style: TextStyle(
                  fontSize: ThemeConfig.headerSize,
                  fontWeight: FontWeight.bold),
            ),
            MaterialButton(
              onPressed: () {
                _buildActionCreate(context);
              },
              child: Icon(Icons.add),
              shape: Border.all(),
              minWidth: 0,
              padding: EdgeInsets.all(15),
            )
          ],
        ),
      );
    } else {
      switch (typeReport) {
        case 1:
          title =
              'Biên bản giao nhận sản phẩm nhập kho hàng ca nội bộ/ đơn vị thuê ngoài';
          break;
        case 2:
          title =
              'Biên bản xác nhận khối lượng công việc bốc xếp lưu kho bốc xếp tiêu thụ sản phẩm hàng ca';
          break;
        case 3:
          title = 'Biên bản hiện trường bao lỗi';
          break;
        case 4:
          title = 'Đề nghị nhập sản phẩm';
          break;
        case 5:
          title = 'Đề nghị xuất sản phẩm';
          break;
        case 6:
          title = 'Biên bản giao nhận sản phẩm - Xuất khẩu Gò Dầu';
          break;
        case 7:
          title = 'Biên bản giao nhận sản phẩm - Container';
          break;
        case 8:
          title = 'Biên bản giao nhận sản phẩm - Nội địa';
          break;
        default:
          title = 'Đề nghị xuất sản phẩm';
          break;
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
                text: 'Danh sách đường phố',
                style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: ThemeConfig.labelSize),
                children: [
                  TextSpan(
                      text: ' / $title',
                      style: TextStyle(
                          fontSize: ThemeConfig.labelSize,
                          color: ThemeConfig.textColor))
                ]),
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: ThemeConfig.defaultSize, fontWeight: FontWeight.bold),
          )
        ],
      );
    }
  }

  Widget _buildListCustomers(){
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSpace(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 5,child: _buildSmallInfor()),
              _buildSpaceRow(),
              Expanded(flex: 15,child: _buildListCus()),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSmallInfor(){
    return Container(
      decoration: BoxDecoration(
        border: Border.all()
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            width: Get.width,
            color: Colors.grey.withOpacity(0.25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on),
                _buildSpaceRow(),
                Text(Street.code, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              ],
            ),
          ),
          Divider(height: 1,),
          Container(
            padding: EdgeInsets.all(30),
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tên khu vực", style: titleStyle,),
                Center(child: Text(Street.name, style: contentStyle,)),
                Text("Mô tả", style: titleStyle,),
                Center(child: Text(Street.des, style: contentStyle,)),
                Text("Nhân viên ghi nhận", style: titleStyle,),
                Center(child: Text(Street.user, style: contentStyle,))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListCus(){
    return Column(
      children: [
        SingleChildScrollView(
          controller: ScrollController(),
          child: FutureBuilder(
            future: getCustomersEachStreet(Street.code),
            builder: ((context, AsyncSnapshot<List<CustomersEachStreetModel>> snapshot) {
              if (snapshot.connectionState != ConnectionState.done){
                return const LoadingScreen();
              }
              return MyListView(
                  listDataModel: snapshot.data!.obs,
                  template: CustomersEachStreetModel().getListViewTemplate(),
                  typeModel: CustomersEachStreetModel());
            }),
          ),
        ),
      ],
    );
  }
}
