import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:nirbhaya_service/Models/video_list_models.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:nirbhaya_service/contoller/header_controller.dart';

import '../BodyRequest/video_request.dart';

class VideoListController extends GetxController{

  var isLoading = true.obs;
  var getVideoListData = <VideoData>[].obs;
  final headerController = Get.put(HeaderController());

  Future<dynamic> videoListApi(VideoRequest requestBody) async {
    try {
      //DriverCustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse(APIConstant.videoList),
        headers: headerController.headerToken,
        body: jsonEncode(requestBody),
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        CustomLoader.closeLoader();
        VideoListModels model = VideoListModels.fromJson(responseBody);
        getVideoListData.value = model.data!;
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