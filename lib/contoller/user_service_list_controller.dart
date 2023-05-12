import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nirbhaya_service/BodyRequest/service_list_body_request.dart';
import 'package:nirbhaya_service/Models/service_list_model.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:nirbhaya_service/contoller/header_controller.dart';
import 'package:nirbhaya_service/contoller/permission_controller.dart';

class UserServiceListController extends GetxController{
  var isLoading = true.obs;
  var getUserServiceListData = <UserServiceListData>[].obs;
  final permissionController=Get.put(PermissionController());
  final headerController = Get.put(HeaderController());

  Future<dynamic> getUserServiceList(ServiceListBodyRequest request) async {
    try {
      final response = await http.post(Uri.parse(APIConstant.userServiceList),
        headers: headerController.headerToken,
        body: jsonEncode(request),
      );
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      debugPrint('userServiceList');
      debugPrint(response.body);

      if (response.statusCode == 200) {
        isLoading.value = false;
        ServiceListModel model = ServiceListModel.fromJson(responseBody);
        getUserServiceListData.value = model.data!;
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