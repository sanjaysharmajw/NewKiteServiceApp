import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:nirbhaya_service/Models/awsModels.dart';
import 'dart:io';

import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/api_constant.dart';


class AwsControllerComera extends GetxController{

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
        var status = jsonDecode(response.body)['data'];
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

  Future<http.Response?> awsUploadFinal(path,File? file) async {
    try {

      CustomLoader.showLoader("Please wait");
      final response = await http.put(
          Uri.parse(path.toString()),
          body: file!.readAsBytesSync()
      );
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        CustomLoader.message('Successful');
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