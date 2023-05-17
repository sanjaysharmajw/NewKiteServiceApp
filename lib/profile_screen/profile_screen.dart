
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutx/flutx.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nirbhaya_service/BodyRequest/user_details_request_body.dart';
import 'package:nirbhaya_service/BodyRequest/volunteer_request.dart';
import 'package:nirbhaya_service/BodyRequest/volunteer_status_request.dart';
import 'package:nirbhaya_service/Models/reason_master_model.dart';
import 'package:nirbhaya_service/Screens/about_us_screen.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/chat_bot/ChatScreen.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/contoller/reason_list_master_controller.dart';
import 'package:nirbhaya_service/contoller/user_details_controller.dart';
import 'package:nirbhaya_service/contoller/volunteer_select_controller.dart';
import 'package:nirbhaya_service/video/video_screen_tab.dart';
import 'package:nirbhaya_service/volunteer_screen/volunteer_screen_request.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../Screens/edit_profile_screen.dart';
import '../Utils/preference.dart';
import '../widgets/MyText.dart';
import '../widgets/logout_popup.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({Key? key}) : super(key: key);


  @override
  ProfileScreenState createState() => ProfileScreenState();

}

class ProfileScreenState extends State<ProfileScreen> {

  PackageInfo? packageInfo;
  bool? volunteerStatus=false;
  List<ReasonMasterData>? reasons;

  final userDetailsController=Get.put(UserDetailsController());
  String? volunteer;
  List<VolunteerAri> selectedAri = [];

  final List<String> _reasonNames = [];
  final List<String> _selectedReasonNames= [];

  final reasonMasterListController = Get.put(ReasonListMasterController());


