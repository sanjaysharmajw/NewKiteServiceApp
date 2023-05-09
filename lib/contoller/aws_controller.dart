import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:nirbhaya_service/Utils/preference.dart';

import '../Models/awsModels.dart';
import '../Models/send_otp_model.dart';
import '../Models/upload_document_models.dart';
import '../Utils/loader.dart';
import '../api_constant.dart';

class AwsController extends GetxController{

  Future<AwsModels?> awsUpload(String imagePath) async {
    try{
      CustomLoader.showLoader("Please wait");
      final response = await http.post(
        Uri.parse(APIConstant.awsUploadDoc),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'contentType': 'img/jpeg',
          'filePath': imagePath,
        }),
      );
      print(jsonEncode(<String, String>{
        'contentType': 'img/jpeg',
        'filePath': imagePath,
      }));
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        return AwsModels.fromJson(responseBody);
      } else {
        throw Exception('Failed');
      }
    }on TimeoutException catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.message.toString());
    }  catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.toString());
    }
    return null;
  }

  Future<UpdateDocumentModel?> updateDocument(String userId,String registration, String photo,String token) async {
    try {
      CustomLoader.showLoader("Please wait");
      var data = {
        "user_id": userId,
        "documents": [
          {
            "id_number": registration,
            "photo": photo
          }
        ]
      };
      final response = await http.post(Uri.parse(APIConstant.updateDocument),
        headers: {
          "Content-Type" : "application/json",
          "Authorization" : token
          }, body: jsonEncode(data)
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        return UpdateDocumentModel.fromJson(responseBody);
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