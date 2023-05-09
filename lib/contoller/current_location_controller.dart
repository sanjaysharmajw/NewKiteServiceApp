
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';


class CurrentLocationController extends GetxController{

  late final Position? position;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }
  void getCurrentLocation()async{
    position = await Geolocator.getCurrentPosition();
  }
}