import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';


class Tools {
  static void setStatusBarColor(Color color) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: color));
  }

  static String allCaps(String str) {
    if(str.isNotEmpty){
      return str.toUpperCase();
    }
    return str;
  }

  static String getFormattedDateShort(int time) {
    DateFormat newFormat =  DateFormat("MMM dd, yyyy");
    return newFormat.format( DateTime.fromMillisecondsSinceEpoch(time));
  }

  static String getFormattedDateSimple(int time) {
    DateFormat newFormat =  DateFormat("dd-MM-yyyy");
    return newFormat.format( DateTime.fromMillisecondsSinceEpoch(time));
  }

  static String getFormattedDateEvent(int time) {
    DateFormat newFormat =  DateFormat("EEE, MMM dd yyyy");
    return newFormat.format( DateTime.fromMillisecondsSinceEpoch(time));
  }

  static String getFormattedTimeEvent(int time) {
    DateFormat newFormat =  DateFormat("h:mm a");
    return newFormat.format( DateTime.fromMillisecondsSinceEpoch(time));
  }
  static String getFormattedCardNo(String cardNo){
    if(cardNo.length < 5) return cardNo;
    return cardNo.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ");
  }

  static void directUrl(String link) async {
    Uri uri = Uri.parse(link);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  appBar({bool isBack = false}) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: isBack,
      centerTitle: true,
      title: Image.asset('images/nft/ic_app_logo.png', fit: BoxFit.cover, width: 160),
    );
  }

  static statusBar(){
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      //systemNavigationBarColor: Colors.blue,
      statusBarColor: Colors.pink, // status bar color
    ));
  }



}
