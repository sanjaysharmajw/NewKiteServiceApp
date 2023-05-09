import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nirbhaya_service/BodyRequest/accept_reject_body_request.dart';
import 'package:nirbhaya_service/Models/service_list_model.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/Utils/preference.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/contoller/service_accept_reject_controller.dart';
import 'package:nirbhaya_service/select_address/SelectAddressMap.dart';
import 'package:nirbhaya_service/utils_screens/exit_dialog.dart';
import 'package:nirbhaya_service/widgets/images_set.dart';

class ServiceListItems extends StatelessWidget {
  final UserServiceListData userServiceListData;
  final VoidCallback itemClick;
  const ServiceListItems(
      {Key? key, required this.userServiceListData, required this.itemClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: itemClick,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: appBlack),
          color: appWhiteColor,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          userServiceListData.title == ""
                              ? "N/A"
                              : userServiceListData.title.toString(),
                          style: const TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 18,
                              color: appBlack,
                              fontWeight: FontWeight.w700)),
                      Text(
                          userServiceListData.contactPerson == ""
                              ? "N/A"
                              : 'Mob: ${userServiceListData.contactPerson.toString()}',
                          style: const TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 14,
                              color: appBlack)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                      userServiceListData.serviceName == ""
                          ? "N/A"
                          : userServiceListData.serviceName.toString(),
                      style: const TextStyle(
                          fontFamily: 'Gilroy', fontSize: 14, color: appBlack)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: ClipOval(
                          child: Material(
                            color: appLightBlue, // button color
                            child: InkWell(
                              splashColor: appBlue,
                              highlightColor:
                                  theme.colorScheme.primary.withAlpha(28),
                              child: const SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Icon(
                                    MdiIcons.pencil,
                                    color: appBlue,
                                    size: 15,
                                  )),
                              onTap: () {
                                Preferences.setServiceListId(
                                    userServiceListData.id.toString());
                                Preferences.setServiceId(userServiceListData
                                    .serviceId
                                    .toString());
                                Get.to(SelectAddressMap(action: "Edit"));
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
