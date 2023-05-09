import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nirbhaya_service/Models/service_list_master_models.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:nirbhaya_service/contoller/header_controller.dart';


class ServiceListMasterController extends GetxController{
  var isLoading = true.obs;
  var getServiceMasterListData = <ServiceTypeListMasterData>[].obs;
  final headerController = Get.put(HeaderController());
  @override
  void onInit() {
    serviceMasterListApi();
    super.onInit();
  }

  Future<dynamic> serviceMasterListApi() async {
    try {
      //DriverCustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(APIConstant.serviceTypeMasterList),
        headers: headerController.headerToken,
        body: jsonEncode(<String, String>{
          'status': 'Active'
        }),
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      debugPrint('master');
      debugPrint(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        CustomLoader.closeLoader();
        ServiceListMasterModel model = ServiceListMasterModel.fromJson(responseBody);
        getServiceMasterListData.value = model.data!;
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