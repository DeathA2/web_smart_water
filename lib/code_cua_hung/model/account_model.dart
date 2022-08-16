import 'package:web_smart_water/model/template/template_model.dart';
import '../../api/api.dart';
import 'account_view.dart';

class ModelListAccount extends TemplateModel with AccountView{
  late String user;
  late String username;
  late String des;
  late String role;

  ModelListAccount(
      {this.user = '', this.username = '', this.des = '', this.role = ''}){
    initValue();
  }

  ModelListAccount.fromJson(Map<String, dynamic> json) {
    updateData(json);
    initValue();
  }

  @override
  Map<String, dynamic> toJson() {
    return data;
  }

  @override
  void initValue(){
    data['user']      = user;
    data['username']  = username;
    data['des']       = des;
    data['role']      = role;
    super.initValue();
  }

  @override
  updateData(Map<String, dynamic> json) {
    user      = json['user']??'';
    username  = json['username']??'';
    des       = json['des']??'';
    role      = json['role']??'';
  }

  @override
  String getModelName() {
    return 'Danh sách tài khoản';
  }

  @override
  TemplateModel getEmptyModel() {
    return ModelListAccount();
  }

  @override
  Future<bool> create() async{
    return await api.createDataAccountConfig(data);
  }

  @override
  Future<bool> update() async{
    return await api.updateDataAccountConfig(data);
  }

  @override
  Future<bool> delete() async{
    return await api.deleteDataAccountConfig(data['user']);
  }
}
