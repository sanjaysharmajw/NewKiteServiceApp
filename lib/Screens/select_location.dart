// import 'dart:async';
// import 'package:http/http.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nirbhaya_service/contoller/place_details_controller.dart';
// import 'package:nirbhaya_service/widgets/images_set.dart';
// import '../ListItems/search_location_items.dart';
// import '../Models/search_location_model.dart';
// import '../Utils/loader.dart';
// import '../Utils/preference.dart';
// import 'package:location/location.dart';
// import '../color_constant.dart';
// import '../contoller/get_current_add_controller.dart';
// import '../contoller/search_location_controller.dart';
// import '../widgets/MyText.dart';
// import '../widgets/current_location.dart';
// import '../widgets/search_box_widget.dart';
//
//
// class SelectLocationScreen extends StatefulWidget {
//   const SelectLocationScreen({super.key});
//
//   @override
//   SelectLocationScreenState createState() => SelectLocationScreenState();
// }
//
// class SelectLocationScreenState extends State<SelectLocationScreen> {
//   List<SearchLocationModel> searchLocation = [];
//   final controller = Get.put(PlaceDetailsController());
//   final getCurrentController = Get.put(GetCurrentAddController());
//   String searchQuery = '';
//   bool? listVisible=false;
//   bool? emptyVisible=true;
//   bool servicestatus = false;
//   Location? location;
//   LocationData? locationData;
//
//   @override
//   void initState() {
//     super.initState();
//     location =  Location();
//     init();
//   }
//   Future init() async {
//     final books = SearchLocationModel.fromJson(searchQuery);
//     setState(() => searchLocation = books as List<SearchLocationModel>);
//   }
//   Future getCurrentLatLng() async {
//     CustomLoader.showLoader("Please wait");
//     locationData = await location!.getLocation();
//     getCurrentAddress(locationData!.latitude.toString(),locationData!.longitude.toString());
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     body: SafeArea(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           const SizedBox(height: 10),
//           Padding(
//             padding: const EdgeInsets.only(left: 18,right: 18,top: 15),
//             child: InkWell( onTap: (){
//               Get.back();
//             },child: Image.asset('assets/back_icons.png',width: 17,height: 17)),
//           ),
//           const SizedBox(height: 25),
//           // const MyText(text: 'Search Address', fontName: 'Gilroy',
//           //     fontSize: 20, fontWeight: FontWeight.w800, textColor: white),
//           //const SizedBox(height: 10),
//           SearchBoxWidgets(hintText: 'Search for area or street name...',fontSize: 18, changed: searchAddress),
//           const SizedBox(height: 20),
//           CurrentLocationBtn(click: () {getCurrentLatLng();},),
//           const SizedBox(height: 15),
//           const Divider(color: appLightGrey),
//           Visibility(
//               visible: listVisible!,
//               child: Expanded(
//             child: ListView.builder(
//                 itemCount: searchLocation.length,
//                 itemBuilder: (context, index) {
//                   return SearchLocationItems(
//                       searchLocationModel: searchLocation[index], click: () {
//                     _sendDataBack(context,searchLocation[index].placeId.toString());
//                   });
//                 }
//                 ),
//           )
//           ),
//           Visibility(
//               visible: emptyVisible!,
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const[
//                     SizedBox(height: 110),
//                     ImageSets(imagePath: 'assets/location_not_found.png', width: 70, height: 70, color: appWhiteColor),
//                     SizedBox(height: 20),
//                     MyText(text: 'No Address Found', fontName:
//                     'Gilroy', fontSize: 18, fontWeight: FontWeight.w600, textColor: appWhiteColor)
//                   ],
//                 ),
//               )
//           ),
//
//         ],
//       ),
//     ),
//   );
//
//   void _sendDataBack(BuildContext context,String placeId) {
//     Navigator.pop(context, placeId);
//   }
//
//   void searchAddress(String searchQuery) async {
//     if(searchQuery.length>2){
//       listVisible=true;
//       emptyVisible=false;
//       final books = await SearchLocationController.searchLocation(searchQuery);
//       if (!mounted) return;
//       setState(() {
//         this.searchQuery = searchQuery;
//         searchLocation = books!;
//       });
//     }else {
//       setState(() {
//         listVisible=false;
//         emptyVisible=true;
//       });
//     }
//   }
//   void getCurrentAddress(String lat,String lng)async{
//     await getCurrentController.getCurrentApi(lat,lng).then((value) async {
//       if (value != null) {
//         if (value.status == true) {
//           _sendDataBack(context,value.result![0].placeId.toString());
//         }
//       }
//     });
//   }
// }
