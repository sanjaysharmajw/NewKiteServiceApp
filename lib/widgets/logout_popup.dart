import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nirbhaya_service/Screens/login_mobile.dart';
import 'package:nirbhaya_service/color_constant.dart';
import '../Utils/preference.dart';

Future<bool> logoutPopup(context) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("do_you_want_to_log_out?".tr),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print('yes selected');
                          logout();
                          Get.to(const LoginMobile());
                          // exit(0);
                        },
                        child:  Text("yes".tr),
                        style: ElevatedButton.styleFrom(
                            primary: appBlue),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('no selected');
                            Navigator.of(context).pop();
                          },
                          child: Text("no".tr, style: TextStyle(color: Colors.black)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        );
      });
}

Future logout() async {
  //await Preferences.setPreferences();
  Preferences.clear();
}
