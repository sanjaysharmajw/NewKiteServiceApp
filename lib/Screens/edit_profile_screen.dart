
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/Models/user_details_models.dart';
import 'package:nirbhaya_service/Utils/custom_bottom_nav.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:nirbhaya_service/contoller/aws_controller_camera.dart';
import 'package:nirbhaya_service/contoller/pick_photo_controller.dart';
import 'package:nirbhaya_service/contoller/service_update_profile_controller.dart';
import 'package:nirbhaya_service/widgets/ImagePickerDialog.dart';
import '../Utils/loader.dart';
import '../Utils/tools.dart';
import '../color_constant.dart';
import '../widgets/MyText.dart';
import '../widgets/MyTextFieldForm.dart';
import '../widgets/button.dart';

class EditProfileScreen extends StatefulWidget {
  UserDetailsData userDetailsData;
  EditProfileScreen({super.key,required this.userDetailsData});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {

  final formKey = GlobalKey<FormState>();
  final updateProfileController=Get.put(ServiceUpdateProfileController());
  final pickImageController=Get.put(PickPhotoController());
  final awsComtrollerCamera=Get.put(AwsControllerComera());
  String? gender;
  String? address;
  String? imageFilePath="", stringRandomNumber;

  String resultData="";
  late Future<DateTime?> selectedDate;
  String date = "-";

  @override
  void initState() {
    super.initState();
    setState(() {
      getDetailsProfile();
      Random random = Random();
      int randomNumber = random.nextInt(1000000);
      stringRandomNumber = randomNumber.toString();
    });
  }

  void getDetailsProfile()async{
    setState(() {
      updateProfileController.firstNameController.value.text=widget.userDetailsData.firstName.toString();
      updateProfileController.lastNameController.value.text=widget.userDetailsData.lastName.toString();
      updateProfileController.mobileController.value.text=widget.userDetailsData.mobileNumber.toString();
      updateProfileController.emailController.value.text=widget.userDetailsData.emailId.toString();
      updateProfileController.addressController.value.text=widget.userDetailsData.permanentAddress!.address.toString();
      updateProfileController.emergencyController.value.text=widget.userDetailsData.emergencyContactNo.toString();
      updateProfileController.selectDobController.value.text=widget.userDetailsData.dob.toString();
      gender=widget.userDetailsData.gender.toString();

    });
  }


  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Obx((){
            return Column(
              children: [
                Padding(padding: const EdgeInsets.all(25),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell( onTap: (){
                          Get.back();
                        },child: Image.asset('assets/back_icons.png',width: 17,height: 17)),
                        const SizedBox(height: 25),
                        const MyText(text: 'Update Profile', fontName: 'Gilroy',
                            fontSize: 20, fontWeight: FontWeight.w800, textColor: appBlack),
                        const SizedBox(height: 25),
                        // Column(
                        //   children: [
                        //     Center(
                        //       child: Stack(
                        //         clipBehavior: Clip.none,
                        //         children:  [
                        //           InkWell(
                        //             onTap: (){
                        //               // Get.to(const EditProfileScreen());
                        //               _showDialog();
                        //             },
                        //             child: const ClipRRect(
                        //               clipBehavior: Clip.antiAliasWithSaveLayer,
                        //               borderRadius: BorderRadius.all(Radius.circular(60)),
                        //               child: Image(
                        //                 height: 100,
                        //                 width: 100,
                        //                 image: AssetImage('images/car.jpg'),
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ),
                        //           const Positioned(
                        //             bottom: 0,
                        //             right: 0,
                        //             child: FxCard(
                        //               paddingAll: 2,
                        //               borderRadiusAll: 4,
                        //               clipBehavior: Clip.none,
                        //               child: FxContainer(
                        //                 paddingAll: 4,
                        //                 borderRadiusAll: 4,
                        //                 color:appBlue,
                        //                 child: Icon(
                        //                   Icons.camera_alt,
                        //                   size: 16,
                        //                   color: appWhiteColor,
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     FxSpacing.height(20),
                        //     Text("${widget.userDetailsData.firstName.toString()}\n${widget.userDetailsData.lastName.toString()}",
                        //         textAlign: TextAlign.center,
                        //         style: const TextStyle(
                        //           fontSize: 18,
                        //           fontWeight: FontWeight.w700,
                        //           color: appBlack,fontFamily: 'Gilroy',
                        //         ))
                        //   ],
                        // ),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'First Name', controller: updateProfileController.firstNameController.value,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Enter your first name";
                              }else{
                                return null;
                              }
                            }, fontSize: 16, readOnly: false, onTap: () {  }, keyboardType: TextInputType.text),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'Last Name', controller: updateProfileController.lastNameController.value,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Enter your last name";
                              }else{
                                return null;
                              }
                            }, fontSize: 16, readOnly: false, onTap: () {  }, keyboardType: TextInputType.text),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'Mobile Number', controller: updateProfileController.mobileController.value,
                            validator: (value) {
                              if (value.toString().length!=10) {
                                return "Enter 10 digits Mobile Number";
                              }else{
                                return null;
                              }
                            }, fontSize: 16,readOnly: false, onTap: () {  }, keyboardType: TextInputType.text),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'Email ID', controller: updateProfileController.emailController.value,
                            validator: (value) {
                              Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                              RegExp regex = RegExp(pattern as String);
                              if (!regex.hasMatch(value)) {
                                return 'Please enter a valid email address.';
                              } else {
                                return null;
                              }
                            }, fontSize: 16,readOnly: false, onTap: () {  }, keyboardType: TextInputType.text),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'Address', controller: updateProfileController.addressController.value,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Enter Your Address";
                              }else{
                                return null;
                              }
                            }, fontSize: 16,readOnly: false, onTap: () {  }, keyboardType: TextInputType.text),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'Emergency Contact Number', controller: updateProfileController.emergencyController.value,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Enter Your Emergency Contact Number";
                              }else{
                                return null;
                              }
                            }, fontSize: 16,readOnly: false, onTap: () { }, keyboardType: TextInputType.text),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'Select DOB', controller: updateProfileController.selectDobController.value,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Enter 10 digits Mobile Number";
                              }else{
                                return null;
                              }
                            }, fontSize: 16,readOnly: true, onTap: () { showDialogPicker(context); }, keyboardType: TextInputType.text),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 30),
                      child:  MyText(text: 'Select Gender', fontName: 'Gilroy',
                          fontSize: 16, fontWeight: FontWeight.w800, textColor: appBlack),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: RadioListTile(
                            title: const Text("Male",style: TextStyle(fontFamily: 'Gilroy',fontSize: 14)),
                            value: "male",
                            activeColor: appBlue,
                            groupValue: gender,
                            onChanged: (value){
                              setState(() {
                                gender = value.toString();
                              });
                            },
                          ),),
                          Expanded(child: RadioListTile(
                            visualDensity: const VisualDensity(horizontal: -4),
                            title: const Text("Female",style: TextStyle(fontFamily: 'Gilroy',fontSize: 14)),
                            value: "female",
                            groupValue: gender,
                            activeColor: appBlue,
                            onChanged: (value){
                              setState(() {
                                gender = value.toString();
                              });
                            },
                          )),
                          Expanded(child: RadioListTile(
                            title: const Text("Other",style: TextStyle(fontFamily: 'Gilroy',fontSize: 14)),
                            value: "other",
                            groupValue: gender,
                            activeColor: appBlue,
                            onChanged: (value){
                              setState(() {
                                gender = value.toString();
                              });
                            },
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
                MyButton(press: () {
                  if(formKey.currentState!.validate()){
                    updateProfileApi(gender.toString());
                  }
                }, buttonText: 'Update'),
              ],
            );
          })
        ),
      ),
    ));
  }
  void showDialogPicker(BuildContext context){
    selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );
    selectedDate.then((value) {
      setState(() {
        if(value == null) return;
        date = Tools.getFormattedDateSimple(value.millisecondsSinceEpoch);
        updateProfileController.firstNameController.value.text=date;
      });
    }, onError: (error) {
      CustomLoader.message(error);
    });
  }
  void updateProfileApi(String gender)async{
    updateProfileController.updateProfile(gender).then((value){
      if(value!=null){
          if(value.status==true){
            CustomLoader.message(value.message.toString());
            Get.to(const CustomBottomNav());
          }else{
            CustomLoader.message(value.message.toString());
          }
      }
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => ImagePickDialogBox(
          cameraClick: () async {
            await pickImageController.pickImageCamera();
            if (pickImageController.imagePath.isNotEmpty) {
              imageFilePath = APIConstant.awsImagePathUrl +
                  stringRandomNumber! +
                  pickImageController.imagePath.toString();
              awsImageApi(stringRandomNumber! +
                  pickImageController.imagePath.toString());
            }
            setState(() {

            });
            Navigator.pop(context);
          },
          galleryClick: () async {
            await pickImageController.pickImageGallery();
            if (pickImageController.imagePath.isNotEmpty) {
              imageFilePath = APIConstant.awsImagePathUrl +
                  stringRandomNumber! +
                  pickImageController.imagePath.toString();
              awsImageApi(stringRandomNumber! +
                  pickImageController.imagePath.toString());
            }
            setState(() {

            });
            Navigator.pop(context);
          },
        ));
  }

  void awsImageApi(String imagePath) async {
    await awsComtrollerCamera.awsUpload(imagePath).then((value) async {
      if (value != null) {
        if (value.status == true) {
          await awsComtrollerCamera.awsUploadFinal(value.data.toString(), pickImageController.imageFile!);
        }
      }
    });
  }
}
