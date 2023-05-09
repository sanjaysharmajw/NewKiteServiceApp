

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/BodyRequest/update_profile_update_request_body.dart';
import 'package:nirbhaya_service/Models/update_profile_models.dart';
import 'package:http/http.dart'as http;
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/Utils/preference.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:nirbhaya_service/contoller/header_controller.dart';

class ServiceUpdateProfileController extends GetxController{

  final firstNameController=TextEditingController().obs;
  final lastNameController=TextEditingController().obs;
  final mobileController=TextEditingController().obs;
  final emailController=TextEditingController().obs;
  final addressController=TextEditingController().obs;
  final emergencyController=TextEditingController().obs;
  final selectDobController=TextEditingController().obs;

  Future<UpdateProfileModels?> updateProfile(String gender ) async {
    UpdateProfileUpdateRequestBody requestBody=UpdateProfileUpdateRequestBody(
      userId: Preferences.getUserId().toString(),
      firstName:firstNameController.value.text,
      lastName: lastNameController.value.text,
      mobileNumber: mobileController.value.text,
      emailId: emailController.value.text,
      permanentAddress: PermanentAddress(
        address: addressController.value.text
      ),
      emergencyContactNo: emergencyController.value.text,
      dob: selectDobController.value.text,
      gender: gender.toString()
    );
    final headerController = Get.put(HeaderController());
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(APIConstant.updateProfile),
        headers: headerController.headerToken, body: jsonEncode(requestBody),
      );
      debugPrint('updatePPPP');
      debugPrint(jsonEncode(requestBody));
      debugPrint(response.body);
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        return UpdateProfileModels.fromJson(responseBody);
      }
    } on TimeoutException catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.message.toString());
    }  catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.toString());
    }
    return null;
  }
}