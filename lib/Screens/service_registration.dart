import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nirbhaya_service/BodyRequest/service_list_body_request.dart';
import 'package:nirbhaya_service/Utils/preference.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/contoller/permission_controller.dart';
import 'package:nirbhaya_service/contoller/user_service_list_controller.dart';
import 'package:nirbhaya_service/select_address/SelectAddressMap.dart';
import '../ListItems/service_registration_items.dart';
import '../Utils/loader.dart';
import '../utils_screens/empty_screen.dart';
import '../widgets/MyText.dart';
import '../widgets/add_button.dart';
import '../widgets/custom_app_bar.dart';

class ServiceRegistrationUI extends StatefulWidget {
  const ServiceRegistrationUI({Key? key}) : super(key: key);

  @override
  State<ServiceRegistrationUI> createState() => _ServiceRegistrationState();
}

class _ServiceRegistrationState extends State<ServiceRegistrationUI> {
  final userServiceListController = Get.put(UserServiceListController());
  final permissionController = Get.put(PermissionController());


  @override
  void initState() {
    super.initState();
    ServiceListBodyRequest request =ServiceListBodyRequest(
      userId: Preferences.getUserId().toString(),
      lat: permissionController.locationData!.latitude,
      lng: permissionController.locationData!.longitude,
    );
    userServiceListController.getUserServiceList(request);

  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      backgroundColor: appWhiteColor,
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipPath(
          clipper: AppBarCustomClipper(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // InkWell(
                      //     onTap: (){
                      //       Get.back();
                      //     },
                      //     child: Image.asset('assets/back_icons.png',width: 17,height: 17)),
                      MyText(text: 'register'.tr, fontName: 'Gilroy',
                          fontSize: 20, fontWeight: FontWeight.w800, textColor: appBlack),
                       AddButton(click: () {
                         Get.to(SelectAddressMap(action: 'Add'),transition: Transition.rightToLeft,
                           duration: const Duration(milliseconds: 400),
                           curve: Curves.fastOutSlowIn);
                         }, text: 'new'.tr,),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return userServiceListController.isLoading.value
                  ? CustomLoader.loader()
                  : userServiceListController.getUserServiceListData.isEmpty
                  ? const Center(
                child: EmptyScreen(text: 'Service Not Found'),
              ) : ListView.builder(
                  itemCount: userServiceListController.getUserServiceListData.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
                              child: ServiceListItems(userServiceListData: userServiceListController.getUserServiceListData[index], itemClick: () {

                              }),
                            );
                  });
            }),
          )
        ],
      ),

    ));
  }
}