  final volunteerController=Get.put(VolunteerController());
  final List locale = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'हिंदी', 'locale': const Locale('hi', 'IN')},
    {'name': 'मराठी', 'locale': const Locale('mr', 'IN')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  Future<void> share(String language) async {
    await  Preferences.setPreferences();
    Preferences.setLanguage(language);

  }
  void userDetailsApi()async{
    await userDetailsController.updateProfile();
   volunteer= userDetailsController.getUserDetailsData[0].volunteer;

   if(_selectedReasonNames.isNotEmpty){
     _selectedReasonNames.clear();
     selectedAri.clear();
     _reasonNames.clear();

   }

   for(var i = 0; i< userDetailsController.getUserDetailsData[0].volunteerAri!.length;i++){
     debugPrint("selected reason ${userDetailsController.getUserDetailsData[0].volunteerAri![i].name}");
     _selectedReasonNames.add(userDetailsController.getUserDetailsData[0].volunteerAri![i].name.toString());
   }
   setState(() {});
   // debugPrint("volunteer ari items ${volunteer[].}");
  }


  void _showMultiSelect(BuildContext context) async {
    reasons = reasonMasterListController.getReasonMasterData.value;
    for (var i = 0; i < reasons!.length; i++) {
      _reasonNames.add(reasons![i].name.toString());
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return reasonMasterListController.isLoading==true?CustomLoader.loader():
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: MultiSelectBottomSheet(
            items: _reasonNames.map((e) => MultiSelectItem(e, e)).toList(),
            initialValue: _selectedReasonNames,
            selectedColor: Colors.black,
            cancelText: const Text("Cancel", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20,fontFamily: "Gilroy"),),
            confirmText: const Text("Confirm", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 20,fontFamily: "Gilroy")),
            title: const Text("I want to help in following situations", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,fontFamily: "Gilroy"),),
            onConfirm: (values) {
              for (var i = 0; i < values.length; i++) {
                _selectedReasonNames.add(values[i].toString());
                debugPrint("selected value : ${values[i].toString()}");
                // make volunteer ari object list
                VolunteerAri ari = VolunteerAri(id: reasons![i].id, name: reasons![i].name);
                selectedAri.add(ari);
              }

              if(volunteerStatus==true){
                volunteerApi("No");
              }else{
                volunteerApi("Yes");
              }
            },
            maxChildSize: 0.9,
        ));
      },
    );
  }
  buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Padding(
              padding: const EdgeInsets.all(5.0),
              child:
              Text('ChooseLang'.tr, style: const TextStyle(fontFamily: 'Gilroy')),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        child: Text(locale[index]['name'],
                            style: const TextStyle(fontFamily: 'Gilroy')),
                        onTap: () {
                          if (index == 0) {
                            share('en');
                          } else if (index == 1) {
                            share('hi');
                          } else {
                            share('mr');
                          }
                          updateLanguage(locale[index]['locale']);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: appBlue,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

  @override
  void initState() {
    userDetailsApi();
    super.initState();
  }


  Widget _buildSingleSetting(
      String setting, String subSetting, IconData icon, Color? color,VoidCallback click) {
    return InkWell(
      onTap: click,
      child: Padding(
        padding: FxSpacing.y(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: color),
            FxSpacing.width(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.titleSmall(setting, fontWeight: 600, color: color),
                FxSpacing.height(4),
                FxText.bodySmall(
                  subSetting,
                  color: appBlack,
                  fontWeight: 600,
                  xMuted: true,
                  fontSize: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: FxSpacing.x(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             // const SizedBox(height: 25),
              // InkWell( onTap: (){
              //   Get.back();
              // },child: Image.asset('assets/back_icons.png',width: 17,height: 17)),
              const SizedBox(height: 25),
              const MyText(text: 'Profile', fontName: 'Gilroy',
                  fontSize: 20, fontWeight: FontWeight.w800, textColor: appBlack),
              const SizedBox(height: 25),

             // Obx((){
             //   return  Column(
             //     children: [
             //       Center(
             //         child: Stack(
             //           clipBehavior: Clip.none,
             //           children:  [
             //             InkWell(
             //               onTap: (){
             //                 Get.to(EditProfileScreen(userDetailsData: userDetailsController.getUserDetailsData[0]));
             //               },
             //               child: const ClipRRect(
             //                 clipBehavior: Clip.antiAliasWithSaveLayer,
             //                 borderRadius: BorderRadius.all(Radius.circular(60)),
             //                 child: Image(
             //                   height: 100,
             //                   width: 100,
             //                   image: AssetImage('images/car.jpg'),
             //                   fit: BoxFit.cover,
             //                 ),
             //               ),
             //             ),
             //             const Positioned(
             //               bottom: 0,
             //               right: 0,
             //               child: FxCard(
             //                 paddingAll: 2,
             //                 borderRadiusAll: 4,
             //                 clipBehavior: Clip.none,
             //                 child: FxContainer(
             //                   paddingAll: 4,
             //                   borderRadiusAll: 4,
             //                   color:appBlue,
             //                   child: Icon(
             //                     Icons.camera_alt,
             //                     size: 16,
             //                     color: appWhiteColor,
             //                   ),
             //                 ),
             //               ),
             //             ),
             //           ],
             //         ),
             //       ),
             //       FxSpacing.height(20),
             //       FxText.bodyLarge(
             //         "${userDetailsController.getUserDetailsData[0].firstName??"wait"}\n${userDetailsController.getUserDetailsData[0].lastName??"..."}",
             //         fontWeight: 700,color: appBlack,
             //       ),
             //     ],
             //   );
             // }),

              FxSpacing.height(50),
              _buildSingleSetting('Profile', 'Update your profile',
                  FeatherIcons.messageCircle, appBlack,(){
                    Get.to(EditProfileScreen(userDetailsData: userDetailsController.getUserDetailsData[0]));
                  }),
              const Divider(),
              _buildSingleSetting('Video', 'You can watch live video etc...',
                  FeatherIcons.video, appBlack,(){
                    Get.to(const VideoScreenTab());
                  }),

              const Divider(),
              _buildSingleSetting('Volunteer Request', 'Check request',
                  FeatherIcons.userPlus, appBlack,(){
                    Get.to(const VolunteerRequestList());
                  }),


              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSingleSetting('Volunteer'.tr, 'would you like to help others?'.tr,
                      FeatherIcons.user, appBlack,(){
                        if(volunteer=="Yes"){
                          _showMultiSelect(context);
                        }else{
                          // volunteerApi("No");
                        }
                      }
                      ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: FlutterSwitch(
                      width: 60.0,
                      height: 30.0,
                      value: volunteer=="Yes"?true:volunteer=="No"?false:false,
                      borderRadius: 30.0,
                      padding: 5.0,
                      activeColor: blackColor,
                      onToggle: (val) {
                        setState(() {

                          if(volunteer=="No"){
                            _showMultiSelect(context);
                          }else{
                            volunteerApi("No");
                          }


                        });
                      },
                    ),
                  ),
                ],
              ),

              const Divider(),
              _buildSingleSetting('language'.tr, 'changeYourLanguage'.tr,
                  FeatherIcons.settings, appBlack,(){
                    buildLanguageDialog(context);
                  }),


              // const Divider(),
              // _buildSingleSetting(
              //     'Notification',
              //     'Ringtone, Message, Notification',
              //     FeatherIcons.bell,
              //     appBlack),
              const Divider(),
              _buildSingleSetting('Help', 'Contact Us',
                  FeatherIcons.messageCircle, appBlack,(){
                  Get.to(const ChatScreen());
                  }),
              const Divider(),
              _buildSingleSetting('About', 'About the application',
                  FeatherIcons.alertCircle, appBlack,(){
                Get.to(const AboutUsScreen());
                  }),
              const Divider(),
              _buildSingleSetting('Log Out', 'Exit from your account',
                  FeatherIcons.logOut, appBlack,(){logoutPopup(context);}),
            ],
          ),
        ),
      ),
    );
  }
 void volunteerApi(String status)async{
    VolunteerStatusRequest request=VolunteerStatusRequest(
      userId: Preferences.getUserId().toString(),
      volunteer: status,
      volunteerAri: selectedAri,
    );


   volunteerController.volunteerApi(request).then((value){

     final String json = jsonEncode(request.toJson());
     debugPrint("request body ${json}");

     if(value!=null){
       if(value.status==true){
         userDetailsApi();
         CustomLoader.message(value.message.toString());
       }
     }
   });
 }

}
