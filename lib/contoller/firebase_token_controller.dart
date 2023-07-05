import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FirebaseTokenController extends GetxController {

//  var firebaseToken = "".obs;
  RxString getfirebaseToken = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getFirebaseToken();
  }

  void getFirebaseToken() async {

   String? firebaseToken = await FirebaseMessaging.instance.getToken();
   RxString rxStringValue = RxString(firebaseToken.toString());
   getfirebaseToken=rxStringValue;

  }
}
