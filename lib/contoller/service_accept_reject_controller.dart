

import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:nirbhaya_service/BodyRequest/accept_reject_body_request.dart';
import 'package:nirbhaya_service/Models/accept_reject_models.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:http/http.dart'as http;
import 'package:nirbhaya_service/contoller/header_controller.dart';

class ServiceAcceptRejectController extends GetxController{
//  Get.find<NewLoginController>().loginApi('mobile', 'password', 'fcmToken');
  final headerController = Get.put(HeaderController());
  Future<AcceptRejectModels?> acceptRejectApi(AcceptRejectBodyRequest acceptRejectBodyRequest) async {
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(APIConstant.acceptRejectApi),
        headers: headerController.headerToken, body: jsonEncode(acceptRejectBodyRequest),
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        return AcceptRejectModels.fromJson(responseBody);
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