

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/BodyRequest/volunteer_status_request_body.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/contoller/request_volunteer_controller_.dart';
import 'package:nirbhaya_service/utils_screens/empty_screen.dart';
import 'package:nirbhaya_service/utils_screens/exit_dialog.dart';
import 'package:nirbhaya_service/volunteer_screen/volunteer_request_items.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';

class VolunteerAcceptScreen extends StatefulWidget {
  String? status;
  VolunteerAcceptScreen({Key? key,this.status}) : super(key: key);

  @override
  State<VolunteerAcceptScreen> createState() => _VolunteerAcceptScreenState();
}

class _VolunteerAcceptScreenState extends State<VolunteerAcceptScreen> {
  final volunteerRequestController=Get.put(RequestVolunteerController());

  @override
  void initState() {
    api();
   // updateVolunteerStatusApi(volunteerRequestController.getRequestVolunteerData[0].id.toString(), widget.status.toString());
    super.initState();
  }

  void api()async{
    await volunteerRequestController.requestVolunteerApi(widget.status.toString());
  }
  void updateVolunteerStatusApi(String id,String status)async{
    VolunteerStatusRequestBody requestBody=VolunteerStatusRequestBody(
        id: id,
        status: status
    );
    await volunteerRequestController.volunteerStatusUpdate(requestBody).then((value){
      if(value!=null){
        if(value.status==true){
          CustomLoader.message(value.message.toString());
          api();
          Get.back();
        }
      }
    });
  }

  Future<void> _refresh(){
    api();
    return Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        backgroundColor: Colors.white,body: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Obx(() {
              return Center(
                child: volunteerRequestController.isLoading.value
                    ? CustomLoader.loader()
                    : volunteerRequestController.getRequestVolunteerData.isEmpty
                    ? const Center(
                  child: EmptyScreen(text: 'Reques Not Found'),
                )
                    : RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView.builder(
                      itemCount: volunteerRequestController
                          .getRequestVolunteerData.length,
                      itemBuilder: (context, index) {
                        return VolunteerRequestItems(volunteerData: volunteerRequestController.getRequestVolunteerData[index], readyClick: () {
                          confirmationDialog(index,"Accept","Ready to go");
                        }, notReadyClick: () {
                          confirmationDialog(index,"Reject","Not ready to go");
                        },);
                      }),
                    ),
              );
            }),
          )

        ],
      ),
    )));
  }
  void confirmationDialog(int index, String status,String confirmation){
    exitShowDialog(context, 'Confirmation', 'No', 'Yes', 'Are you sure you want to $confirmation?', () {
  Get.back();
    }, () {
      updateVolunteerStatusApi(volunteerRequestController.getRequestVolunteerData[index].id.toString(),status);
    });
  }
}
