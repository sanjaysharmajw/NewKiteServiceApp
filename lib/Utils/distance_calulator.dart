
import 'dart:math';

class DistanceCalculator{
  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * 1000 * asin(sqrt(a));
  }


  static double calculateDistanceBetweenTwoLtnLng(
  DistanceLatLng origin, DistanceLatLng destination) {
    double lat1 = origin.latitude;
    double lon1 = origin.longitude;
    double lat2 = destination.latitude;
    double lon2 = destination.longitude;
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static String formatDistance(double distance) {
    if (distance > 1000) {
      distance = distance / 1000;
      return "${(distance).toStringAsFixed(
          distance.truncateToDouble() == distance ? 0 : 2)} KM";
    } else {
      return distance.floor().toString() + " Meter";
    }
  }

}
class DistanceLatLng {
  final double latitude, longitude;
  DistanceLatLng(this.latitude, this.longitude);
}