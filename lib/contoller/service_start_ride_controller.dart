import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/BodyRequest/start_ride_request.dart';
import 'package:nirbhaya_service/Models/start_ride_modesl.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:http/http.dart' as http;
import 'package:nirbhaya_service/contoller/header_controller.dart';

class ServiceStartRideController extends GetxController {
  final headerController = Get.put(HeaderController());
  Future<StartRideModesl?> serviceStartRideApi(
      StartRideRequest startRideRequest) async {
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(
        Uri.parse(APIConstant.serviceStartRide),
        headers: headerController.headerToken,
        body: jsonEncode(startRideRequest),
      );
      debugPrint('StartzRide');
      debugPrint(jsonEncode(startRideRequest));
      debugPrint(response.body);
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        return StartRideModesl.fromJson(responseBody);
      }
    } on TimeoutException catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.message.toString());
    } catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.toString());
    }
    return null;
  }
}
