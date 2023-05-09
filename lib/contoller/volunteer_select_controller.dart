import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/BodyRequest/volunteer_request.dart';
import 'package:nirbhaya_service/Models/volunteer_models.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:http/http.dart';
import 'package:nirbhaya_service/contoller/header_controller.dart';


class VolunteerController extends GetxController{
  final headerController = Get.put(HeaderController());
  Future<VolunteerModels?> volunteerApi(VolunteerRequest request) async {
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(APIConstant.selectVolunteer),
        headers: headerController.headerToken, body: jsonEncode(request),);
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        return VolunteerModels.fromJson(responseBody);
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

