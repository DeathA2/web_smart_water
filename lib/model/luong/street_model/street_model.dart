import 'package:intl/date_symbol_data_http_request.dart';
import 'package:web_smart_water/api/api.dart';
import 'package:web_smart_water/model/luong/street_model/street_view.dart';
import 'package:web_smart_water/ui/screen/luong_smart_water/data.dart';

import '../../template/template_model.dart';
import 'customers_view.dart';

class UserModel extends TemplateModel with StreetsView {
  late String user;
  List<StreetsModel>? streets;

  UserModel({this.user = '', this.streets}) {
    initValue();
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] ?? '';
    // streets = json['streets']??[];
    if (json['streets'] != null) {
      streets = <StreetsModel>[];
      json['streets'].forEach((v) {
        streets?.add(StreetsModel.fromJson(v));
      });
    }
    // data['user'] = user;
    // data['streets'] = streets;
    // if (streets.isNotEmpty) {
    //   data['streets'] = streets.map((v) => v.toJson()).toList();
    // }
  }

  Map<String, dynamic> toJson() {
    data['user'] = user;
    data['streets'] = streets;
    if (streets!.isNotEmpty) {
      data['streets'] = streets!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  // UserModel.fromJson(Map<String, dynamic> json) {
  //   user = json['user'];
  //   if (json['streets'] != null) {
  //     streets = <StreetsModel>[];
  //     json['streets'].forEach((v) {
  //       streets!.add(new StreetsModel.fromJson(v));
  //     });
  //   }
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['user'] = this.user;
  //   if (this.streets != null) {
  //     data['streets'] = this.streets!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class StreetsModel extends TemplateModel with StreetsView {
  var userName = '';
  String? code;
  String? name;
  List<CustomersModel>? customers;

  StreetsModel({this.code = '', this.name = '', this.customers}) {
    initValue();
  }

  StreetsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'] ?? '';
    name = json['name'] ?? '';
    if (json['customers'] != null) {
      customers = <CustomersModel>[];
      json['customers'].forEach((v) {
        customers!.add(CustomersModel.fromJson(v));
      });
    }

    userName = User.streets['$code']?.join(", ")?? '';
    // initValue();

    data['userName'] = userName;
    data['code'] = code;
    data['name'] = name;
    // data['customers'] = customers;
    if (customers!.isNotEmpty) {
      data['customers'] = customers!.map((v) => v.toJson()).toList();
    }
  }

  Map<String, dynamic> toJson() {
    data['userName'] = userName;
    data['code'] = code;
    data['name'] = name;
    // data['customers'] = customers;
    if (customers!.isNotEmpty) {
      data['customers'] = customers!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String getModelName() {
    return 'Danh sách đường phố';
  }

  @override
  Future<bool> create() async {
    data.remove('userName');
    data.remove('customers');
    return await api.createEditStreet(data);
  }

  @override
  Future<bool> update() async {
    data.remove('userName');
    data.remove('customers');
    return await api.createEditStreet(data);
  }

  @override
  Future<bool> delete() async {
    return await api.deleteDataStreet(data['code']);
  }
}

class CustomersModel extends TemplateModel with CustomerView {
  var username = '';
  var stress = '';
  late int idkh;
  late String danhbo;
  late String sdt;
  late String tenkh;
  late String diachi;
  late String loaigia;
  late String serialmodule;
  late String serialdh;
  late String hieudh;
  late String kichcodh;
  late String vitridh;
  late String longitude;
  late String latitude;
  late int sonk;
  late String beforevalue;
  late String baforetime;

  CustomersModel(
      {this.idkh = 0,
      this.danhbo = '',
      this.sdt = '',
      this.tenkh = '',
      this.diachi = '',
      this.loaigia = '',
      this.serialmodule = '',
      this.serialdh = '',
      this.hieudh = '',
      this.kichcodh = '',
      this.vitridh = '',
      this.longitude = '',
      this.latitude = '',
      this.sonk = 0,
      this.beforevalue = '',
      this.baforetime = ''}) {
    initValue();
  }

  CustomersModel.fromJson(Map<String, dynamic> json) {
    updateData(json);
    initValue();
  }

  Map<String, dynamic> toJson() {
    return data;
  }

  @override
  void initValue() {
    data['username'] = username;
    data['stress'] = stress;
    data['idkh'] = idkh;
    data['danhbo'] = danhbo;
    data['sdt'] = sdt;
    data['tenkh'] = tenkh;
    data['diachi'] = diachi;
    data['loaigia'] = loaigia;
    data['serialmodule'] = serialmodule;
    data['serialdh'] = serialdh;
    data['hieudh'] = hieudh;
    data['kichcodh'] = kichcodh;
    data['vitridh'] = vitridh;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['sonk'] = sonk;
    data['beforevalue'] = beforevalue;
    data['baforetime'] = baforetime;
    super.initValue();
  }

  @override
  updateData(Map<String, dynamic> json) {
    idkh = json['idkh'] ?? 0;
    danhbo = json['danhbo'] ?? '';
    sdt = json['sdt'] ?? '';
    tenkh = json['tenkh'] ?? '';
    diachi = json['diachi'] ?? '';
    loaigia = json['loaigia'] ?? '';
    serialmodule = json['serialmodule'] ?? '';
    serialdh = json['serialdh'] ?? '';
    hieudh = json['hieudh'] ?? '';
    kichcodh = json['kichcodh'] ?? '';
    vitridh = json['vitridh'] ?? '';
    longitude = json['longitude'] ?? '';
    latitude = json['latitude'] ?? '';
    sonk = json['sonk'] ?? 0;
    beforevalue = json['beforevalue'] ?? '';
    baforetime = json['baforetime'] ?? '';
    username = User.customer['$idkh']?[1] ?? '';
    stress = User.customer['$idkh']?[0] ?? '';
  }

  @override
  String getModelName() {
    // TODO: implement getModelName
    return 'Danh sách khách hàng';
  }

  @override
  TemplateModel getEmptyModel() {
    return CustomersModel();
  }

  @override
  Future<bool> create() async {
    data.remove('beforevalue');
    data.remove('baforetime');
    return await api.createEditDataCustomer(data);
  }

  @override
  Future<bool> delete() async {
    return await api.deleteDataCustomer(data['stress'], data['danhbo']);
  }
}
