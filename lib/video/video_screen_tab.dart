import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/ServiceListTabScreens/accepted_service_list_screen.dart';
import 'package:nirbhaya_service/ServiceListTabScreens/completed_service_list_screen.dart';
import 'package:nirbhaya_service/Utils/icon_extension.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/video/live_video_screen.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';

import '../ServiceListTabScreens/all_service_list_screen.dart';
import '../ServiceListTabScreens/pending_service_list_screen.dart';
import '../ServiceListTabScreens/rejected_service_list_screen.dart';
import '../Utils/theme.dart';
import 'list_video_screen.dart';

class VideoScreenTab extends StatefulWidget {
  const VideoScreenTab({super.key});

  @override
  VideoScreenTabState createState() => VideoScreenTabState();
}

class VideoScreenTabState extends State<VideoScreenTab> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appWhiteColor,
        body: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: MyText(
                    text: 'Video List',
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
                            isScrollable: false,
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
      'Live Video',
      'Library'
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
      LiveVideoScreen(status: "Live"),
      ListVideoScreen(status: "Library"),

    ];
  }
}
