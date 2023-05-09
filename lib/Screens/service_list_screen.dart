// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nirbhaya_service/color_constant.dart';
// import 'package:nirbhaya_service/contoller/service_list_controller.dart';
// import '../Utils/loader.dart';
// import '../display_items/service_requet_items.dart';
// import '../widgets/MyText.dart';
//
// class ServiceListScreen extends StatefulWidget {
//   const ServiceListScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ServiceListScreen> createState() => _ServiceListScreenState();
// }
//
// class _ServiceListScreenState extends State<ServiceListScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return GetX<ServiceListController>(
//         init: ServiceListController(),
//         builder: (controller) {
//           return SafeArea(
//             child: Scaffold(
//               backgroundColor: appWhiteColor,
//               body: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.only(left: 20,top: 20),
//                     child: MyText(text: 'Service List', fontName: 'Gilroy',
//                         fontSize: 20, fontWeight: FontWeight.w800, textColor: appBlack),
//                   ),
//                   const SizedBox(height: 20),
//                   controller.isLoading.value
//                       ? CustomLoader.loader()
//                       : controller.getServiceData.isEmpty
//                       ? const Center(
//                     child: Text('Empty'),
//                   ) : Expanded(
//                     child: ListView.builder(
//                         itemCount: controller.getServiceData.length,
//                         shrinkWrap: true,
//                         itemBuilder: (context, index) {
//                           return ServiceRequestItems(serviceListData: controller.getServiceData[index]);
//                         }),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }
