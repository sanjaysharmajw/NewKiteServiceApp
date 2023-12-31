

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/Models/get_volunteer_models.dart';
import 'package:nirbhaya_service/Utils/distance_calulator.dart';
import 'package:nirbhaya_service/contoller/permission_controller.dart';
import 'package:nirbhaya_service/volunteer_screen/request_widgets.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';

class VolunteerRequestItems extends StatelessWidget {
  final VolunteerData volunteerData;
  final VoidCallback readyClick;
  final VoidCallback notReadyClick;
  const VolunteerRequestItems({Key? key, required this.volunteerData, required this.readyClick, required this.notReadyClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationController=Get.put(PermissionController());

    //Distance Calculator
    double fromLat=double.parse(locationController.locationData!.latitude.toString());
    double fromLng=double.parse(locationController.locationData!.longitude.toString());
    double toLat=double.parse(volunteerData.lat.toString());
    double toLng=double.parse(volunteerData.lng.toString());
    double distanceValue=DistanceCalculator.calculateDistance(fromLat, fromLng, toLat, toLng);
    String distance = distanceValue.toStringAsFixed(2);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black,width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5))
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: MyText(text: volunteerData.userName==""?"":volunteerData.userName.toString(), fontName: 'Gilroy', fontSize: 16,
                        fontWeight: FontWeight.w700, textColor: Colors.black),
                  ),
                  MyText(text: volunteerData.status.toString(), fontName: 'Gilroy', fontSize: 14,
                      fontWeight: FontWeight.w700, textColor: volunteerData.status=="Accept"?Colors.green:Colors.red),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              MyText(text: 'Driver: ${volunteerData.driverName.toString()}, ${volunteerData.vehicleNumber.toString()}' == ""?"":'Driver: ${volunteerData.driverName.toString()}, ${volunteerData.vehicleNumber.toString()}',
                  fontName: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w500, textColor: Colors.black,maxLine: 2,),
              const SizedBox(
                height: 8,
              ),
              MyText(text: volunteerData.reason.toString(), fontName: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w500, textColor: Colors.black),
              const SizedBox(height: 8),
              MyText(text: '${volunteerData.distance.toString()} Km'==""?"":'$distance Km', fontName: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w500, textColor: Colors.black),
              const SizedBox(height: 15),
              Visibility(
                  visible: volunteerData.status=="Accept"?true:false,
                  child: RequestWidget(textValue: 'Go to map', onClick: readyClick, color: Colors.black)),
              Visibility(
                visible: volunteerData.status=="Accept"?false:volunteerData.status=="Reject"?false:true,
                child: Row(
                  children:  [
                    Flexible(
                        flex: 2,
                        child: RequestWidget(textValue: 'Ready to Go', onClick: readyClick, color: Colors.green)),
                   const  SizedBox(width: 10),
                    Flexible(
                        flex: 2,
                        child: RequestWidget(textValue: 'Not ready to go', onClick: notReadyClick, color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
