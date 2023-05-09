import 'package:get/get_utils/src/platform/platform.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleMapNavigation{
  static Future<void> openMap(String latitude, String longitude) async {
    var lat = double.parse(latitude);
    var lng = double.parse(longitude);
    await launchUrl(Uri.parse('google.navigation:q=$lat, $lng&key=AIzaSyAmOl-QJnc2Spwuh8GAoqx9Z3Wz-ez73V8'));
  }}