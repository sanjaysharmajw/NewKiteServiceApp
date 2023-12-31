import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nirbhaya_service/BodyRequest/accept_reject_body_request.dart';
import 'package:nirbhaya_service/BodyRequest/notification_request_body.dart';
import 'package:badges/badges.dart' as badges;
import 'package:nirbhaya_service/BodyRequest/service_list_body_request.dart';
import 'package:nirbhaya_service/BodyRequest/service_list_request_body.dart';
import 'package:nirbhaya_service/Screens/notification_screen.dart';
import 'package:nirbhaya_service/Utils/preference.dart';
import 'package:nirbhaya_service/Utils/tools.dart';
import 'package:nirbhaya_service/chat_module/chat_controller/chat_token_controller.dart';
import 'package:nirbhaya_service/chat_module/chat_screen.dart';
import 'package:nirbhaya_service/chat_module/models/get_token_request_body.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/contoller/notification_controller.dart';
import 'package:nirbhaya_service/contoller/permission_controller.dart';
import 'package:nirbhaya_service/contoller/service_accept_reject_controller.dart';
import 'package:nirbhaya_service/contoller/service_list_controller.dart';
import 'package:nirbhaya_service/contoller/user_details_controller.dart';
import 'package:nirbhaya_service/contoller/user_service_list_controller.dart';
import 'package:nirbhaya_service/utils_screens/exit_dialog.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';
import '../ListItems/home_page_items.dart';
import '../Utils/loader.dart';
import '../display_items/service_requet_items.dart';
import '../utils_screens/empty_screen.dart';
import '../widgets/images_set.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final serviceListController = Get.put(ServiceListController());
  final permissionController = Get.put(PermissionController());
  final notificationController = Get.put(NotificationController());
  final userDetailsController = Get.put(UserDetailsController());
  final userServiceListController = Get.put(UserServiceListController());
  String? allRequest = "wait...",
      pendingRequest = "wait...",
      acceptedRequest = "wait...",
      rejectedRequest = "wait...",
      notificationCount = "0";

  @override
  void initState() {
    firebaseTokenMethod();
    super.initState();
    serviceApi();
    userDetailsApi();
    listApi();
    setState(() {});
  }

  void firebaseTokenMethod() async {
    FirebaseMessaging.instance.requestPermission();
    String? firebaseToken = await FirebaseMessaging.instance.getToken();
    debugPrint("firebaseOTPVerify:....   $firebaseToken   ........");
    debugPrint("firebaseOTPVerifyIOS:....   $firebaseToken   ........");
    debugPrint("loginId:....   ${Preferences.getUserId()}   ........");
    setState(() {});
  }

  void userDetailsApi() async {
    await userDetailsController.updateProfile();
  }

  void serviceApi() async {
    await permissionController.permissionLocation();
    ServiceListBodyRequest request = ServiceListBodyRequest(
      userId: Preferences.getUserId().toString(),
      lat: permissionController.locationData?.latitude,
      lng: permissionController.locationData?.longitude,
      // id: userServiceListController.getUserServiceListData[0].id,
      //  serviceId: userServiceListController.getUserServiceListData[0].serviceId
    );
    await userServiceListController.getUserServiceList(request);
    NotificationRequestBody notificationModels = NotificationRequestBody(
        count: true, unread: true, userId: Preferences.getUserId().toString());
    await notificationController
        .notificationApi(notificationModels)
        .then((value) {
      if (value != null) {
        allRequest = value.count?.allRequest.toString();
        pendingRequest = value.count?.pendingRequest.toString();
        acceptedRequest = value.count?.acceptedRequest.toString();
        rejectedRequest = value.count?.rejectedRequest.toString();
        notificationCount = value.data!.toString();
        setState(() {});
      }
    });
  }

  void listApi() async {
    ServiceListRequestBody requestBody = ServiceListRequestBody(
      serviceProviderId: Preferences.getUserId().toString(),
      status: '',
      lng: permissionController.locationData!.longitude,
      lat: permissionController.locationData!.latitude,
    );
    await serviceListController.getServiceList(requestBody);
    setState(() {});
  }

  Future<void> _refresh() {
    return Future.delayed(const Duration(seconds: 2)).then((value) {
      listApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    Tools.setStatusBarColor(appBlue);
    WidgetsFlutterBinding.ensureInitialized();
    return SafeArea(
      child: Scaffold(
        backgroundColor: appWhiteColor,
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: appBlue,
                          height: 70,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20, left: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const MyText(
                                    text: "TS Service",
                                    fontName: 'Gilroy',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    textColor: appWhiteColor),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        chatTokenApi();
                                      },
                                      child: const ImageSets(
                                          imagePath: 'assets/chat_icon.png',
                                          width: 25,
                                          height: 25,
                                          color: appWhiteColor),
                                    ),
                                    const SizedBox(width: 15),
                                    InkWell(
                                      onTap: () {
                                        Get.to(const NotificationScreen());
                                      },
                                      child: badges.Badge(
                                        position: badges.BadgePosition.topEnd(
                                            top: -10, end: -12),
                                        badgeContent: MyText(
                                            text: notificationCount!.toString(),
                                            fontName: 'Gilroy',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            textColor: appWhiteColor),
                                        child: const ImageSets(
                                            imagePath: 'assets/ring_bell.png',
                                            width: 25,
                                            height: 25,
                                            color: appWhiteColor),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                        GridView.count(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            crossAxisCount: 2,
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10),
                            mainAxisSpacing: 20,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 20,
                            children: [
                              HomePageItems(
                                completed: 58,
                                backgroundColor: Colors.blue,
                                title: 'all'.tr,
                                subtitle: allRequest!,
                              ),
                              HomePageItems(
                                completed: 45,
                                backgroundColor: Colors.red,
                                title: 'pending'.tr,
                                subtitle: pendingRequest!,
                              ),
                              HomePageItems(
                                completed: 68,
                                backgroundColor: Colors.green,
                                title: 'accepted'.tr,
                                subtitle: acceptedRequest!,
                              ),
                              HomePageItems(
                                completed: 32,
                                backgroundColor: Colors.orange,
                                title: 'rejected'.tr,
                                subtitle: rejectedRequest!,
                              ),
                            ]),
                      ]),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
                    child: MyText(
                        text: 'service_request'.tr,
                        fontName: 'Gilroy',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: appBlack),
                  ),
                  Expanded(
                    child: Obx(() {
                      return Center(
                        child: serviceListController.isLoading.value
                            ? CustomLoader.loader()
                            : serviceListController.getServiceData.isEmpty
                                ? const Center(
                                    child:
                                        EmptyScreen(text: 'Service Not Found'),
                                  )
                                : ListView.builder(
                                    itemCount: serviceListController
                                        .getServiceData.length,
                                    itemBuilder: (context, index) {
                                      return ServiceRequestItems(
                                        serviceListData: serviceListController
                                            .getServiceData[index],
                                        acceptClick: () {
                                          dialog(index, "Accept");
                                        },
                                        rejectClick: () {
                                          dialog(index, "Reject");
                                        },
                                      );
                                    }),
                      );
                    }),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  void dialog(int index, String status) {
    exitShowDialog(context, 'Confirmation', 'No', 'Yes',
        'Are you sure you want to $status?', () {
      Get.back();
    }, () {
      acceptRejectApi(
          serviceListController.getServiceData[index].id.toString(), status);
    });
  }

  void acceptRejectApi(String id, String status) async {
    final controllerApi = Get.put(ServiceAcceptRejectController());
    AcceptRejectBodyRequest request = AcceptRejectBodyRequest(
        id: id.toString(),
        userId: Preferences.getUserId().toString(),
        status: status.toString());
    await controllerApi.acceptRejectApi(request).then((value) {
      if (value != null) {
        if (value.status == true) {
          CustomLoader.message(value.message.toString());
          serviceApi();
          Get.back();
        } else {
          CustomLoader.message(value.message.toString());
        }
      }
    });
  }

  void chatTokenApi() {
    final chatController = Get.put(ChatTokenController());
    GetTokenRequestBody requestBody = GetTokenRequestBody(
        userName: Preferences.getFirstName().toString(),
        userId: Preferences.getUserId().toString(),
        userRole: 'Service');
    chatController.chatTokenApi(requestBody).then((value) {
      if (value != null) {
        Get.to(RealtimeChatScreen(socketToken: value.token.toString()));
      }
    });
  }
}
