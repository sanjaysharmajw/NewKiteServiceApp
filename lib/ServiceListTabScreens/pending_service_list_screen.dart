import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nirbhaya_service/BodyRequest/accept_reject_body_request.dart';
import 'package:nirbhaya_service/Utils/preference.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/contoller/service_accept_reject_controller.dart';
import 'package:nirbhaya_service/contoller/service_list_controller.dart';
import 'package:nirbhaya_service/utils_screens/exit_dialog.dart';
import '../ListItems/service_registration_items.dart';
import '../Utils/loader.dart';
import '../display_items/service_requet_items.dart';
import '../utils_screens/empty_screen.dart';
import '../widgets/MyText.dart';
import '../widgets/custom_app_bar.dart';

class PendingServiceListScreen extends StatefulWidget {
  String? status;
  PendingServiceListScreen({Key? key, this.status}) : super(key: key);

  @override
  State<PendingServiceListScreen> createState() =>
      PendingServiceListScreenState();
}

class PendingServiceListScreenState extends State<PendingServiceListScreen> {
  final serviceListController = Get.put(ServiceListController());
  @override
  void initState() {
    super.initState();
    if (widget.status != null) {
      serviceApi(widget.status);
    }
  }

  void serviceApi(String? status) async {
    await serviceListController.getServiceList(status.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appWhiteColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                return Center(
                  child: serviceListController.isLoading.value
                      ? CustomLoader.loader()
                      : serviceListController.getServiceData.isEmpty
                          ? const Center(
                              child: EmptyScreen(text: 'Service Not Found'),
                            )
                          : RefreshIndicator(
                            onRefresh:  _refresh,
                            child: ListView.builder(
                                itemCount:
                                    serviceListController.getServiceData.length,
                                itemBuilder: (context, index) {
                                  return ServiceRequestItems(
                                    serviceListData: serviceListController
                                        .getServiceData[index],
                                    rejectClick: () {
                                      dialog(index, "Reject");
                                    },
                                    acceptClick: () {
                                      dialog(index, "Accept");
                                    },
                                  );
                                }),
                          ),
                );
              }),
            )
          ],
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

  Future<void> _refresh(){

    if (widget.status != null) {
      serviceApi(widget.status);
    }
    return Future.delayed(Duration(seconds: 2));

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
          if (widget.status != null) {
            serviceApi(widget.status);
          }
          Get.back();
        } else {
          CustomLoader.message(value.message.toString());
        }
      }
    });
  }
}
