//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:get/get.dart';
//
// class CheckInternetController extends GetxController{
//   Future<bool> checkInternet() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.mobile) {
//       return true;
//     } else if (connectivityResult == ConnectivityResult.wifi) {
//       return true;
//     }
//     return false;
//   }
// }