import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../color_constant.dart';
class ToastMessage{
  static toast(String msg)  {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: appBlue,
        textColor: appWhiteColor,
        fontSize: 16.0
    );
  }
}
