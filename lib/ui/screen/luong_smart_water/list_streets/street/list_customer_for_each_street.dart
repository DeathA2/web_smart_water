// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_rx/get_rx.dart';
// import 'package:web_smart_water/api/api.dart';
// import 'package:web_smart_water/model/luong/street_model/street_model.dart';
// import 'package:web_smart_water/ui/item/template_web/list_view/list_view.dart';
// import 'package:web_smart_water/ui/screen/luong_smart_water/data.dart';
// import 'package:web_smart_water/ui/widget/loading_screen.dart';
//
// class ListCustomersEachStreetScreen extends StatefulWidget {
//   const ListCustomersEachStreetScreen({Key? key}) : super(key: key);
//
//   @override
//   _ListCustomersEachStreetScreenState createState() => _ListCustomersEachStreetScreenState();
// }
//
// class _ListCustomersEachStreetScreenState extends State<ListCustomersEachStreetScreen> {
//
//   //
//   // @override
//   // Widget build(BuildContext context) {
//   //   return SingleChildScrollView(
//   //     child: FutureBuilder(
//   //       future: getData(),
//   //       builder: (BuildContext context,
//   //           AsyncSnapshot<List<CustomersModel>> snapshot) {
//   //         if (snapshot.connectionState != ConnectionState.done) {
//   //           return const Center(child: LoadingScreen());
//   //         }
//   //         return MyListView(
//   //             listDataModel: snapshot.data!.obs,
//   //             template: CustomersModel().getListViewTemplate(),
//   //             typeModel: CustomersModel());
//   //       },
//   //     ),
//   //   );
//   // }
//   @override
//   Widget build(BuildContext context){
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(flex: 5,child: _buildSmallInfor()),
//             // _buildSpaceRow(),
//             Expanded(flex: 15,child: _buildListCus()),
//           ],
//         )
//       ],
//     );
//   }
//
//   Widget _buildSmallInfor(){
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 30),
//       decoration: BoxDecoration(
//           border: Border.all()
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(15),
//             width: Get.width,
//             color: Colors.grey.withOpacity(0.25),
//             child: Center(child: Text(User.code)),
//           ),
//           Divider(height: 1,),
//           Container(
//             padding: EdgeInsets.all(20),
//             width: Get.width,
//             child: ,
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildListCus(){
//     return Container();
//   }
// }
