import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nirbhaya_service/BodyRequest/service_list_request_body.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:nirbhaya_service/contoller/header_controller.dart';
import 'package:nirbhaya_service/contoller/permission_controller.dart';

import '../Models/service_list_models.dart';

class ServiceListController extends GetxController{

  var isLoading = true.obs;
  var getServiceData = <ServiceListData>[].obs;
  final permissionController=Get.put(PermissionController());
  final headerController = Get.put(HeaderController());

  Future<dynamic> getServiceList(ServiceListRequestBody requestBody) async {
    try {
      final response = await http.post(Uri.parse(APIConstant.serviceRequestList),
        headers: headerController.headerToken,
        body: jsonEncode(requestBody),
      );
      debugPrint('serviceListApi');
      debugPrint(jsonEncode(requestBody));
      debugPrint(headerController.headerToken.toString());
      debugPrint("service_response ${response.body}");
      log('response');
      log(response.body);
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        isLoading.value = false;
        ServiceListModels model = ServiceListModels.fromJson(responseBody);
        getServiceData.value = model.data!;
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