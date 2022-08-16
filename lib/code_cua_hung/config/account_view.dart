import 'package:flutter/material.dart';
import 'package:web_smart_water/code_cua_hung/model/account_model.dart';
import 'package:get/get.dart';
import '../../api/api.dart';
import '../../ui/item/template_web/list_view/list_view.dart';
import '../../ui/widget/loading_screen.dart';


class ListAccountView extends StatefulWidget {
  const ListAccountView({Key? key}) : super(key: key);

  @override
  _ListAccountViewState createState() => _ListAccountViewState();
}

class _ListAccountViewState extends State<ListAccountView> {
  Future<List<ModelListAccount>> getData() async {
    List<dynamic> data = await api.getListAccountConfig();
    return data.map((e) => ModelListAccount.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context,
          AsyncSnapshot<List<ModelListAccount>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: LoadingScreen());
        }
        return MyListView(
            listDataModel: snapshot.data!.obs,
            template: ModelListAccount().getListViewTemplate(),
            typeModel: ModelListAccount());
      },
    );
  }
}
