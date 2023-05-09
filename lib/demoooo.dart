// import 'dart:async';
// import 'dart:math';
// import 'package:safe_travel/NewDriveApp/co_passanger/co_passanger_screen.dart';
// import 'package:safe_travel/NewDriveApp/models/up_down_modes.dart';
// import 'package:vector_math/vector_math.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:safe_travel/NewDriveApp/bottom_navigation/custom_bottom_navigation.dart';
// import 'package:safe_travel/NewDriveApp/color_constant.dart';
// import 'package:safe_travel/NewDriveApp/contoller/multiple_routes_controller/multiple_routes_controller.dart';
// import 'package:safe_travel/NewDriveApp/contoller/multiple_routes_controller/routes_request_body.dart';
// import 'package:safe_travel/NewDriveApp/contoller/permision_controller.dart';
// import 'package:safe_travel/NewDriveApp/driver_widgets/my_new_text.dart';
// import 'package:safe_travel/NewDriveApp/utils/DriverCustomLoader.dart';
// import 'package:safe_travel/NewDriveApp/utils/MyPreferences.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:url_launcher/url_launcher.dart';
// import 'MapAddFamily.dart';
// import 'Models/GeocodeResultModel.dart';
// import 'NewDriveApp/contoller/emit_socket_connect_controller.dart';
// import 'NewDriveApp/contoller/end_ride_controller.dart';
// import 'NewDriveApp/contoller/group_list_controller.dart';
// import 'NewDriveApp/contoller/qr_scan_vehicle_list_controller.dart';
// import 'NewDriveApp/contoller/sos_push_notification.dart';
// import 'NewDriveApp/contoller/sos_reason_master_controller.dart';
// import 'NewDriveApp/utils/map_marker_utils.dart';
// import 'Remote/Api_Url.dart';
// import 'UserFamily/familylist_widget.dart';
// import 'Utils/constant.dart';
// import 'Utils/preferences.dart';
// import 'Utils/round_text_widgets.dart';
// import 'Utils/showExitPopup.dart';
// import 'chat_bot/ChatScreen.dart';
// import 'package:geolocator/geolocator.dart';
//
// class StartRide extends StatefulWidget {
//   const StartRide({Key? key,
//     required this.riderId,
//     required this.vehicelId,
//     required this.socketToken, required this.endPointLat, required this.endPointLng})
//       : super(key: key);
//
//   @override
//   State<StartRide> createState() => _SignUpState();
//   final String riderId;
//   final String vehicelId;
//   final double endPointLat;
//   final double endPointLng;
//   final String socketToken;
// }
//
// class _SignUpState extends State<StartRide> {
//   Timer? timer;
//   late IO.Socket socket;
//   late Location location;
//   LocationData? currentLocation;
//   double? heading;
//   double speed=0.0;
//   String id = '';
//   var gender = '';
//   String? sosStatus = 'Ok';
//   bool layoutVisibility = true;
//
//
//   List mySelection = [];
//   late double destinationMarkerLat = 0.0;
//   late double destinationMarkerLng = 0.0;
//   final Completer<GoogleMapController> _completer = Completer();
//
//   BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
//   BitmapDescriptor startSourceIcon = BitmapDescriptor.defaultMarker;
//   BitmapDescriptor endSourceIcon = BitmapDescriptor.defaultMarker;
//   BitmapDescriptor stopIcons = BitmapDescriptor.defaultMarker;
//
//
//   static const LatLng destinationLocation =
//   LatLng(19.067949048869405, 73.0039520555996);
//   List<LatLng> polylineCoordinates = [];
//   List<LatLng> livePolylineCoordinates = [];
//
//
//   Set<Marker> markers = {};
//   LatLng? source;
//   Map<PolylineId, Polyline> polyLines = <PolylineId, Polyline>{};
//   int polyLineIdCounter = 1;
//   final getRoutesController=Get.put(RoutesListController());
//   StreamSubscription<Position>? positionStream;
//   List<LatLng> listLocations = [];
//
//   static const CameraPosition _cameraPosition = CameraPosition(
//     target: destinationLocation,
//     zoom: 18,
//   );
//
//   final scanVehicleDetailsController = Get.put(ScanVehiclesDetailsController());
//   final groupListController = Get.put(GroupListController());
//   final sosReasonController = Get.put(SosReasonMasterController());
//   final sosPushNotificationController = Get.put(SosPushNotificationController());
//   final endRideController = Get.put(EndRideController());
//   final socketConnectController = Get.put(EmitSocketConnectController());
//   final permissionController = Get.put(PermissionController());
//
//   @override
//   void initState() {
//     multipleRoutes(widget.riderId.toString());
//     apiController();
//     super.initState();
//     polylineCoordinates.clear();
//     _initUser();
//     setCustomMarkerIcon();
//     sharePre();
//     setState(() {});
//   }
//
//   multipleRoutes(String rideId)async{
//     RoutesRequestBody routesModels=RoutesRequestBody(
//         rideId: rideId,
//         userId: MyPreferences.getId().toString(),
//         showstops: true
//     );
//     await getRoutesController.getRoutesAPi(routesModels);
//     for(int i=0;i<getRoutesController.getRoutesData.length; i++){
//       double lat =double.parse(getRoutesController.getRoutesData[i].locationdetails!.lat!.toString());
//       double lng =double.parse(getRoutesController.getRoutesData[i].locationdetails!.lng!.toString());
//       listLocations.add(LatLng(lat,lng));
//       polyLines.clear();
//     }
//
//   }
//   void updateMultipleRoutes(String stopName)async{
//     RoutesRequestBody routesModels=RoutesRequestBody(
//         rideId: widget.riderId.toString(),
//         userId: MyPreferences.getId().toString(),
//         showstops: true,
//         stopName: stopName
//     );
//     await getRoutesController.getRoutesUpdateAPi(routesModels);
//   }
//
//
//   void apiController()async{
//     await scanVehicleDetailsController.getQRVehicleDetails(widget.vehicelId.toString());
//     await sosReasonController.sosReasonMasterApi();
//   }
//
//   void sharePre() async {
//     await MyPreferences.setPreferences();
//     gender = MyPreferences.getGender().toString();
//     await socketConnect(widget.socketToken);
//     setState(() async {
//       await permissionController.permissionLocation();
//     });
//   }
//
//   void setCustomMarkerIcon() {
//     BitmapDescriptor.fromAssetImage(
//       ImageConfiguration.empty, 'new_assets/top_front_car.png',)
//         .then((icon) {
//       sourceIcon = icon;
//     });
//
//     BitmapDescriptor.fromAssetImage(
//         ImageConfiguration.empty, 'assets/to_map_pin.png')
//         .then((icon) {
//       startSourceIcon = icon;
//     });
//
//     BitmapDescriptor.fromAssetImage(
//         ImageConfiguration.empty, 'new_assets/stop_marker.png')
//         .then((icon) {
//       stopIcons = icon;
//     });
//
//     BitmapDescriptor.fromAssetImage(
//         ImageConfiguration.empty, 'new_assets/destination_marker.png')
//         .then((icon) {
//       endSourceIcon = icon;
//     });
//   }
//
//   void _initUser() async {
//     location = Location();
//     location.enableBackgroundMode(enable: true);
//     location.changeNotificationOptions(
//         iconName: 'images/rider_launcher.png',
//         channelName: 'Nirbhaya',
//         title: 'Nirbhaya app is running');
//     location.onLocationChanged.listen((LocationData cLoc) async {
//       currentLocation = cLoc;
//       speed=cLoc.speed!;
//
//       source = LatLng(cLoc.latitude!, cLoc.longitude!);
//       markers.clear();
//       sendRequest();
//
//       // Calculate the distance between the two coordinates using the distance property
//       for(int i=0;i<listLocations.length; i++){
//         double distanceInMeters = Geolocator.distanceBetween(
//             cLoc.latitude!, cLoc.longitude!,
//             listLocations[i].latitude, listLocations[i].longitude
//         );
//         if (distanceInMeters < 10) {
//           if(listLocations.isNotEmpty){
//             updateMultipleRoutes(getRoutesController.getRoutesData[0].stopName.toString());
//             multipleRoutes(widget.riderId.toString());
//           }
//           listLocations.removeAt(i);
//           polyLines.clear();
//           markers.clear();
//           polyLines.remove(i);
//           markers.remove(i);
//         }
//       }
//       final GoogleMapController controller = await _completer.future;
//       controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//           target: LatLng(cLoc.latitude!, cLoc.longitude!), zoom: 19)));
//       setState(() {});
//
//       await Preferences.setPreferences();
//       var socketEmit={
//         "message": {
//           'lat': currentLocation!.latitude!,
//           'lng': currentLocation!.longitude!,
//           'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
//           //'status':"Ok/sos/resolved/responded/escalated",
//           'status':sosStatus.toString(),
//           'sub_status':reason.toString(),
//           'vehicle_type':scanVehicleDetailsController.getVehicleDetailsData[0].model.toString(),
//           'gender':gender.toString(),
//           'driver_license':'122333',
//           'vehicle_no':scanVehicleDetailsController.getVehicleDetailsData[0].registrationNumber.toString(),
//           'altitude':currentLocation!.altitude,
//           'speed':currentLocation!.speed.toString(),
//           'speedAccuracy':currentLocation!.speedAccuracy.toString(),
//           'elapsedRealtimeNanos':currentLocation!.elapsedRealtimeNanos.toString(),
//           'elapsedRealtimeUncertaintyNanos':currentLocation!.elapsedRealtimeUncertaintyNanos.toString(),
//           'accuracy':currentLocation!.accuracy.toString(),
//           'heading':currentLocation!.heading.toString(),
//           'headingAccuracy':currentLocation!.headingAccuracy.toString(),
//           'provider':currentLocation!.provider.toString(),
//           'satelliteNumber':currentLocation!.satelliteNumber.toString(), //satellite no 0 check it
//           'verticalAccuracy':currentLocation!.verticalAccuracy.toString(),
//           'h_dop':currentLocation!.accuracy!/5,
//           'v_dop':currentLocation!.accuracy!/currentLocation!.verticalAccuracy!,
//           'time':currentLocation!.time.toString()
//         },
//         "roomName": widget.riderId.toString(),
//       };
//       socket.emit("message", socketEmit);
//       setState(() {
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     socket.disconnect();
//     super.dispose();
//   }
//
//   final TextEditingController destinationController = TextEditingController();
//   final TextEditingController fieldTextEditingController =
//   TextEditingController();
//   final ScrollController scrollController = ScrollController();
//   List<Result> locationData = [];
//   String? reason='';
//   bool isSelected = false;
//
//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(context, designSize: const Size(375, 812));
//     return SafeArea(
//       child: Scaffold(
//         body: Column(children: [
//           Expanded(
//             child: currentLocation==null
//                 ?Center(child: DriverCustomLoader.showLoader('Please Wait\nMap is loading')):
//             Stack(
//               children: [
//                 GoogleMap(
//                   initialCameraPosition: CameraPosition(
//                     target: source!,
//                     zoom: 14.0,
//                   ),
//                   mapType: MapType.normal,
//                   myLocationEnabled: false,
//                   compassEnabled: true,
//                   zoomControlsEnabled: false,
//                   mapToolbarEnabled: true,
//                   zoomGesturesEnabled: true,
//                   myLocationButtonEnabled: true,
//                   polylines: Set<Polyline>.of(polyLines.values),
//                   markers: markers,
//                   onMapCreated: (GoogleMapController controller) {
//                     _completer.complete(controller);
//                     controller.setMapStyle(permissionController.mapStyle);
//                   },
//                 ),
//                 Visibility(
//                     visible: layoutVisibility,
//                     child: visibleLayout()
//                 ),
//               ],
//             ),
//           ),
//           Visibility(
//               visible: layoutVisibility,
//               child: bottomContainer()
//           ),
//         ]),
//       ),
//     );
//   }
//   Future<void> socketConnect(String token) async {
//     try {
//       socket = IO.io(ApiUrl.socketUrl, <String, dynamic>{
//         'transports': ['websocket'],
//         'autoConnect': true,
//         'extraHeaders': {'authorization': token.toString()}
//       });
//       socket.connect();
//       // Subscribe to events
//       socket.on('connect', (_) {
//         debugPrint('Connected to the server');
//       });
//       socket.on('disconnect', (_) {
//         debugPrint('Disconnected from the server');
//       });
//       socket.on('event', (data) {
//         debugPrint('Received event: $data');
//       });
//       socket.on('error', (error) {
//         debugPrint('Error: $error');
//       });
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
//
//   void endRideApi(String rideId,String lat,String lng) async {
//     await endRideController.endRideApi(rideId, lat, lng).then((value) async {
//       if (value != null) {
//         if (value.status == true) {
//           DriverCustomLoader.closeLoader();
//           Get.offAll(const CustomBottomNav());
//           DriverCustomLoader.message('End Successful');
//         }
//       }
//     });
//   }
//
//   void sosPushNotificationApi(String reason,String rideId,String lat,String lng)async{
//     await sosPushNotificationController.sosPushNotificationApi(reason, rideId, lat, lng).then((value) async {
//       if (value != null) {
//         if (value.status == true) {
//           DriverCustomLoader.message(value.message.toString());
//           Navigator.pop(context);
//         }else{
//           DriverCustomLoader.message(value.message.toString());
//           Navigator.pop(context);
//         }
//       }
//     });
//   }
//
//   // void shareData() {
//   //   RenderBox box = context.findRenderObject() as RenderBox;
//   //   Share.share(
//   //       "Hi! Nirbhaya...Welcome to the new way to easily share your real-time location with your friends, family, co-workers, customers, suppliers, and more.\n\n"
//   //           "Driver Name: ${scanVehicleDetailsController.getVehicleDetailsData[0].driverName}, Driver Mobile Number : ${scanVehicleDetailsController.getVehicleDetailsData[0].driverMobileNumber}, "
//   //           "Model : ${scanVehicleDetailsController.getVehicleDetailsData[0].model}, Owner Name: ${scanVehicleDetailsController.getVehicleDetailsData[0].ownerName}, "
//   //           "Registration Number: ${scanVehicleDetailsController.getVehicleDetailsData[0].registrationNumber}, "
//   //           "Hey check out my app at: https://play.google.com/store/apps/details?id=com.rider_safe_travel.ride_safe_travel",
//   //       subject: "Description",
//   //       sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
//   // }
//
//   Widget bottomContainer(){
//     return   Container(
//       decoration:  BoxDecoration(
//         color: appWhiteColor,
//         boxShadow: [
//           BoxShadow(
//             color: appBlack.withOpacity(0.5),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: const Offset(0, 3), // changes position of shadow
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//             vertical: 10.0.h, horizontal: 20.0.w),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           showExitPopup(context, "Do you want to stop ride?", () async {
//                             endRideApi(widget.riderId.toString(), currentLocation!.latitude.toString(), currentLocation!.longitude.toString());
//                           });
//                         },
//                         child: Column(
//                           children: [
//                             Image.asset("new_assets/end_ride.png",
//                                 width: 45.w, height: 45.h),
//                             SizedBox(height: 10.h),
//                             Text("End Ride",
//                                 style: TextStyle(
//                                     fontFamily: 'Gilroy',
//                                     fontSize: 12.sp)),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       // Get.to(const MapFamilyAdd());
//                       Get.to(const FamilyList());
//                     },
//                     child: Column(
//                       children: [
//                         Image.asset("new_assets/add_family_icon.png",
//                             width: 45.w, height: 45.h),
//                         SizedBox(height: 10.h),
//                         Text("Add Family",
//                             style: TextStyle(
//                                 fontFamily: 'Gilroy',
//                                 fontSize: 12.sp)),
//                       ],
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       await launchUrl(Uri.parse('google.navigation:q=${widget.endPointLat}, ${widget.endPointLng}&key=AIzaSyAmOl-QJnc2Spwuh8GAoqx9Z3Wz-ez73V8'));
//                     },
//                     child: Column(
//                       children: [
//                         Image.asset("new_assets/navigation_icon.png",
//                             width: 45.w, height: 45.h),
//                         SizedBox(height: 10.h),
//                         Text("Navigate",
//                             style: TextStyle(
//                                 fontFamily: 'Gilroy',
//                                 fontSize: 12.sp)),
//                       ],
//                     ),
//                   ),
//
//                   Column(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return StatefulBuilder(
//                                     builder: (BuildContext context, StateSetter setState) {
//                                       return AlertDialog(
//                                         content: SizedBox(
//                                           height: 190,
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               const Text("Are you in trouble? Please select your reason:",style: TextStyle(fontFamily: 'Gilroy')),
//                                               const SizedBox(height: 15),
//                                               Column(
//                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                                 children: <Widget>[
//                                                   SizedBox(
//                                                     height: 65,
//                                                     child: Card(
//                                                       color: appWhiteColor,
//                                                       shape: OutlineInputBorder(
//                                                           borderRadius: BorderRadius.circular(5),
//                                                           borderSide: const BorderSide(color: appBlack)),
//                                                       child: Padding(
//                                                         padding: const EdgeInsets.all(15),
//                                                         child: DropdownButton(
//                                                           underline: Container(),
//                                                           icon: const Icon(Icons.keyboard_arrow_down),
//                                                           isDense: true,
//                                                           isExpanded: true,
//                                                           items: sosReasonController.getSosReasonMasterData.map((e) {
//                                                             return DropdownMenuItem(
//                                                               value: e.name.toString(),
//                                                               child: Text(e.name.toString(),style: const TextStyle(fontFamily: 'Gilroy')),
//                                                             );
//                                                           }).toList(),
//                                                           value: reason!.isNotEmpty ? reason : null,
//                                                           hint: const Text('Select Reason',style:  TextStyle(fontFamily: 'Gilroy'),),
//                                                           onChanged: (value) {
//                                                             setState(() {
//                                                               sosStatus="SOS";
//                                                               reason = value;
//                                                               isSelected = true;
//                                                             });
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               const SizedBox(height: 20,),
//                                               Row(
//                                                 children: [
//                                                   Expanded(
//                                                     child: ElevatedButton(onPressed: () {
//                                                       sosPushNotificationApi(reason!, widget.riderId.toString(), currentLocation!.latitude.toString(), currentLocation!.longitude.toString());
//                                                     },
//                                                       style: ElevatedButton.styleFrom(
//                                                           elevation: 0,
//                                                           backgroundColor: appBlack),
//                                                       child:  const Text("Yes",style: TextStyle(color: appWhiteColor,fontFamily: 'Gilroy')),
//                                                     ),
//                                                   ),
//                                                   const SizedBox(width: 15),
//                                                   Expanded(
//                                                       child: ElevatedButton(
//                                                         onPressed: () {
//                                                           debugPrint('no selected');
//                                                           Navigator.of(context).pop();
//                                                         },
//                                                         style: ElevatedButton.styleFrom(
//                                                           elevation: 0,
//                                                           backgroundColor: appBlack,
//                                                         ),
//                                                         child: const Text("No", style: TextStyle(color: appWhiteColor,fontFamily: 'Gilroy')),
//                                                       ))
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     }
//                                 );
//                               });
//                         },
//                         child: Column(
//                           children: [
//                             Image.asset("new_assets/sos_icons.png",
//                                 width: 45.w, height: 45.h),
//                             SizedBox(height: 10.h),
//                             Text("SOS",
//                                 style: TextStyle(
//                                     fontFamily: 'Gilroy',
//                                     fontSize: 12.sp)),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   Widget visibleLayout(){
//     return Stack(
//       children: [
//         speedWidget(),
//         connect(),
//         header(),
//       ],
//     );
//   }
//   Widget speedWidget(){
//     return Align(
//       alignment: Alignment.bottomRight,
//       child: roundTextWidget(textValue:
//       speed.toStringAsFixed(1)),
//     );
//   }
//   Widget connect(){
//     return  Align(
//       alignment: Alignment.bottomRight,
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 60,right: 10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             InkWell( onTap: (){
//               Get.to(const ChatScreen());
//             },child: Image.asset('new_assets/chat_icon.png',width: 50,height: 50)),
//             const SizedBox(height: 10),
//             InkWell( onTap: (){
//               Get.to(DriverCoPassScreen(rideId: widget.riderId.toString()));
//             },child: Image.asset('new_assets/co_passange.png',width: 50,height: 50)),
//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget header(){
//     return  Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Align(
//         alignment: Alignment.topLeft,
//         child: Row(
//           children: [
//             InkWell( highlightColor: appBlack,onTap: (){
//               Get.offAll(const CustomBottomNav());
//             },child: Image.asset('new_assets/back_qr.png',width: 35,height: 35)),
//             const SizedBox(width: 10),
//             const NewMyText(textValue: 'Ongoing Journey', fontName: 'Gilroy',
//                 color: appBlack, fontWeight: FontWeight.w700, fontSize: 16),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void sendRequest() {
//     getMultiplePolyLines();
//     addMarker();
//   }
//
//   // here we simply assign the bytes which we get from the icon common method to the marker
//   Future<void> addMarker() async {
//     markers.add(Marker(
//         rotation: currentLocation!.heading!,
//         anchor: const Offset(0.5, 0.5),
//         markerId: MarkerId(source.toString()),
//         position: source!,
//         icon: sourceIcon
//     ));
//
//     for(int i=0;i<listLocations.length;i++){
//       markers.add(Marker(
//         markerId: MarkerId(listLocations[i].toString()),
//         icon: stopIcons,
//         anchor: const Offset(0.5, 0.5),
//         infoWindow: InfoWindow(
//           title: getRoutesController.getRoutesData[i].stopName,
//         ),
//         position: listLocations[i],
//       ));
//       markers.remove(listLocations.last);
//     }
//
//     markers.add(Marker(
//         anchor: const Offset(0.5, 0.5),
//         markerId: MarkerId(listLocations.last.toString()),
//         position: listLocations.last,
//         icon: endSourceIcon
//     ));
//
//
//
//
//   }
//
//   getMultiplePolyLines() async {
//     await Future.forEach(listLocations, (LatLng elem) async {
//       await _getRoutePolyline(
//         start: source!,
//         finish: elem,
//         color: appBlack,
//         id: 'firstPolyline $elem',
//         width: 4,
//       );
//     });
//     setState(() {});
//   }
//
//   Future<Polyline> _getRoutePolyline(
//       {required LatLng start,
//         required LatLng finish,
//         required Color color,
//         required String id,
//         int width = 6}) async {
//     // Generates every polyline between start and finish
//     final polylinePoints = PolylinePoints();
//     // Holds each polyline coordinate as Lat and Lng pairs
//     final List<LatLng> polylineCoordinates = [];
//     final startPoint = PointLatLng(start.latitude, start.longitude);
//     final finishPoint = PointLatLng(finish.latitude, finish.longitude);
//
//     final result = await polylinePoints.getRouteBetweenCoordinates(
//       googleMapKey,
//       travelMode: TravelMode.driving,
//       startPoint,
//       finishPoint,
//     );
//
//     if (result.points.isNotEmpty) {
//       for (var point in result.points) {
//         polylineCoordinates.add(
//           LatLng(point.latitude, point.longitude),
//         );
//       }
//     }
//
//     polyLineIdCounter++;
//     final Polyline polyline = Polyline(
//         polylineId: PolylineId(id),
//         consumeTapEvents: true,
//         points: polylineCoordinates,
//         color: appBlack,
//         width: 4);
//     setState(() {
//       polyLines[PolylineId(id)] = polyline;
//     });
//     return polyline;
//   }
// }
