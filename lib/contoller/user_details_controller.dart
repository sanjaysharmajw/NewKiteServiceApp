
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/BodyRequest/user_details_request_body.dart';
import 'package:nirbhaya_service/Models/user_details_models.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:http/http.dart' as http;
import 'package:nirbhaya_service/Utils/preference.dart';
import 'package:nirbhaya_service/contoller/header_controller.dart';
import '../api_constant.dart';

class UserDetailsController extends GetxController{
  final headerController = Get.put(HeaderController());
  var isLoading = true.obs;
  var getUserDetailsData = <UserDetailsData>[].obs;


  Future<dynamic> updateProfile() async {
    await Preferences.setPreferences();
    String mobileNo=Preferences.getMobileNumber().toString();
    UserDetailsRequestBody requestBody=UserDetailsRequestBody(
        mobileNumber: Preferences.getMobileNumber().toString()
    );
    try {
      final response = await http.post(Uri.parse(APIConstant.userDetails),
        headers: headerController.headerToken,
        body: jsonEncode(requestBody),
      );
      debugPrint('userdetails');
      debugPrint(jsonEncode(requestBody));
      debugPrint(response.body);

      var volStatus = Preferences.getVolStatus().toString();
      debugPrint('volStatus $volStatus');

      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        isLoading.value = false;
        UserDetailsModels model = UserDetailsModels.fromJson(responseBody);
        getUserDetailsData.value = model.data!;
      }
    } on TimeoutException catch (e) {
      isLoading.value = false;
      CustomLoader.showToast(e.message.toString());
    } on SocketException catch (e) {
      isLoading.value = false;
      CustomLoader.showToast(e.message.toString());
    } on Error catch (e) {
      isLoading.value = false;
      CustomLoader.showToast(e.toString());
    } catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.toString());
    }
    return null;
  }
}