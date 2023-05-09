
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/ListItems/notification_list_items.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/contoller/notification_list_controller.dart';
import 'package:nirbhaya_service/utils_screens/empty_screen.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final notificationController = Get.put((NotificationListController()));
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: appWhiteColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            InkWell( onTap: (){
              Get.back();
            },child: Image.asset('assets/back_icons.png',width: 17,height: 17)),
            const SizedBox(height: 25),
            const MyText(text: 'Notification', fontName: 'Gilroy',
                fontSize: 20, fontWeight: FontWeight.w800, textColor: appBlack),
            const SizedBox(height: 25),
            Expanded(
              child: Obx(() {
                return Center(
                  child: notificationController.isLoading.value
                      ? CustomLoader.loader()
                      : notificationController.getNotificationListData.isEmpty
                      ? const Center(
                    child: EmptyScreen(text: 'Service Not Found'),
                  )
                      : ListView.builder(
                      itemCount: notificationController
                          .getNotificationListData.length,
                      itemBuilder: (context, index) {
                        return NotificationItems(notificationData:notificationController.getNotificationListData[index]);
                      }),
                );
              }),
            )
            //NotificationItems(notificationData: null,),
          ],
        ),
      ),
    ));
  }

}
