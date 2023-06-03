import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nirbhaya_service/Models/service_list_master_models.dart';
import 'package:nirbhaya_service/Screens/service_registraion_form.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';
import 'package:get/get.dart';

class ServiceMasterListItems extends StatelessWidget {

  final ServiceTypeListMasterData serviceTypeListMasterData;
  final Placemark placemark;
  final LatLng currentLatLng;
  final String action;
  final Color borderColor;
  const ServiceMasterListItems({Key? key, required this.serviceTypeListMasterData, required this.placemark, required this.currentLatLng, required this.action, required this.borderColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(ServiceRegistrationForm(serviceId: serviceTypeListMasterData.id.toString(), serviceName:serviceTypeListMasterData.name.toString(),
            placemark: placemark, latLng: currentLatLng,action: action));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          color: appWhiteColor,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        padding: const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: MyText(text: serviceTypeListMasterData.name.toString(), fontName: 'Gilroy',
                  fontSize: 12, fontWeight: FontWeight.w700, textColor: Colors.black,),
            ),
            Image.asset('images/forword_arrow.png',width: 15, height: 15, fit: BoxFit.contain, color: appBlack)
          ],
        ),
      ),
    );
  }
}
