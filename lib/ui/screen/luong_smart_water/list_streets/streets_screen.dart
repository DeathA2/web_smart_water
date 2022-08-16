import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:web_smart_water/api/api.dart';
import 'package:web_smart_water/model/luong/street_model/street_model.dart';
import 'package:web_smart_water/ui/item/template_web/list_view/list_view.dart';
import 'package:web_smart_water/ui/screen/luong_smart_water/data.dart';
import 'package:web_smart_water/ui/widget/loading_screen.dart';

class ListStreetsScreen extends StatefulWidget {
  const ListStreetsScreen({Key? key}) : super(key: key);

  @override
  _ListStreetsScreenState createState() => _ListStreetsScreenState();
}

class _ListStreetsScreenState extends State<ListStreetsScreen> {

  Future<List<StreetsModel>> getData() async {
    User.streets = {};
    List<dynamic> data = await api.getListCustomerForEachAdmin();
    List<dynamic> streets = [];
    for (var user in data){
      var name = user['user'];
      for (var sts in user['streets']){
        var code = sts['code'];
        if (User.streets.containsKey(code)){
          if (!User.streets.containsValue(name)){
            User.streets['$code']?.add(name);
          }
        }
        else{
          User.streets.addAll({'$code': ['$name']});
        }

          streets.add(sts);

      }
    }
    // return [];
    return streets.map((e) => StreetsModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context,
          AsyncSnapshot<List<StreetsModel>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: LoadingScreen());
        }
        return MyListView(
            listDataModel: snapshot.data!.obs,
            template: StreetsModel().getListViewTemplate(),
            typeModel: StreetsModel());
      },
    );
  }
}
