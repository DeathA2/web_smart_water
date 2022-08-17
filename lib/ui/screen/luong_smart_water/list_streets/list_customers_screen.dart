import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:web_smart_water/api/api.dart';
import 'package:web_smart_water/model/luong/street_model/street_model.dart';
import 'package:web_smart_water/ui/item/template_web/list_view/list_view.dart';
import 'package:web_smart_water/ui/screen/luong_smart_water/data.dart';
import 'package:web_smart_water/ui/widget/loading_screen.dart';

class ListCustomersScreen extends StatefulWidget {
  const ListCustomersScreen({Key? key}) : super(key: key);

  @override
  _ListCustomersScreenState createState() => _ListCustomersScreenState();
}

class _ListCustomersScreenState extends State<ListCustomersScreen> {
  Future<List<CustomersModel>> getData() async {
    User.customer = {};
    List<dynamic> data = await api.getListCustomerForEachAdmin();
    List<dynamic> streets = [];
    List<dynamic> customers = [];
    var name = '';
    for (var user in data) {
      name = user['user'];
      for (var sts in user['streets']) {
        var code = sts['code'];
        for (var customer in sts['customers']) {
          var id = customer['idkh'];
          User.customer.addAll({
            '$id': ['$code', '$name']
          });
          customers.add(customer);
        }
      }
    }

    // return [];
    return customers.map((e) => CustomersModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: getData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CustomersModel>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: LoadingScreen());
          }
          return MyListView(
              listDataModel: snapshot.data!.obs,
              template: CustomersModel().getListViewTemplate(),
              typeModel: CustomersModel());
        },
      ),
    );
  }
}
