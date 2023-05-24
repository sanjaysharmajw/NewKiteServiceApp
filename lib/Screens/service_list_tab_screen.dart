import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/ServiceListTabScreens/accepted_service_list_screen.dart';
import 'package:nirbhaya_service/ServiceListTabScreens/completed_service_list_screen.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';
import '../ServiceListTabScreens/all_service_list_screen.dart';
import '../ServiceListTabScreens/pending_service_list_screen.dart';
import '../ServiceListTabScreens/rejected_service_list_screen.dart';

class ServiceListTabScreen extends StatefulWidget {
  const ServiceListTabScreen({super.key});

  @override
  ServiceListTabScreenState createState() => ServiceListTabScreenState();
}

class ServiceListTabScreenState extends State<ServiceListTabScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appWhiteColor,
        body: DefaultTabController(
          length: 5,
          initialIndex: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: MyText(
                    text: 'ServiceList'.tr,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
      'pending'.tr,
      'accepted'.tr,
      'rejected'.tr,
      'completed'.tr,
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
      AllServiceListScreen(status: ""),
      PendingServiceListScreen(status: "Pending"),
      AcceptedServiceListScreen(status: "Accept"),
      RejectedServiceListScreen(status: "Reject"),
      CompletedServiceListScreen(status: "Completed"),
    ];
  }
}
