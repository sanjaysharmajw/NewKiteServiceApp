import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nirbhaya_service/BodyRequest/service_list_body_request.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/Utils/preference.dart';
import 'package:nirbhaya_service/contoller/service_list_master_controller.dart';
import 'package:nirbhaya_service/contoller/user_service_list_controller.dart';
import 'package:nirbhaya_service/items_screen/service_master_list_items.dart';
import 'package:nirbhaya_service/utils_screens/empty_screen.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';
import '../color_constant.dart';

class SelectServiceScreen extends StatefulWidget {
  Placemark placemark;
  LatLng latLng;
  String action;
   SelectServiceScreen({Key? key,required this.placemark,required this.latLng,required this.action}) : super(key: key);

  @override
  State<SelectServiceScreen> createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  final serviceMasterListController=Get.put((ServiceListMasterController()));
  final userServiceListController = Get.put(UserServiceListController());

  @override
  void initState() {
    super.initState();
    if(widget.action=="Edit"){
      serviceDetails();
    }
  }
  void serviceDetails()async{
    Preferences.setPreferences();
    String? serviceId=Preferences.getServiceId();
    String? id=Preferences.getServiceListId();
    ServiceListBodyRequest request = ServiceListBodyRequest(
        userId: Preferences.getUserId().toString(),
        lat: widget.latLng.latitude,
        lng: widget.latLng.longitude,
        serviceId: serviceId.toString(),
        id: id.toString()
    );
    await userServiceListController.getUserServiceList(request);
   // userServiceListController
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appWhiteColor,
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell( highlightColor: Colors.black38,onTap: (){
                Get.back();
              },child: Image.asset('assets/back_icons.png',width: 17,height: 17)),
              const SizedBox(height: 20),
               MyText(text: 'service_category'.tr, fontName: 'Gilroy',
                  fontSize: 20, fontWeight: FontWeight.w700, textColor: Colors.black),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  return serviceMasterListController.isLoading.value
                      ? CustomLoader.loader()
                      : serviceMasterListController.getServiceMasterListData.isEmpty
                      ? const Center(
                    child: EmptyScreen(text: 'Service Category not found'),
                  ) :
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: (3 / 1),
                    shrinkWrap: true,
                    children: List.generate(serviceMasterListController.getServiceMasterListData.length, (index) {
                      Color? selectedColor;
                      if(widget.action=="Edit"){
                        if (userServiceListController.getUserServiceListData[0].serviceName.toString().contains(serviceMasterListController.getServiceMasterListData[index].name.toString())) {
                          selectedColor = appBlue;
                        } else {
                          selectedColor = appLightGrey;
                        }
                      }else{
                        selectedColor = appLightGrey;
                      }
                      return ServiceMasterListItems(serviceTypeListMasterData: serviceMasterListController.getServiceMasterListData[index],
                          placemark: widget.placemark, currentLatLng: widget.latLng,action:widget.action,
                        borderColor: selectedColor);
                    }),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
