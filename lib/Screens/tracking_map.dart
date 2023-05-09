import 'dart:async';
import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nirbhaya_service/BodyRequest/complete_service_request_body.dart';
import 'package:nirbhaya_service/Models/service_list_models.dart';
import 'package:nirbhaya_service/Models/start_ride_modesl.dart';
import 'package:nirbhaya_service/Utils/custom_bottom_nav.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/contoller/permission_controller.dart';
import 'package:nirbhaya_service/contoller/service_complete_request_controller.dart';
import 'package:nirbhaya_service/contoller/service_start_ride_controller.dart';
import 'package:nirbhaya_service/utils_screens/exit_dialog.dart';
import 'package:nirbhaya_service/widgets/request_status.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/Utils/preference.dart';
import 'package:nirbhaya_service/contoller/user_service_list_controller.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';
import 'package:get/get.dart';
import '../widgets/MyTextWithIcon.dart';
import '../widgets/button.dart';

class TrackingMap extends StatefulWidget {
  final ServiceListData? serviceListData;
  final StartRideModesl? socketToken;
  const TrackingMap({Key? key, this.serviceListData,this.socketToken}) : super(key: key);

  @override
  State<TrackingMap> createState() => _TrackingMapState();
}

class _TrackingMapState extends State<TrackingMap> {
  final Completer<GoogleMapController> _completer = Completer();
  final userServiceListController = Get.put(UserServiceListController());
  final permissionController = Get.put(PermissionController());
  final serviceCompleteController = Get.put(ServiceCompleteRequestController());

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor endSourceIcon = BitmapDescriptor.defaultMarker;
  List<LatLng> polylineCoordinates = [];
  List<LatLng> livePolylineCoordinates = [];
  Map<PolylineId, Polyline> polyLines = <PolylineId, Polyline>{};
  int polyLineIdCounter = 1;
  Timer? timer;
  late IO.Socket socket;
  LatLng? source;
  LatLng? destination;
  late Location location;
  LocationData? currentLocation;
  Set<Marker> markers = {};

  @override
  void initState() {
    setState(() {
      double userLat = double.parse(widget.serviceListData!.userlat.toString());
      double userLng = double.parse(widget.serviceListData!.userlng.toString());
      destination = LatLng(userLat, userLng);
      socketApi();
      liveLocation();
      setCustomMarkerIcon();

    });
    super.initState();
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/source_pin.png',
    ).then((icon) {
      sourceIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, 'assets/source_pin.png')
        .then((icon) {
      endSourceIcon = icon;
    });
  }

  void socketApi() async {
    await permissionController.permissionLocation();
    await socketConnect(widget.socketToken!.sockettoken.toString());
  }


