import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nirbhaya_service/BodyRequest/accept_reject_body_request.dart';
import 'package:nirbhaya_service/BodyRequest/start_ride_request.dart';
import 'package:nirbhaya_service/Models/start_ride_modesl.dart';
import 'package:nirbhaya_service/Screens/tracking_map.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/Utils/preference.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/contoller/permission_controller.dart';
import 'package:nirbhaya_service/contoller/service_accept_reject_controller.dart';
import 'package:nirbhaya_service/contoller/service_start_ride_controller.dart';
import 'package:nirbhaya_service/utils_screens/exit_dialog.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';
import 'package:nirbhaya_service/widgets/rating_bar_widget.dart';
import 'package:nirbhaya_service/widgets/request_status.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/service_list_models.dart';
import '../contoller/google_map_navigation.dart';

class ServiceRequestItems extends StatelessWidget {
  final ServiceListData serviceListData;
  final VoidCallback  acceptClick;
  final VoidCallback  rejectClick;

  const ServiceRequestItems({Key? key, required this.serviceListData, required this.acceptClick, required this.rejectClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: appLightGrey),
        color: appWhiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                  text: serviceListData.date.toString(),
                  fontName: 'Gilroy',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textColor: appBlack),
              RequestStatus(
                  color: serviceListData.serviceStatus == "Pending"
                      ? pendingColor
                      : serviceListData.serviceStatus == "Reject"
                          ? rejectColor
                          : serviceListData.serviceStatus == "Accept"
                              ? acceptColor
                              : acceptColor,
                  statusText: serviceListData.serviceStatus.toString()),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                        serviceListData.providername == ""
                        ? ""
                        : serviceListData.providername.toString(),
                    style: const TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        color: appBlack,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 5),
              MyText(
                  text: serviceListData.usermobilenumber == null ? "" : serviceListData.usermobilenumber.toString(),
                  fontName: 'Gilroy',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textColor: appBlack),
            ],
          ),
          10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: MyText(
                    text: 'Comment: ${serviceListData.comments == ""
                        ? "N/A"
                        : serviceListData.comments.toString()}',
                    fontName: 'Gilroy',
                    fontSize: 14,
                    maxLine: 2,
                    fontWeight: FontWeight.w500,
                    textColor: appBlack),
              ),
             Row(
               children: [
                 Visibility(
                   visible: serviceListData.serviceStatus == "Accept" ? true : serviceListData.serviceStatus == "Reject"?false: serviceListData.serviceStatus == "Completed" ? false : false,
                   child: Container(
                     margin: const EdgeInsets.only(right: 10),
                     child: ClipOval(
                       child: Material(
                         color: appLightBlue, // button color
                         child: InkWell(
                           splashColor: appBlue,
                           highlightColor: theme.colorScheme.error.withAlpha(28),
                           child: const SizedBox(
                               width: 40,
                               height: 40,
                               child: Icon(
                                 MdiIcons.navigation,
                                 color: appBlue,
                               )),
                           onTap: () async {
                             // GoogleMapNavigation.openMap(
                             //     serviceListData.userlat.toString(),
                             //     serviceListData.userlng.toString());
                             serviceStartRide(serviceListData);

                           },
                         ),
                       ),
                     ),
                   ),
                 ),
                 Visibility(
                   visible: serviceListData.serviceStatus == "Accept"
                       ? false
                       : serviceListData.serviceStatus == "Reject"
                       ? false:serviceListData.serviceStatus == "Completed"?false
                       : true,
                   child: Row(
                     children: [
                       ClipOval(
                         child: Material(
                           color: theme.colorScheme.error
                               .withAlpha(28), // button color
                           child: InkWell(
                             splashColor: theme.colorScheme.error.withAlpha(100),
                             highlightColor: theme.colorScheme.error.withAlpha(28),
                             onTap: rejectClick,
                             child: SizedBox(
                                 width: 40,
                                 height: 40,
                                 child: Icon(
                                   MdiIcons.close,
                                   color: theme.colorScheme.error,
                                 )),
                           ),
                         ),
                       ),
                       Container(
                         margin: const EdgeInsets.only(left: 10),
                         child: ClipOval(
                           child: Material(
                             color: appLightBlue, // button color
                             child: InkWell(
                               splashColor: appBlue,
                               highlightColor:
                               theme.colorScheme.primary.withAlpha(28),
                               onTap: acceptClick,
                               child: const SizedBox(
                                   width: 40,
                                   height: 40,
                                   child: Icon(
                                     MdiIcons.check,
                                     color: appBlue,
                                   )),
                             ),
                           ),
                         ),
                       ),
                     ],
                   ),
                 )
               ],
             ),
            ],
          ),
          10.height,
          Visibility(
            visible: serviceListData.rating==""?false:true,
              child: RatingBarWidgets(ratingRate: serviceListData.rating.toDouble())),
        ],
      ),
    );
  }

  void serviceStartRide(ServiceListData serviceListData)async {
    final serviceStartRideController = Get.put(ServiceStartRideController());
    final permissionController = Get.put(PermissionController());
    StartRideRequest startRideRequest = StartRideRequest(
      userId: Preferences.getUserId().toString(),
      driverId: Preferences.getUserId().toString(),
      serviceId: serviceListData.id.toString(),
      startPoint: StartPoint(
        latitude: permissionController.locationData!.latitude!,
        longitude: permissionController.locationData!.longitude!,
      ),
      endPoint: EndPoint(
          latitude: serviceListData.userlat,
          longitude: serviceListData.userlng
      ),
      date: DateTime
          .now()
          .millisecondsSinceEpoch
          .toString(),
    );
    serviceStartRideController.serviceStartRideApi(startRideRequest).then((
        value) {
      if (value != null) {
        if (value.status == true) {
          Get.to(TrackingMap(serviceListData: serviceListData, socketToken: value));
          CustomLoader.message(value.message.toString());
        } else {
          CustomLoader.message(value.message.toString());
        }
      }
    });
  }

}
