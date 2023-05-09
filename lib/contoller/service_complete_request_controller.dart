
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/BodyRequest/complete_service_request_body.dart';
import 'package:nirbhaya_service/Models/complete_service_request_model.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:http/http.dart'as http;
import 'package:nirbhaya_service/contoller/header_controller.dart';
import '../api_constant.dart';

class ServiceCompleteRequestController extends GetxController{
  final headerController=Get.put(HeaderController());

  Future<CompleteServiceRequestModel?> completeServiceApi(CompleteServiceRequestBody requestBody) async {
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(APIConstant.completeServiceRequest),
        headers: headerController.headerToken, body: jsonEncode(requestBody),
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      debugPrint('service complete');
      debugPrint(jsonEncode(requestBody));
      debugPrint(response.body);
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        return CompleteServiceRequestModel.fromJson(responseBody);
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