  void liveLocation() async {
    location = Location();
    location.enableBackgroundMode(enable: true);
    location.changeNotificationOptions(
        channelName: 'Service App', title: 'Service app is running');
    location.onLocationChanged.listen((LocationData cLoc) async {
      currentLocation = cLoc;
      source = LatLng(cLoc.latitude!, cLoc.longitude!);
      addMarker();
      setState(() {});
      // debugPrint('source');
      // debugPrint(source.toString());
      final GoogleMapController controller = await _completer.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(cLoc.latitude!, cLoc.longitude!), zoom: 19)));
      await Preferences.setPreferences();
      var socketEmit = {
        "message": {
          'lat': currentLocation!.latitude!,
          'lng': currentLocation!.longitude!,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'altitude': currentLocation!.altitude,
          'speed': currentLocation!.speed.toString(),
          'speedAccuracy': currentLocation!.speedAccuracy.toString(),
          'elapsedRealtimeNanos':
              currentLocation!.elapsedRealtimeNanos.toString(),
          'elapsedRealtimeUncertaintyNanos':
              currentLocation!.elapsedRealtimeUncertaintyNanos.toString(),
          'accuracy': currentLocation!.accuracy.toString(),
          'heading': currentLocation!.heading.toString(),
          'headingAccuracy': currentLocation!.headingAccuracy.toString(),
          'provider': currentLocation!.provider.toString(),
          'satelliteNumber': currentLocation!.satelliteNumber
              .toString(), //satellite no 0 check it
          'verticalAccuracy': currentLocation!.verticalAccuracy.toString(),
          'h_dop': currentLocation!.accuracy! / 5,
          'v_dop':
              currentLocation!.accuracy! / currentLocation!.verticalAccuracy!,
          'time': currentLocation!.time.toString()
        },
        "roomName": widget.socketToken!.data.toString(),
      };
      socket.emit("message", socketEmit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Stack(
                children: [
                  _getMap(),
                  Positioned(
                    width: 55,
                    height: 55,
                    top: 10,
                    left: 10,
                    child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset('assets/rounded_back.png')),
                  ),
                  Positioned(
                    width: 55,
                    height: 55,
                    top: 10,
                    right: 10,
                    child: InkWell(
                        onTap: () {
                          CustomLoader.showLoader('Please wait...');
                        },
                        child:
                            Image.asset('assets/go_to_current_location.png')),
                  ),
                  // _getCustomPin(),
                ],
              )),
          Expanded(
              flex: 0,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: _showDraggedAddress(),
                  ),
                ],
              ))
        ],
      )),
    );
  }

  Widget _showDraggedAddress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                  text: widget.serviceListData!.username == ""
                      ? "N/A"
                      : widget.serviceListData!.username.toString(),
                  fontName: 'Gilroy',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  textColor: Colors.black),
              MyText(
                  text: widget.serviceListData!.date == ""
                      ? "N/A"
                      : widget.serviceListData!.date.toString(),
                  fontName: 'Gilroy',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  textColor: Colors.black),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                  text: widget.serviceListData!.usermobilenumber == ""
                      ? "N/A"
                      : widget.serviceListData!.usermobilenumber.toString(),
                  fontName: 'Gilroy',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  textColor: Colors.black),
              RequestStatus(
                  color: widget.serviceListData!.serviceStatus == "Pending"
                      ? pendingColor
                      : widget.serviceListData!.serviceStatus == "Reject"
                          ? rejectColor
                          : widget.serviceListData!.serviceStatus == "Accept"
                              ? acceptColor
                              : acceptColor,
                  statusText: widget.serviceListData!.serviceStatus.toString()),
            ],
          ),
        ),
        10.height,
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: MyText(
              text:
                  'Comment: ${widget.serviceListData!.comments == "" ? "N/A" : widget.serviceListData!.comments.toString()}',
              fontName: 'Gilroy',
              fontSize: 14,
              maxLine: 2,
              fontWeight: FontWeight.w500,
              textColor: appBlack),
        ),
        15.height,
        MyButton(press: (){
          exitShowDialog(context, 'Confirmation', 'No', 'Yes', 'Are you sure you want to complete?', () { Get.back(); }, () { serviceCompleteApi();});
        }, buttonText: 'Completed'),
      ],
    );
  }

  Widget _getMap() {
    return currentLocation == null
        ? const Center(
            child: MyText(
                text: 'Please Wait\nMap is loading',
                fontName: 'Gilroy',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                textColor: appBlack))
        : GoogleMap(
            initialCameraPosition: CameraPosition(
              target: source!,
              zoom: 14.0,
            ),
            markers: markers,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            polylines: Set<Polyline>.of(polyLines.values),
            onMapCreated: (GoogleMapController controller) {
              _completer.complete(controller);
              controller.setMapStyle(permissionController.mapStyle);
            },
          );
  }

  Future<void> addMarker() async {
    markers.add(Marker(
        anchor: const Offset(0.5, 0.5),
        markerId: const MarkerId('source'),
        position: source!,
        icon: sourceIcon));
    markers.add(Marker(
        anchor: const Offset(0.5, 0.5),
        markerId: const MarkerId('destination'),
        position: destination!,
        icon: endSourceIcon));
    polyLinesDraw();
  }

  polyLinesDraw() async {
    await _getRoutePolyline(
      start: source!,
      finish: destination!,
      color: appBlack,
      id: 'ServicePolyline',
      width: 4,
    );
    setState(() {});
  }

  Future<Polyline> _getRoutePolyline(
      {required LatLng start,
      required LatLng finish,
      required Color color,
      required String id,
      int width = 6}) async {
    final polylinePoints = PolylinePoints();
    final List<LatLng> polylineCoordinates = [];
    final startPoint = PointLatLng(start.latitude, start.longitude);
    final finishPoint = PointLatLng(finish.latitude, finish.longitude);
    final result = await polylinePoints.getRouteBetweenCoordinates(
      APIConstant.googleMapGetDirection,
      travelMode: TravelMode.driving,
      startPoint,
      finishPoint,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
    }
    final Polyline polyline = Polyline(
        polylineId: PolylineId(id),
        consumeTapEvents: true,
        points: polylineCoordinates,
        color: appBlack,
        width: 4);
    setState(() {
      polyLines[PolylineId(id)] = polyline;
    });
    return polyline;
  }

  void serviceCompleteApi()async{
    CompleteServiceRequestBody requestBody =CompleteServiceRequestBody(
      serviceId: widget.serviceListData!.id.toString(),
      userId: Preferences.getUserId().toString()
    );
    await serviceCompleteController.completeServiceApi(requestBody).then((value){
      if(value!=null){
        if(value.status==true){
          CustomLoader.message(value.message.toString());
          Get.to(const CustomBottomNav());
        }else{
          CustomLoader.message(value.message.toString());
        }
      }
    });
  }

  Future<void> socketConnect(String token) async {
    try {
      socket = IO.io(APIConstant.socketUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'extraHeaders': {'authorization': token.toString()}
      });
      socket.connect();
      // Subscribe to events
      socket.on('connect', (_) {
        debugPrint('Connected to the server');
      });
      socket.on('disconnect', (_) {
        debugPrint('Disconnected from the server');
      });
      socket.on('event', (data) {
        debugPrint('Received event: $data');
      });
      socket.on('error', (error) {
        debugPrint('Error: $error');
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
