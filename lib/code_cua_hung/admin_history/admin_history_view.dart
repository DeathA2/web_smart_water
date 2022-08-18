import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/api.dart';
import '../../config/app_config.dart';
import '../../controller/report_controller.dart';
import '../../report/report_view.dart';
import '../../ui/item/template_web/list_view/list_view.dart';
import '../../ui/widget/loading_screen.dart';
import '../../utils/utils.dart';
import '../model/admin_history_model.dart';


class AdminHistoryView extends StatefulWidget {
  const AdminHistoryView({Key? key}) : super(key: key);

  @override
  _AdminHistoryViewState createState() => _AdminHistoryViewState();
}

class _AdminHistoryViewState extends State<AdminHistoryView> {
  final ReportController controller = Get.put(ReportController());

  getData(){
    controller.listDataModel.clear();
    controller.url = 'getListHistoryAdmin';
    controller.template = ModelListAdminHistory().getListViewTemplate();
    controller.typeModel = ModelListAdminHistory();
    controller.titleName = 'Báo cáo thông tin lỗi';
    controller.byShift = false;
    controller.selectb2e = true;
    controller.begin = DateTime.now();
    controller.end = DateTime.now();
    controller.beginController.text = formatDateToString(controller.begin, AppConfig.FORMAT_DATE_API);
    controller.endController.text = formatDateToString(controller.end, AppConfig.FORMAT_DATE_API);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(() => controller.isLoading.value
        ?const Center(child: CircularProgressIndicator(),)
        :MyReportView(
      controller: controller,
    ));
  }
}
















