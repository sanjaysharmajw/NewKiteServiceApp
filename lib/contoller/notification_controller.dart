
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/BodyRequest/notification_request_body.dart';
import 'package:nirbhaya_service/Models/notification_models.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:http/http.dart'as http;
import 'package:nirbhaya_service/contoller/header_controller.dart';

class NotificationController extends GetxController{
  final headerController = Get.put(HeaderController());
  Future<NotificationModels?> notificationApi(NotificationRequestBody notificationRequestBody) async {
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(APIConstant.notification),
        headers: headerController.headerToken, body: jsonEncode(notificationRequestBody),
      );
      debugPrint('jsonEncode(notificationRequestBody)');
      debugPrint(jsonEncode(notificationRequestBody));
      debugPrint(response.body);
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        return NotificationModels.fromJson(responseBody);
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