
import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:nirbhaya_service/contoller/header_controller.dart';

import '../Models/get_current_add_model.dart';
import '../Utils/loader.dart';
import 'package:http/http.dart' as http;

class GetCurrentAddController extends GetxController {
  final headerController = Get.put(HeaderController());
  Future<GetCurrentAddModel?> getCurrentApi(String lat,String lng) async {
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(APIConstant.getCurrentAdd),
        headers: headerController.headerToken,   body: jsonEncode(<String, String>
        {
          "lat": lat,
          "lng": lng
        }),
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        return GetCurrentAddModel.fromJson(responseBody);
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