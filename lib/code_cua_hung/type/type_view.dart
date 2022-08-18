import 'package:flutter/material.dart';
import 'package:web_smart_water/code_cua_hung/model/type_model.dart';
import 'package:get/get.dart';
import '../../api/api.dart';
import '../../ui/item/template_web/list_view/list_view.dart';
import '../../ui/widget/loading_screen.dart';


class ListTypeView extends StatefulWidget {
  const ListTypeView({Key? key}) : super(key: key);

  @override
  _ListTypeViewState createState() => _ListTypeViewState();
}

class _ListTypeViewState extends State<ListTypeView> {
  Future<List<ModelListType>> getData() async {
    List<dynamic> data = await api.getListType();
    return data.map((e) => ModelListType.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context,
          AsyncSnapshot<List<ModelListType>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: LoadingScreen());
        }
        return MyListView(
            listDataModel: snapshot.data!.obs,
            template: ModelListType().getListViewTemplate(),
            typeModel: ModelListType());
      },
    );
  }
}
