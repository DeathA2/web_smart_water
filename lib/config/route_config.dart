import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../controller/app_controller.dart';
class RouteConfig{
  static final List<RouteToPage> _routeToPage = [
    // RouteToPage(name: '/', page: const SplashScreen(),roles: []),
    // RouteToPage(name: '/permission_denied', page: const PermissionDeniedScreen(),roles: []),
    // RouteToPage(name: '/login', page: ResponsiveLoginPage(
    //     desktopBody: const LogInPage(),
    //     mobileBody: const LogInMobilePage()), roles: []
    // ),
    // RouteToPage(name: '/home', page: HomeScreen(),roles: ['admin','operation','manager']),
    // RouteToPage(name: '/cau_hinh', page: ConfigScreen(),roles: ['admin','operation','manager']),
    // RouteToPage(name: '/cau_hinh_danh_muc', page: ConfigScreen(),roles: ['admin','operation','manager']),
    // RouteToPage(name: '/cau_hinh_tai_khoan', page: ConfigAccountScreen(),roles: ['admin','operation','manager']),
  ];
  final List<GetPage> _route = _routeToPage.map((route) => GetPage(name: route.name, page: () => route.page)).toList();

  final List<RouteModel> _navbar = [
  //   RouteModel(route: '/thong_ke', label: 'Thống kê',group: '/thong_ke',children: [
  //     RouteModel(route: '/thong_ke_xuat_nhap', label: 'Thống kê xuất nhập',group: '/thong_ke',children: [],screen: const DashboardInOutScreen()),
  //     RouteModel(route: '/thong_ke_van_chuyen', label: 'Thống kê vận chuyển',group: '/thong_ke',children: [],screen: const DashboardTransportScreen()),
  //   ],screen: Container()),
  //   RouteModel(route: '/bao_cao', label: 'Báo cáo',group: '/bao_cao',screen: const ListReportScreen(),children: [
  //     RouteModel(route: '/bao_cao_nhap_kho', label: 'Báo cáo nhập kho',group: '/bao_cao',children: [],screen: const ReportImportScreen()),
  //     RouteModel(route: '/bao_cao_xuat_kho', label: 'Báo cáo xuất kho',group: '/bao_cao',children: [],screen: const ReportExportScreen()),
  //     RouteModel(route: '/bao_cao_van_chuyen', label: 'Báo cáo vận chuyển',group: '/bao_cao',children: [],screen: const ReportTransportScreen()),
  //     RouteModel(route: '/bao_cao_loi', label: 'Báo cáo lỗi',group: '/bao_cao',children: [],screen: const ReportErrorScreen()),
  //     RouteModel(route: '/bao_cao_thong_tin_lo', label: 'Báo cáo thông tin lô',group: '/bao_cao',children: [],screen: const ReportLotScreen()),
  //     RouteModel(route: '/bao_cao_thong_tin_lo_unit', label: 'Báo cáo thông tin Lot Unit',group: '/bao_cao',children: [],screen: const ReportUnitLotScreen()),
  //     RouteModel(route: '/bao_cao_thong_tin_kho', label: 'Báo cáo tồn kho',group: '/bao_cao',children: [],screen: const ReportWareHouseScreen()),
  //     RouteModel(route: '/bao_cao_thong_tin_don_hang', label: 'Báo cáo thông tin đơn hàng',group: '/bao_cao',children: [],screen: const ReportOrderScreen()),
  //   ]),
  //   RouteModel(route: '/bien_ban', label: 'Biên bản',children: [],group: '/bien_ban',screen: const RecordScreen()),
  //   RouteModel(route: '/cau_hinh', label: 'Cấu hình',group: '/cau_hinh',children: [
  //     RouteModel(route: '/cau_hinh_danh_muc', label: 'Cấu hình danh mục',group: '/cau_hinh',children: [],screen: ConfigScreen()),
  //     RouteModel(route: '/cau_hinh_tai_khoan', label: 'Cấu hình tài khoản',group: '/cau_hinh',children: [],screen: ConfigAccountScreen()),
  //   ],screen: Container()),
  //   RouteModel(route: '/chot_so', label: 'Chốt số',group: '/chot_so',screen: const ListReportFinalizationScreen(),children: [
  //     RouteModel(route: '/bao_cao_chot_so_nhap', label: 'Báo cáo chi tiết nhập kho',group: '/chot_so',children: [],screen: const ReportImportFinalizationScreen()),
  //     RouteModel(route: '/bao_cao_chot_so_xuat', label: 'Báo cáo chi tiết xuất kho',group: '/chot_so',children: [],screen: const ReportExportFinalizationScreen()),
  //     RouteModel(route: '/bao_cao_chot_so_xuat_nhap_ton', label: 'Báo cáo chi tiết nhập xuất tồn',group: '/chot_so',children: [],screen: const ReportInventoryFinalizationScreen()),
  //     RouteModel(route: '/bao_cao_chot_so_boc_do', label: 'Báo cáo chi tiết bốc dỡ theo thiết bị',group: '/chot_so',children: [],screen: const ReportTransportFinalizationScreen()),
  //     RouteModel(route: '/bao_cao_chot_so_boc_tb', label: 'Báo cáo chi tiết bốc theo thiết bị',group: '/chot_so',children: [],screen: const ReportDstDeviceFinalizationScreen()),
  //     RouteModel(route: '/bao_cao_chot_so_do_tb', label: 'Báo cáo chi tiết dỡ theo thiết bị',group: '/chot_so',children: [],screen: const ReportSrcDeviceFinalizationScreen()),
  //     RouteModel(route: '/bao_cao_chot_so_boc_do_luy_ke', label: 'Báo cáo chi tiết bốc dỡ theo thiết bị có lũy kế',group: '/chot_so',children: [],screen: const ReportDeviceCumulativeFinalizationScreen()),
  //     RouteModel(route: '/bao_cao_chot_so_boc_tb_luy_ke', label: 'Báo cáo chi tiết bốc theo thiết bị có lũy kế',group: '/chot_so',children: [],screen: const ReportFinalizationDeviceCumulativeDstScreen()),
  //     RouteModel(route: '/bao_cao_chot_so_do_tb_luy_ke', label: 'Báo cáo chi tiết dỡ theo thiết bị có lũy kế',group: '/chot_so',children: [],screen: const ReportFinalizationDeviceCumulativeSrcScreen()),
  //     RouteModel(route: '/bao_cao_chot_so_bao_loi', label: 'Báo cáo chi tiết bao lỗi',group: '/chot_so',children: [],screen: const ReportErrorFinalizationScreen()),
  //     RouteModel(route: '/bao_cao_chot_so_ton_dau', label: 'Báo cáo chi tiết tồn kho',group: '/chot_so',children: [],screen: const ReportInventoryBeginFinalizationScreen()),
  //   ]),
  //   RouteModel(route: '/qr_code', label: 'QR Code',children: [],group: '/qr_code',screen: const QrCodeScreen()),

  ];
  // List<GetPage> get getRoute => [
  //   GetPage(name: '/order', page: () => ResponsiveOrderPage(desktopBody: const OrderPage(), mobileBody: const OrderMobilePage())),
  //   GetPage(name: '/search_order', page: () => const SearchOrderPage()),
  //   GetPage(name : '/dang_ky_don_hang', page: () => const AddProduct()),
  //   GetPage(name : '/test', page: () => const ToastMotion()),
  //   GetPage(name : '/', page: () => const SplashScreen()),
  //   GetPage(name : '/home', page: () => HomeScreen()),
  //   GetPage(name : '/permission_denied', page: () => const PermissionDeniedScreen()),
  //   GetPage(name : '/login', page: () => ResponsiveLoginPage(
  //       desktopBody: const LogInPage(),
  //       mobileBody: const LogInMobilePage())),
  // ];
  // List<GetPage> get getRoute => _route;
  List<RouteModel> getNavbar (){
    List<RouteModel> list = [];
    for(RouteModel model in _navbar){
      List<RouteToPage> listRouteToPage = [];
      listRouteToPage.addAll(_routeToPage.where((element) => element.name == model.route).toList());
      if(listRouteToPage.isNotEmpty){
        RouteToPage route = listRouteToPage.first;
        if(route.roles.isEmpty || route.roles.contains(appController.role)){
          list.add(model);
        }
      }
    }
    return list;
  }

  List<RouteToPage> get getRouteToPage => _routeToPage;
}

class RouteModel{
  final String route;
  final String label;
  final String group;
  final List<RouteModel> children;
  final Widget screen;
  RouteModel({required this.route,required this.label,required this.group,required this.children,required this.screen});
}

class RouteToPage{
  final String name;
  final Widget page;
  final List<String> roles;
  RouteToPage({required this.name,required this.page,required this.roles});
}