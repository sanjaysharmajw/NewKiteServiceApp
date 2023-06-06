import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:nirbhaya_service/BodyRequest/service_list_body_request.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/Utils/preference.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:nirbhaya_service/contoller/user_service_list_controller.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';
import 'package:get/get.dart';
import '../Screens/select_service_screen.dart';
import '../widgets/MyTextWithIcon.dart';
import '../widgets/button.dart';


class SelectAddressMap extends StatefulWidget {
  String action;
  SelectAddressMap({ Key? key,required this.action}) : super(key: key);

  @override
  State<SelectAddressMap> createState() => _HomePageState();
}

class _HomePageState extends State<SelectAddressMap> {

  Completer<GoogleMapController> _googleMapController = Completer();
  final userServiceListController = Get.put(UserServiceListController());
  CameraPosition? _cameraPosition;
  late LatLng _defaultLatLng;
  late LatLng _draggedLatlng;
  String _draggedAddress = "";
  late String mapStyle;
  Placemark? address;
  List<Placemark>? placemarks;


  @override
  void initState() {
    _gotoUserCurrentPosition();
    _init();
    rootBundle.loadString('assets/map_style.json').then((string) {
      mapStyle = string;
    });
    setState(() {

    });
    super.initState();
  }

  _init() {
    _defaultLatLng = const LatLng(0.0, 0.0);
    _draggedLatlng = _defaultLatLng;
    _cameraPosition = CameraPosition(
        target: _defaultLatLng,
        zoom: 15
    );

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
                            onTap: (){
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
                            onTap: (){
                              CustomLoader.showLoader('Please wait...');
                              _gotoUserCurrentPosition();
                            },
                            child:  Image.asset('assets/go_to_current_location.png')),
                      ),
                      _getCustomPin(),
                    ],
                  )),
              Expanded(
                  flex: 0,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration:  BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: _showDraggedAddress(),
                      ),
                    ],
                  ))

            ],
          )
      ),
    );
  }


  Widget _showDraggedAddress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding:  EdgeInsets.only(left: 30,right: 10,top: 15),
          child:  MyText(text: 'pick_address'.tr,
              fontName: 'Gilroy',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              textColor: Colors.black),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: MyTextWithIcons(textValue: _draggedAddress,
              fontSized: 16,
              fontName: 'Gilroy',
              fontWeight: FontWeight.w500,
              imageWidth: 25,
              imageHeight: 25),
        ),
        MyButton(press: (){
          Get.to(SelectServiceScreen(placemark:  address = placemarks![0], latLng: _draggedLatlng,action: widget.action));
        }, buttonText: 'next'.tr),
      ],
    );
  }

  Widget _getMap() {
    return GoogleMap(
      initialCameraPosition: _cameraPosition!, //initialize camera position for map
      zoomControlsEnabled: false,
      zoomGesturesEnabled: true,
      onCameraIdle: () {
        _getAddress(_draggedLatlng);
      },
      onCameraMove: (cameraPosition) {
        _draggedLatlng = cameraPosition.target;
      },
      onMapCreated: (GoogleMapController controller) {
        if (!_googleMapController.isCompleted) {
          _googleMapController.complete(controller);
          controller.setMapStyle(mapStyle);
        }
      },
    );
  }

  Widget _getCustomPin() {
    return Center(
      child: SizedBox(
        width: 150,
        child: Lottie.asset("assets/pin.json",width: 100,height: 100),
      ),
    );
  }

  //get address from dragged pin
  Future _getAddress(LatLng position) async {
    placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    address = placemarks![0];
    String addresStr = "${address!.street},${address!.locality},${address!.administrativeArea}, ${address!.country}";
    setState(() {
      _draggedAddress = addresStr;
    });
  }

  Future _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    _gotoSpecificPosition(LatLng(currentPosition.latitude, currentPosition.longitude));
    CustomLoader.closeLoader();
  }
  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: position,
            zoom: 15
        )
    ));
    await _getAddress(position);
  }

  Future _determineUserCurrentPosition() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!isLocationServiceEnabled) {
      print("user don't enable location permission");
    }

    locationPermission = await Geolocator.checkPermission();
    if(locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if(locationPermission == LocationPermission.denied) {
        print("user denied location permission");
      }
    }
    if(locationPermission == LocationPermission.deniedForever) {
      print("user denied permission forever");
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

}
