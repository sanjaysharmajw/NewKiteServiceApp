
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:nirbhaya_service/BodyRequest/add_service_request_body.dart';
import 'package:nirbhaya_service/Models/add_service_model.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/Utils/preference.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:nirbhaya_service/contoller/header_controller.dart';

class AddServiceController extends GetxController{

  final registrationNoController = TextEditingController().obs;
  final shopNameController = TextEditingController().obs;
  final contactPersonNoController = TextEditingController().obs;
  final contactPersonNameController = TextEditingController().obs;
  final pinCodeController = TextEditingController().obs;
  final cityController = TextEditingController().obs;
  final stateController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final workingToController = TextEditingController().obs;
  final workingFromController = TextEditingController().obs;
  final selectWorkingDayController = TextEditingController().obs;
  final headerController = Get.put(HeaderController());

  Future<AddServiceModel?> addServiceListApi(AddServiceRequestBody addServiceRequestBody ) async {

    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(APIConstant.addServiceRequest),
        headers: headerController.headerToken, body: jsonEncode(addServiceRequestBody),);
      Map<String, dynamic> responseBody = json.decode(response.body);
      debugPrint('AddServiceRequest');
      debugPrint(jsonEncode(addServiceRequestBody));
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        return AddServiceModel.fromJson(responseBody);
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