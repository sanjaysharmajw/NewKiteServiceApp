import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? instance;

  static const String language = 'LANGUAGE';
  static const String lat = 'LAT';
  static const String lng = 'LNG';
  static const String singleAdd = 'SINGLE_ADD';
  static const String municipality = 'municipality';
  static const String neighborhood = 'neighborhood';
  static const String postalCode = 'postalCode';
  static const String region = 'region';
  static const String subRegion = 'subRegion';
  static const String token = 'TOKEN';
  static const String userId = 'USERID';
  static const String idService = 'ID_SERVICE';
  static const String serviceId = 'ServiceId';
  static const String mobileNumber = 'MobileNumber';
  static const String volunteer = 'volunteer';

  static Future<void> setPreferences() async {
    instance = await SharedPreferences.getInstance();
  }

  static Future<bool> clear() {
    return Preferences.instance!.clear();
  }

  static Future<bool> setLanguage(String value) {
    return Preferences.instance!.setString(language, value);
  }

  static Future<bool> setToken(String value) {
    return Preferences.instance!.setString(token, value);
  }

  static Future<bool> setUserId(String value) {
    return Preferences.instance!.setString(userId, value);
  }

  static Future<bool> setMobileNo(String value) {
    return Preferences.instance!.setString(mobileNumber, value);
  }
  static dynamic getMobileNumber() {
    return Preferences.instance!.get(mobileNumber);
  }



  static Future<bool> setServiceListId(String value) {
    return Preferences.instance!.setString(idService, value);
  }
  static dynamic getServiceListId() {
    return Preferences.instance!.get(idService);
  }

  static Future<bool> setServiceId(String value) {
    return Preferences.instance!.setString(serviceId, value);
  }
  static dynamic getServiceId() {
    return Preferences.instance!.get(serviceId);
  }

  static dynamic getToken() {
    return Preferences.instance!.get(token);
  }

  static dynamic getUserId() {
    return Preferences.instance!.get(userId);
  }

  static dynamic getVolStatus() {
    return Preferences.instance!.get(volunteer);
  }


  static Future<bool> setLat(String value) {
    return Preferences.instance!.setString(lat, value);
  }

  static Future<bool> setLng(String value) {
    return Preferences.instance!.setString(lng, value);
  }

  static Future<bool> setSingle(String value) {
    return Preferences.instance!.setString(singleAdd, value);
  }

  static Future<bool> setMuniciple(String value) {
    return Preferences.instance!.setString(municipality, value);
  }

  static Future<bool> setNeighborhood(String value) {
    return Preferences.instance!.setString(neighborhood, value);
  }

  static Future<bool> setPostalCode(String value) {
    return Preferences.instance!.setString(postalCode, value);
  }

  static Future<bool> setRegion(String value) {
    return Preferences.instance!.setString(region, value);
  }

  static Future<bool> setSubRegion(String value) {
    return Preferences.instance!.setString(subRegion, value);
  }

  static dynamic getLat() {
    return Preferences.instance!.get(lat);
  }

  static dynamic getLng() {
    return Preferences.instance!.get(lng);
  }

  static dynamic getLanguage() {
    return Preferences.instance!.get(language);
  }

  static dynamic getSingleAdd() {
    return Preferences.instance!.get(singleAdd);
  }

  static dynamic getMuniciple() {
    return Preferences.instance!.get(municipality);
  }

  static dynamic getNeighborhood() {
    return Preferences.instance!.get(neighborhood);
  }

  static dynamic getPostalCode() {
    return Preferences.instance!.get(postalCode);
  }

  static dynamic getRegion() {
    return Preferences.instance!.get(region);
  }

  static dynamic getSubRegion() {
    return Preferences.instance!.get(subRegion);
  }

  static Future<bool> setVolStatus(String value) {
    return Preferences.instance!.setString(volunteer, value);
  }

  ///Singleton factory
  static final Preferences _instance = Preferences._internal();
  factory Preferences() {
    return _instance;
  }
  Preferences._internal();
}
