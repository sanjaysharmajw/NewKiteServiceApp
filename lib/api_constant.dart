
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:nirbhaya_service/Utils/preference.dart';

class APIConstant{

  static const baseUrlOld = "https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/";
  static const baseUrl = "https://24txld2sb5.execute-api.ap-south-1.amazonaws.com/dev/api/";
  static const awsImagePathUrl = 'https://travelsafe-docs.s3.ap-south-1.amazonaws.com/';
  static const googleMapAPIKey = 'AIzaSyAmOl-QJnc2Spwuh8GAoqx9Z3Wz-ez73V8';
  static const geoCodingApi = 'AIzaSyDyHuF24jqX1EIQCy-C1XQxusSvEJITzAg';
  static const googleMapGetDirection="AIzaSyBvMbj8bSuQ3W2e0ILvvby9d3UTjpxD9KI";


  static Map<String, String> authHeader  = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
  };


  static Map<String, String> headerToken = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    'Authorization': Preferences.getToken().toString()
  };

  static const searchLocation = "${baseUrl}user/geocodelats";
  static var socketUrl = 'http://65.1.73.254:8090';
  static const placeDetails = "${baseUrl}user/geocodelocationdetails";
  static const getCurrentAdd = "${baseUrl}user/reversegeo";
  static const sendOtp = "${baseUrl}user/sendOtpNew";
  static const verifyOtp = "${baseUrl}user/verifyOtpNew";
  static const registration = "${baseUrl}user/regUserNew";
  static const awsUploadDoc = "${baseUrl}getSignedUrlsgb/getSignedURL";
  static const updateDocument = "${baseUrl}user/updateUserDocuments";
  static const serviceRequestList = "${baseUrl}serviceProvider/serviceRequestList";
  static const notification = "${baseUrl}user/userNotification";
  static const addServiceRequest = "${baseUrl}serviceProvider/userServiceAdd";
  static const updateAddServiceRequest = "${baseUrl}serviceProvider/updateUserService";
  static const serviceTypeMasterList = "${baseUrl}serviceProvider/serviceTypeMasterList";
  static const userServiceList = "${baseUrl}serviceProvider/userServiceList";
  static const acceptRejectApi = "${baseUrl}serviceProvider/acceptrejectServiceRequest";
  static const serviceStartRide = "${baseUrl}user/userRideAdd";
  static const completeServiceRequest = "${baseUrl}serviceProvider/completeServiceRequest";
  static const userDetails = "${baseUrl}user/userList";
  static const updateProfile = "${baseUrl}user/updateUserProfile";
  static const selectVolunteer = "${baseUrl}user/updatevolunteerStatus";

  static const sosReasonMaster = "${baseUrl}user/sosReasonMaster";
  static const videoList = "${baseUrl}user/getVideoList";
  static const videoAttend = "${baseUrl}user/attendSession";

}