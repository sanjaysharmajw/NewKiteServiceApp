import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:nirbhaya_service/Screens/login_mobile.dart';
import 'package:nirbhaya_service/Screens/service_registraion_form.dart';
import 'package:nirbhaya_service/Utils/tools.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/contoller/permission_controller.dart';
import 'package:nirbhaya_service/select_address/SelectAddressMap.dart';
import 'package:nirbhaya_service/video/video_screen_tab.dart';
import 'package:nirbhaya_service/widgets/images_set.dart';
import 'Language/locat_string.dart';
import 'Utils/custom_bottom_nav.dart';
import 'Utils/loader.dart';
import 'Utils/preference.dart';
import 'Utils/theme.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  Tools.setStatusBarColor(appBlue);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return GetMaterialApp(
      builder: EasyLoading.init(),
      translations: LocaleString(),
      locale: const Locale('en','US'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: appBlue)
            ),
          )),
      home: const SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
            child: ImageSets(imagePath: 'assets/servicenow_logo.png', width: 230, height: 50, color: appBlue),
        ),
      ),
    );
  }

  final permissionController=Get.put(PermissionController());

  @override
  void initState() {
    sharePre();
    startTimer();
    super.initState();
  }

  void startTimer() {
    Timer(const Duration(seconds: 2), () {
     // Get.to(const CustomBottomNav());
      checkLoginStatus();
    });
  }
  
  Future checkLoginStatus() async {
    await Preferences.setPreferences();
    String? userId = Preferences.getUserId();
    if (userId == null) {
      Get.to(const LoginMobile());
    } else {
      Get.to(const CustomBottomNav());
    }
    setState(() { });
  }

  void sharePre() async {
    await permissionController.permissionLocation();
    WidgetsFlutterBinding.ensureInitialized();
    await Preferences.setPreferences();
    var language = Preferences.getLanguage();
    if(language=='hi'){
      var local=const Locale('hi',"IN");
      Get.updateLocale(local);
    }else if(language=='en'){
      var eng=const Locale('en','US');
      Get.updateLocale(eng);
    }else if(language=='mr'){
      var eng=const Locale('mr','IN');
      Get.updateLocale(eng);
    }
  }
}

