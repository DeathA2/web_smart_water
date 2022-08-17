import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:web_smart_water/api/api.dart';
import 'package:web_smart_water/config/theme_config.dart';
import 'package:web_smart_water/model/luong/street_model/street_model.dart';
import 'package:web_smart_water/ui/item/template_web/list_view/list_view.dart';
import 'package:web_smart_water/ui/screen/luong_smart_water/data.dart';
import 'package:web_smart_water/ui/widget/custom_scaffold.dart';
import 'package:web_smart_water/ui/widget/loading_screen.dart';

class ListStreetsScreen extends StatefulWidget {
  const ListStreetsScreen({Key? key}) : super(key: key);

  @override
  _ListStreetsScreenState createState() => _ListStreetsScreenState();
}

class _ListStreetsScreenState extends State<ListStreetsScreen> {
  double widthGet = 0;
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

  int _index = 0;
  String title = 'Danh sách đường phố';
  int typeReport = 1;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    var sts = street[0]['streets'][0]['code'];
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        Container(
          width: widthGet * 0.25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black12)),
          child: ClipRRect(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration:
                      BoxDecoration(color: Colors.grey.withOpacity(0.2)),
                  child: Row(
                    children: [
                      const Icon(Icons.map_rounded),
                      _buildSpaceRow(),
                      Text(
                        User.streets.keys.elementAt(0),
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
                            "${street[0]['streets'][0]['name']}",
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
                            User.streets[User.streets.keys.elementAt(0)]?.join(", ") ?? "",
                            style: contentStyle,
                          )
                        ],
                      ),
                      _buildSpace(),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.indeterminate_check_box_sharp)),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.delete, color: Colors.red,),
                          )
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






        Container(
          width: widthGet * 0.25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black12)),
          child: ClipRRect(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration:
                  BoxDecoration(color: Colors.grey.withOpacity(0.2)),
                  child: Row(
                    children: [
                      const Icon(Icons.map_rounded),
                      _buildSpaceRow(),
                      Text(
                        User.streets.keys.elementAt(1),
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
                            "${street[0]['streets'][1]['name']}",
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
                            User.streets[User.streets.keys.elementAt(1)]?.join(", ") ?? "",
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
                              onPressed: () {},
                              shape: Border.all(),
                              // iconSize: 20,
                              child: const Icon(Icons.skip_next)
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          MaterialButton(
                              onPressed: () {},
                              shape: Border.all(),
                              // iconSize: 20,
                              child: const Icon(Icons.delete, color: Colors.red,)),
                        ],
                      ),
                      _buildSpace(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTitle() {
    if (_index == 0) {
      return Text(
        'Danh sách đường phố',
        style: TextStyle(
            fontSize: ThemeConfig.headerSize, fontWeight: FontWeight.bold),
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
}
