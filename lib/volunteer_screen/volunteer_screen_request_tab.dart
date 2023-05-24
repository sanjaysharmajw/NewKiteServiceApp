import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/ServiceListTabScreens/accepted_service_list_screen.dart';
import 'package:nirbhaya_service/ServiceListTabScreens/completed_service_list_screen.dart';
import 'package:nirbhaya_service/Utils/icon_extension.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/volunteer_screen/volunteer_accept_screen.dart';
import 'package:nirbhaya_service/volunteer_screen/volunteer_all_screen.dart';
import 'package:nirbhaya_service/volunteer_screen/volunteer_reject_screen.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';

import '../ServiceListTabScreens/all_service_list_screen.dart';
import '../ServiceListTabScreens/pending_service_list_screen.dart';
import '../ServiceListTabScreens/rejected_service_list_screen.dart';
import '../Utils/theme.dart';

class VolunteerRequestListTabScreen extends StatefulWidget {
  const VolunteerRequestListTabScreen({super.key});

  @override
  VolunteerRequestListTabScreenState createState() => VolunteerRequestListTabScreenState();
}

class VolunteerRequestListTabScreenState extends State<VolunteerRequestListTabScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appWhiteColor,
        body: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 20),
                    child: InkWell( onTap: (){
                      Get.back();
                    },child: Image.asset('assets/back_icons.png',width: 17,height: 17)),
                  ),

                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: MyText(
                    text: 'Volunteer Request List'.tr,
                    fontName: 'Gilroy',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    textColor: appBlack),
              ),
              Expanded(
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: appWhiteColor,
                    centerTitle: true,
                    elevation: 0,
                    toolbarHeight: 48,
                    automaticallyImplyLeading: false,
                    flexibleSpace: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*-------------- Build Tabs here ------------------*/
                        TabBar(
                            labelPadding: const EdgeInsets.only(left: 25,right: 25),
                            isScrollable: true,
                            tabs: getTabs(),
                            indicatorColor: appBlue)
                      ],
                    ),
                  ),
                  /*--------------- Build Tab body here -------------------*/
                  body: TabBarView(
                    children: getTabContents(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Tab> getTabs() {
    List<String> tabNames = [
      'all'.tr,
      'accepted'.tr,
      'rejected'.tr,
    ];

    List<Tab> tabs = [];
    for (String tabName in tabNames) {
      tabs.add(Tab(
          child: MyText(
              text: tabName,
              fontName: 'Gilroy',
              fontSize: 15,
              fontWeight: FontWeight.w500,
              textColor: appBlack)));
    }
    return tabs;
  }

  List<Widget> getTabContents() {
    return  [
      VolunteerAllScreen(status: ""),
      VolunteerAcceptScreen(status: "Accept"),
      VolunteerRejectScreen(status: "Reject"),
    ];
  }

}
