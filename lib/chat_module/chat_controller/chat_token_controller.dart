import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:nirbhaya_service/chat_module/models/chat_token_model.dart';
import 'package:nirbhaya_service/chat_module/models/get_token_request_body.dart';

class ChatTokenController extends GetxController{
  Future<ChatTokenModel?> chatTokenApi(GetTokenRequestBody requestBody) async {
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.post(Uri.parse('http://65.1.73.254:3700'),
        headers: APIConstant.authHeader, body: jsonEncode(requestBody),
      );

      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        return ChatTokenModel.fromJson(responseBody);
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