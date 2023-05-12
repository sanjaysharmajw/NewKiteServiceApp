
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:nirbhaya_service/BodyRequest/notification_request_body.dart';
import 'package:nirbhaya_service/Models/notification_model_list.dart';
import 'package:nirbhaya_service/Models/notification_models.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/Utils/preference.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:nirbhaya_service/contoller/header_controller.dart';

class NotificationListController extends GetxController{

  var isLoading = true.obs;
  var getNotificationListData = <NotificationData>[].obs;
  final headerController = Get.put(HeaderController());
  @override
  void onInit() {
    NotificationRequestBody requestBody = NotificationRequestBody(count: false, unread: false, userId: Preferences.getUserId().toString());
    notificationListApi(requestBody);
    super.onInit();
  }

  Future<dynamic> notificationListApi(NotificationRequestBody requestBody) async {
    try {
      //DriverCustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(APIConstant.notification),
        headers: headerController.headerToken,
        body: jsonEncode(requestBody),
      );
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        isLoading.value = false;
        CustomLoader.closeLoader();
        NotificationModelList model = NotificationModelList.fromJson(responseBody);
        getNotificationListData.value = model.data!;
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