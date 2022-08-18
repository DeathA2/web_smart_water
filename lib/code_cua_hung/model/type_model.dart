import 'package:web_smart_water/code_cua_hung/model/type_view.dart';
import 'package:web_smart_water/model/template/template_model.dart';
import '../../api/api.dart';

class ModelListType extends TemplateModel with TypeView{
  late String code;
  late String name;
  late String des;

  ModelListType(
      {this.code = '', this.name = '', this.des = ''}){
    initValue();
  }

  ModelListType.fromJson(Map<String, dynamic> json) {
    updateData(json);
    initValue();
  }

  @override
  Map<String, dynamic> toJson() {
    return data;
  }

  @override
  void initValue(){
    data['code']      = code;
    data['name']  = name;
    data['des']       = des;
    super.initValue();
  }

  @override
  updateData(Map<String, dynamic> json) {
    code      = json['code']??'';
    name  = json['name']??'';
    des       = json['des']??'';
  }

  @override
  String getModelName() {
    return 'Danh sách loại';
  }

  @override
  TemplateModel getEmptyModel() {
    return ModelListType();
  }

  @override
  Future<bool> create() async{
    return await api.createType(data);
  }

  @override
  Future<bool> update() async{
    return await api.updateType(data);
  }

  @override
  Future<bool> delete() async{
    return await api.deleteType(data['code']);
  }
}
