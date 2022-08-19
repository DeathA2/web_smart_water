import 'package:web_smart_water/model/template/template_model.dart';
import '../../api/api.dart';
import 'admin_history_view.dart';

class ModelListAdminHistory extends TemplateModel with AdminHistoryView {
  late String username;
  late int idkh;
  late String tenkh;
  late String diachi;
  late String madp;
  late String tendp;
  late String type;
  late String createdTime;
  late String lastestTime;

  ModelListAdminHistory(
      {this.username = '',
      this.idkh = 0,
      this.tenkh = '',
      this.diachi = '',
      this.madp = '',
      this.tendp = '',
      this.type = '',
      this.createdTime = '',
      this.lastestTime = ''}) {
    initValue();
  }

  ModelListAdminHistory.fromJson(Map<String, dynamic> json) {
    updateData(json);
    initValue();
  }

  @override
  Map<String, dynamic> toJson() {
    return data;
  }

  @override
  void initValue() {
    data['username'] = username;
    data['idkh'] = idkh;
    data['tenkh'] = tenkh;
    data['diachi'] = diachi;
    data['madp'] = madp;
    data['tendp'] = tendp;
    data['type'] = type;
    data['createdTime'] = createdTime;
    data['lastestTime'] = lastestTime;
    super.initValue();
  }

  @override
  updateData(Map<String, dynamic> json) {
    username = json['username'] ?? '';
    idkh = json['orderCustomer']['idkh'] ?? 0;
    tenkh = json['orderCustomer']['tenkh'] ?? '';
    diachi = json['orderCustomer']['diachi'] ?? '';
    madp = json['orderCustomer']['madp'] ?? '';
    tendp = json['orderCustomer']['tendp'] ?? '';
    type = json['type'] ?? '';
    createdTime = json['createdTime'] ?? '';
    lastestTime = json['lastestTime'] ?? '';
  }

  @override
  String getModelName() {
    return 'Lịch sử';
  }

  @override
  ModelListAdminHistory getEmptyModel() {
    return ModelListAdminHistory();
  }

  @override
  ModelListAdminHistory fromJson(e) {
    ModelListAdminHistory myModel = ModelListAdminHistory();
    myModel.updateData(e);
    myModel.initValue();
    return myModel;
  }
}
