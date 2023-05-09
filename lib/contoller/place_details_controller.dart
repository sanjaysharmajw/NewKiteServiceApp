
import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/contoller/header_controller.dart';

import '../Models/place_details_models.dart';
import 'package:http/http.dart' as http;

import '../api_constant.dart';

class PlaceDetailsController extends GetxController{
  final headerController = Get.put(HeaderController());
  Future<PlaceDetailsModels?> placeDetailsApi(String? placeId) async {
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(APIConstant.placeDetails),
          headers: headerController.headerToken,    body: jsonEncode(<String, String>{"PlaceId": placeId.toString()}),

      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        return PlaceDetailsModels.fromJson(responseBody);
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