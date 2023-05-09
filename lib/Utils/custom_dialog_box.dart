

import 'package:flutter/material.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';

class CustomDialogBox {
static Future<void> customDialog(BuildContext context,String title,String description) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Container(
        height: 100,
        child: AlertDialog(
          title: const MyText(text: 'Notification', fontName: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w500, textColor: appBlack),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(text: title, fontName: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w500, textColor: appBlack),
              MyText(text: description, fontName: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w500, textColor: appBlack),
            ],
          ),
        ),
      );
    },
  );
}
}