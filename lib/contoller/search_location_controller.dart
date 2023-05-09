import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/contoller/header_controller.dart';
import '../Models/search_location_model.dart';
import '../api_constant.dart';

class SearchLocationController {

  static Future<List<SearchLocationModel>?> searchLocation(String searchValue) async {
    final headerController = Get.put(HeaderController());
    try {
      CustomLoader.showLoader("Please wait");
      final http.Response response = await http.post(
        Uri.parse(
          APIConstant.searchLocation,
        ),
        headers: headerController.headerToken,
        body: jsonEncode(<String, String>{"search": searchValue}),
      );
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        List<SearchLocationModel> locationData =
            jsonDecode(response.body)['result']
                .map<SearchLocationModel>(
                    (data) => SearchLocationModel.fromJson(data))
                .toList();
        return locationData;
      }
    } on TimeoutException catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.message.toString());
    } catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.toString());
    }

    return null;
  }
}
