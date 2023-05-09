import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/Utils/preference.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/contoller/user_details_controller.dart';
import 'package:nirbhaya_service/utils_screens/exit_dialog.dart';
import '../Screens/home_page.dart';
import '../Screens/service_list_tab_screen.dart';
import '../Screens/service_registration.dart';
import '../profile_screen/profile_screen.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});

  @override
  UserDashBoardScreenState createState() => UserDashBoardScreenState();
}

class UserDashBoardScreenState extends State<CustomBottomNav> {
  int currentPage = 0;
  Position? position;
  final userDetailsController=Get.put(UserDetailsController());

  List<Widget> page = [
    const HomePage(),
    const ServiceListTabScreen(),
    const ServiceRegistrationUI(),
    const ProfileScreen(),
  ];

  List<BottomNavigationBarItem> icons = const [
    BottomNavigationBarItem(icon: Icon(FeatherIcons.home), label: ''),
    BottomNavigationBarItem(icon: Icon(FeatherIcons.server), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.work_outline_sharp), label: ''),
    BottomNavigationBarItem(icon: Icon(FeatherIcons.user), label: '')
  ];

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    userDetailsApi();
  }

  void userDetailsApi()async{
    await userDetailsController.updateProfile();
    debugPrint('loginToken');
    debugPrint(Preferences.getToken().toString());
  }

  void getCurrentLocation() async {
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => exitShowDialog(context, 'Confirmation', 'No', 'Yes', 'Are you sure you want to exit?', () { Get.back(); }, () { exit(0);}),
      child: Scaffold(
        body: page[currentPage],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: appBlue,
          backgroundColor: appWhiteColor,
          elevation: 5,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: currentPage,
          type: BottomNavigationBarType.fixed,
          items: icons,
          onTap: (value) {
            currentPage = value;
            setState(() {});
          },
        ),
      ),
    );
  }
}
