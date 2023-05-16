import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:nirbhaya_service/contoller/header_controller.dart';

import '../Models/reason_master_model.dart';


class ReasonListMasterController extends GetxController{
  var isLoading = true.obs;
  var getReasonMasterData = <ReasonMasterData>[].obs;
  final headerController = Get.put(HeaderController());
  @override
  void onInit() {
    sosReasonMasterListApi();
    super.onInit();
  }

  Future<dynamic> sosReasonMasterListApi() async {
    try {
      //DriverCustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(APIConstant.sosReasonMaster),
        headers: headerController.headerToken,
        body: jsonEncode(<String, String>{
          'status': 'Active',
          'type' : 'volunteer'
        }),
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      debugPrint('master');
      debugPrint(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        CustomLoader.closeLoader();
        ReasonMasterModel model = ReasonMasterModel.fromJson(responseBody);
        getReasonMasterData.value = model.data!;
        debugPrint("first reason is ${model.data![0].name}");
        debugPrint(response.body);
      }
    } on TimeoutException catch (e) {
      isLoading.value = false;
      CustomLoader.showToast(e.message.toString());
      debugPrint('log message');
      debugPrint(e.message.toString());
    } on SocketException catch (e) {
      isLoading.value = false;
      CustomLoader.showToast(e.message.toString());
      debugPrint('log message');
      debugPrint(e.message.toString());
    } on Error catch (e) {
      isLoading.value = false;
      CustomLoader.showToast(e.toString());
      debugPrint('log message');
      debugPrint(e.toString());
    } catch (e) {
      //DriverCustomLoader.closeLoader();
      CustomLoader.showToast(e.toString());
      debugPrint('log message');
      debugPrint(e.toString());
    }
    return null;
  }

}