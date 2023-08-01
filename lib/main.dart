import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/Screens/login_mobile.dart';
import 'package:nirbhaya_service/Utils/tools.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/contoller/permission_controller.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';
import 'Language/locat_string.dart';
import 'Utils/custom_bottom_nav.dart';
import 'Utils/preference.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final permissionController=Get.put(PermissionController());

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
      home:  Container(
        color: appWhiteColor,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/service_logo.png',width: 130,height: 130),
              const MyText(text: "TS Service", fontName: 'Gilroy', fontSize: 26, fontWeight: FontWeight.w600, textColor: appBlack)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // FCM Push Notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  color: Colors.blue,
                  playSound: true,
                  importance: Importance.high,
                  priority: Priority.high,
                  enableLights: true,
                  icon: '@mipmap/ic_launcher',
                  //sound: const RawResourceAndroidNotificationSound('notification_play'),
                  sound: const RawResourceAndroidNotificationSound('notification_play')
              ),
            )
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
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
    setState(() {});
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

