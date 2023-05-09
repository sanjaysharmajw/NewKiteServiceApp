

import 'dart:io';

import 'package:get/get.dart';
import 'package:nirbhaya_service/Utils/preference.dart';

class HeaderController extends GetxController{


  String? loginToken;
  Map<String, String>? headerToken;

  @override
  void onInit() {
    sharePreferences();
    super.onInit();
    headerToken = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      'Authorization': loginToken.toString()
    };
  }
  void sharePreferences()async{
    Preferences.setPreferences();
    loginToken=Preferences.getToken().toString();
  }
}