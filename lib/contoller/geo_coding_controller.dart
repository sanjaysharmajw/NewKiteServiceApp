

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:nirbhaya_service/contoller/header_controller.dart';

import '../Models/geo_coding_models.dart';
import '../Models/service_list_models.dart';

class GeoCodingController extends GetxController{

  var isLoading = true.obs;
  var getGeoCodingAddressData = <Results>[].obs;
  final headerController = Get.put(HeaderController());

  Future<dynamic> getAddressUsingLatLng(double lat,double lng) async {
    var apiKey=APIConstant.geoCodingApi;
    try {
      final response = await http.post(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$lat, $lng&key=$apiKey'
      ),
        headers: headerController.headerToken
      );
      log(response.body);
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        GeoCodingModels model = GeoCodingModels.fromJson(responseBody);
        getGeoCodingAddressData.value = model.results!;
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

}