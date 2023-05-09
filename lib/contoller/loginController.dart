

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:http/http.dart'as http;
import '../Models/registration_models.dart';
import '../Models/send_otp_model.dart';
import '../Models/verify_otp_models.dart';
import '../Utils/loader.dart';

class SendOtpController extends GetxController{

  Future<SendOtpModel?> sendOtp(String mobile) async {
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(APIConstant.sendOtp),
        headers: APIConstant.authHeader,
        body: jsonEncode(<String, String>{"mobile_number": mobile}),
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        return SendOtpModel.fromJson(responseBody);
      }
    }
    on TimeoutException catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.message.toString());
    }  catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.toString());
    }
    return null;
  }

  Future<VerifyOtpModels?> verifyOtp(String mobile,String otp) async {
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(APIConstant.verifyOtp),
        headers: APIConstant.authHeader, body: jsonEncode(<String, String>{
          "mobile_number": mobile,
          "otp": otp
        }),
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        return VerifyOtpModels.fromJson(responseBody);
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

  Future<RegistrationModels?> registration(String firstName,String lastName,String mobile,
      String email
      ,String address,String emergencyNo,String dob,String gender) async {
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(APIConstant.registration),
        headers: APIConstant.authHeader, body: jsonEncode(<String, String>{
          "first_name": firstName,
          "last_name": lastName,
          "mobile_number": mobile,
          "email_id": email,
          "emergency_contact_no": emergencyNo,
          "address": address,
          "dob": dob,
          "gender": gender
        }),
      );
      debugPrint(
        jsonEncode(<String, String>{
          "first_name": firstName,
          "last_name": lastName,
          "mobile_number": mobile,
          "email_id": email,
          "emergency_contact_no": emergencyNo,
          "address": address,
          "dob": dob,
          "gender": gender
        }),
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        return RegistrationModels.fromJson(responseBody);
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