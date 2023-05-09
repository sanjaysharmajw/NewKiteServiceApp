

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nirbhaya_service/Models/notification_model_list.dart';
import 'package:nirbhaya_service/Models/notification_models.dart';
import 'package:nirbhaya_service/Utils/custom_dialog_box.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';
import 'package:nirbhaya_service/widgets/images_set.dart';

class NotificationItems extends StatelessWidget {
  final NotificationData notificationData;
  const NotificationItems({Key? key, required this.notificationData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        customDialog(context, notificationData.title.toString(), notificationData.description.toString());
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: appLightGrey),
          color: appWhiteColor,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child:  Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  MyText(text: notificationData.title.toString(), fontName: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w700, textColor: appBlack),
                  MyText(text: notificationData.date.toString(), fontName: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w500, textColor: appBlack),
                ],
              ),
              10.height,
              MyText(text: notificationData.description.toString(), fontName: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w500, textColor: appBlack),

            ],
          ),
        ),
      ),
    );
  }

  static Future<void> customDialog(BuildContext context,String title,String description) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(text: title, fontName: 'Gilroy', fontSize: 16, fontWeight: FontWeight.w700, textColor: appBlack),
                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                        child: const ImageSets(imagePath: 'images/close_icons.png', width: 20, height: 20, color: appBlack))
                  ],
                ),
                30.height,
                Text(description,style: const TextStyle(
                  fontFamily: 'Gilroy',fontSize: 14,fontWeight: FontWeight.w500,color: appBlack
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
