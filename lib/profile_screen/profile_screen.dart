
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutx/flutx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nirbhaya_service/BodyRequest/user_details_request_body.dart';
import 'package:nirbhaya_service/BodyRequest/volunteer_request.dart';
import 'package:nirbhaya_service/Screens/about_us_screen.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/chat_bot/ChatScreen.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/contoller/user_details_controller.dart';
import 'package:nirbhaya_service/contoller/volunteer_select_controller.dart';
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
  final userDetailsController=Get.put(UserDetailsController());
  String? volunteer;


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
   setState(() {});
   debugPrint("volunteer $volunteer");
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
               MyText(text: 'Profile'.tr, fontName: 'Gilroy',
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

              _buildSingleSetting('Profile'.tr, 'UpdateProfile'.tr,
                  FeatherIcons.messageCircle, appBlack,(){
                    Get.to(EditProfileScreen(userDetailsData: userDetailsController.getUserDetailsData[0]));
                  }),

              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSingleSetting('volunteer'.tr, 'would_you_like_to_volunteer?'.tr,
                      FeatherIcons.user, appBlack,(){
                        // buildLanguageDialog(context);
                      }),
                  FlutterSwitch(
                    width: 60.0,
                    height: 30.0,
                    value: volunteer=="Yes"?true:volunteer=="No"?false:false,
                    borderRadius: 30.0,
                    padding: 5.0,
                    activeColor: blackColor,
                    onToggle: (val) {
                      setState(() {
                        volunteerStatus = val;
                        if(volunteerStatus==true){
                          volunteerApi("Yes");
                        }else{
                          volunteerApi("No");
                        }

                      });
                    },
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
              _buildSingleSetting('help'.tr, 'contact_us'.tr,
                  FeatherIcons.messageCircle, appBlack,(){
                  Get.to(const ChatScreen());
                  }),
              const Divider(),
              _buildSingleSetting('about'.tr, 'about_the_application'.tr,
                  FeatherIcons.alertCircle, appBlack,(){
                Get.to(const AboutUsScreen());
                  }),
              const Divider(),
              _buildSingleSetting('log_out'.tr, 'exit_from_your_account'.tr,
                  FeatherIcons.logOut, appBlack,(){logoutPopup(context);}),
            ],
          ),
        ),
      ),
    );
  }
 void volunteerApi(String status)async{
    VolunteerRequest request=VolunteerRequest(
      userId: Preferences.getUserId().toString(),
      volunteer: status
    );
   volunteerController.volunteerApi(request).then((value){
     if(value!=null){
       if(value.status==true){
         userDetailsApi();
         CustomLoader.message(value.message.toString());
       }
     }
   });
 }

}
