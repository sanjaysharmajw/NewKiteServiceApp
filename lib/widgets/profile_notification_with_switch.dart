

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_switch/flutter_switch.dart';


import '../color_constant.dart';
import 'MyText.dart';


class ProfileNotification extends StatelessWidget {
  final bool status4;
  final String  title;
  final String  subTitle;
  final ValueChanged valueChanged;
  final String imageAssets;
  const ProfileNotification({Key? key, required this.valueChanged, required this.status4, required this.title, required this.subTitle, required this.imageAssets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(imageAssets,width: 25,height: 25,color: appBlack),
                  //const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,top: 4,right: 70),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(text: title, fontName: 'Gilroy', fontWeight: FontWeight.w600, textColor: appBlack, fontSize: 14),
                        const SizedBox(height: 10),
                        MyText(text: subTitle, fontName: 'Gilroy', fontWeight: FontWeight.w500, textColor: appBlack, fontSize: 10),

                      ],
                    ),
                  ),
                ],
              ),
            ),
           /* Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(imageAssets,width: 25,height: 25,color: appBlack),
                const SizedBox(
                  height: 10,width: 30,
                ),
                Column(

                  children: [
                    MyText(text: title, fontName: 'Gilroy', textColor: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                    const SizedBox(height: 5),
                    MyText(text: subTitle, fontName: 'Gilroy', textColor: Colors.black54, fontSize: 12, fontWeight: FontWeight.normal),
                  ],
                ),
              ],
            ),*/
            Padding(
              padding: const EdgeInsets.only(left: 70),
              child: FlutterSwitch(
                width: 50.0,
                height: 25.0,
                valueFontSize: 12.0,
                toggleSize: 20.0,
                value: status4,
                activeColor: appBlue,
                inactiveColor: Colors.black38,
                onToggle: valueChanged,
              ),
            ),
          ],
        ),
        const  Divider(color: Colors.grey),
      ],
    );
  }
}

