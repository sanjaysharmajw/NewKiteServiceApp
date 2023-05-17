import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:nirbhaya_service/BodyRequest/get_volunteer_request_body.dart';
import 'package:nirbhaya_service/BodyRequest/volunteer_status_request_body.dart';
import 'package:nirbhaya_service/Models/get_volunteer_models.dart';
import 'package:nirbhaya_service/Models/status_update_volunteer_models.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/Utils/preference.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:nirbhaya_service/contoller/header_controller.dart';
import 'package:nirbhaya_service/contoller/permission_controller.dart';

class RequestVolunteerController extends GetxController{

  var isLoading = true.obs;
  var getRequestVolunteerData = <VolunteerData>[].obs;
  final headerController = Get.put(HeaderController());
  final locationController = Get.put(PermissionController());

  Future<dynamic> requestVolunteerApi(String status) async {
    GetVolunteerRequestBody volunteerRequestBody=GetVolunteerRequestBody(
      userId: '6459fddbc7468996607d7908',
      status: status.toString(),
      lat: locationController.locationData!.latitude.toString(),
      lng: locationController.locationData!.longitude.toString(),
    );
    try {
      //DriverCustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(APIConstant.getVolunteerRequests),
        headers: headerController.headerToken,
        body: jsonEncode(volunteerRequestBody),
      );
      debugPrint('Volunteer');
      debugPrint(jsonEncode(volunteerRequestBody));
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
     // Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        CustomLoader.closeLoader();
        GetVolunteerModels model = GetVolunteerModels.fromJson(responseBody);
        getRequestVolunteerData.value = model.data!;
      }
    } on TimeoutException catch (e) {
      isLoading.value = false;
      CustomLoader.showToast(e.message.toString());
    } on SocketException catch (e) {
      isLoading.value = false;
      CustomLoader.showToast(e.message.toString());
    } on Error catch (e) {
      isLoading.value = false;
      CustomLoader.showToast(e.toString());
    } catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.toString());
    }
    return null;
  }


  Future<StatusUpdateVolunteerModels?> volunteerStatusUpdate(VolunteerStatusRequestBody requestBody) async {
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(APIConstant.updateVolunteerRequest),
        headers: headerController.headerToken,
        body: jsonEncode(requestBody),
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        return StatusUpdateVolunteerModels.fromJson(responseBody);
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

}