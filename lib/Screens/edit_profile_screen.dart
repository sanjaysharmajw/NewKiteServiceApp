
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/Models/user_details_models.dart';
import 'package:nirbhaya_service/Utils/custom_bottom_nav.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:nirbhaya_service/contoller/aws_controller_camera.dart';
import 'package:nirbhaya_service/contoller/pick_photo_controller.dart';
import 'package:nirbhaya_service/contoller/service_update_profile_controller.dart';
import 'package:nirbhaya_service/widgets/ImagePickerDialog.dart';
import '../Language/custom_text_input_formatter.dart';
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
  DateTime selectedDate = DateTime.now();
  int age = 0;
  var response_date = "";
  String date = "-";

  int genderId = 1;
  String radioButtonItem = 'Female';

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
      response_date=widget.userDetailsData.dob.toString();
      if (response_date.toString() == "null" ||
          response_date.toString().isEmpty) {
        var agedate =
        widget.userDetailsData.dob.toString().split('-');
        var date = agedate[0];
        agedate[1] = agedate[1];
        var month = (int.parse(agedate[1]) < 10
            ? '0${int.parse(agedate[1])}'
            : agedate[1]);
        var year = (int.parse(agedate[2]) < 10
            ? '0${int.parse(agedate[2])}'
            : agedate[2]);
        response_date = date + "-" + month + "-" + year;
      }
      updateProfileController.selectDobController.value.text= response_date;

      updateProfileController.firstNameController.value.text=widget.userDetailsData.firstName.toString();
      updateProfileController.lastNameController.value.text=widget.userDetailsData.lastName.toString();
      updateProfileController.mobileController.value.text=widget.userDetailsData.mobileNumber.toString();
      updateProfileController.emailController.value.text=widget.userDetailsData.emailId.toString();
      updateProfileController.addressController.value.text=widget.userDetailsData.address.toString();
      updateProfileController.emergencyController.value.text=widget.userDetailsData.emergencyContactNo.toString();
      updateProfileController.selectDobController.value.text =widget.userDetailsData.dob??"";
      radioButtonItem=widget.userDetailsData.gender.toString();
      if (radioButtonItem == 'Female') {
        genderId = 1;
      }
      if (radioButtonItem == 'Male') {
        genderId = 2;
      }
      if (radioButtonItem == 'Other') {
        genderId = 3;
      }
      print(radioButtonItem);
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
                         MyText(text: 'UpdateProfile'.tr, fontName: 'Gilroy',
                            fontSize: 20, fontWeight: FontWeight.w800, textColor: appBlack),
                        const SizedBox(height: 25),

                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'first_name'.tr, controller: updateProfileController.firstNameController.value,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "enter_first_name".tr;
                              }else{
                                return null;
                              }
                            }, fontSize: 16, readOnly: false, onTap: () {  },
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            engHindFormatter,
                            //FilteringTextInputFormatter.allow(
                              //  RegExp("[a-zA-Z\]")),
                            FilteringTextInputFormatter.deny('  '),
                          ], ),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'last_name'.tr, controller: updateProfileController.lastNameController.value,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "enter_last_name".tr;
                              }else{
                                return null;
                              }
                            }, fontSize: 16, readOnly: false, onTap: () {  },
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            engHindFormatter,
                            //FilteringTextInputFormatter.allow(
                              //  RegExp("[a-zA-Z\]")),
                            FilteringTextInputFormatter.deny('  '),
                          ], ),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'mobile_number'.tr, controller: updateProfileController.mobileController.value,
                            validator: (value) {
                              if (value.toString().length!=10) {
                                return "enter_mobile_number".tr;
                              }else{
                                return null;
                              }
                            }, fontSize: 16,readOnly: false, onTap: () {  },
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[0-9]")),
                            FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                            LengthLimitingTextInputFormatter(10),
                          ],),
                        const SizedBox(height: 25),
                        TextFormField(
                          showCursor: true,
                          cursorHeight:30,
                          cursorWidth: 2.0,
                          inputFormatters: [

                            FilteringTextInputFormatter.deny(' '),

                          ],
                          style:TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.w500,fontSize: 16),
                          controller: updateProfileController.emailController.value,
                          // textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black45)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: Colors.black54)),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty) {
                              return 'email_is_required !'.tr;
                            } if (
                            !RegExp(
                                r'^[a-z0-9]+@[a-z]+\.[a-z]')
                                .hasMatch(value)
                            // EmailValidator.validate(value)
                            ) {
                              return 'email_is_required !'.tr;
                            }
                            return null ;
                          },
                        ),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'address'.tr, controller: updateProfileController.addressController.value,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "enter_your_address".tr;
                              }else{
                                return null;
                              }
                            }, fontSize: 16,readOnly: false, onTap: () {  },
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.multiline,
                          inputFormatters: [
                            //engHindFormatter,
                            FilteringTextInputFormatter.allow(
                                RegExp("[0-9a-zA-Zऀ-ॿ'\.\-\s\,\ ]")),
                            FilteringTextInputFormatter.deny('  ')
                          ],),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'emergency_contact_number'.tr, controller: updateProfileController.emergencyController.value,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "enter_emergency_contact_number".tr;
                              }else{
                                return null;
                              }
                            }, fontSize: 16,readOnly: false, onTap: () { },
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[0-9]")),
                            FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                            LengthLimitingTextInputFormatter(10),
                          ],),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'select_DOB'.tr, controller: updateProfileController.selectDobController.value,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "select_dob".tr;
                              }else{
                                return null;
                              }
                            }, fontSize: 16,readOnly: true, onTap: () { showDialogPicker(context); },
                          textCapitalization: TextCapitalization.none,

                          keyboardType: TextInputType.text, inputFormatters: [],),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 30),
                      child:  MyText(text: 'select_gender'.tr, fontName: 'Gilroy',
                          fontSize: 16, fontWeight: FontWeight.w800, textColor: appBlack),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Radio(
                                fillColor:
                                MaterialStateColor.resolveWith(
                                        (states) => appBlack),
                                focusColor:
                                MaterialStateColor.resolveWith(
                                        (states) => appBlack),
                                value: 1,
                                groupValue: genderId, //=='female'?1:null,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItem = 'Female';
                                    genderId = 1;
                                  });
                                },
                              ),
                              Text(
                                "female".tr,
                                style: TextStyle(fontFamily: 'Gilroy',fontSize: 14)
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                fillColor:
                                MaterialStateColor.resolveWith(
                                        (states) => appBlack),
                                focusColor:
                                MaterialStateColor.resolveWith(
                                        (states) => appBlack),
                                value: 2,
                                groupValue: genderId, //=='male'?2:radioButtonItem,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItem = 'Male';
                                    genderId = 2;
                                  });
                                },
                              ),
                              Text(
                                "male".tr,
                                style: TextStyle(fontFamily: 'Gilroy',fontSize: 14)
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                fillColor:
                                MaterialStateColor.resolveWith(
                                        (states) => appBlack),
                                focusColor:
                                MaterialStateColor.resolveWith(
                                        (states) => appBlack),
                                value: 3,
                                groupValue:  genderId, //=='other'?3:radioButtonItem,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItem = 'Other';
                                    genderId = 3;
                                  });
                                },
                              ),
                              Text(
                                "other".tr,
                                style: TextStyle(fontFamily: 'Gilroy',fontSize: 14)
                              ),
                            ],
                          )
                        ],
                      ),
                      /*Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(

                            child: RadioListTile(
                              contentPadding: EdgeInsets.only(left: 10),

                            title:  Text("male".tr,style: TextStyle(fontFamily: 'Gilroy',fontSize: 14)),
                            value: "male",
                            activeColor: appBlue,
                            groupValue: gender,
                            onChanged: (value){
                              setState(() {
                                gender = value.toString();
                              });
                            },
                          ),),

                          Expanded(

                              child: RadioListTile(
                                contentPadding: EdgeInsets.only(left: 10),
                            //visualDensity: const VisualDensity(horizontal: -4),
                            title:  Text("female".tr,style: TextStyle(fontFamily: 'Gilroy',fontSize: 14)),
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
                            contentPadding: EdgeInsets.only(left: 10),
                            title: Text("other".tr,style: TextStyle(fontFamily: 'Gilroy',fontSize: 14)),
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
                      ),*/
                    ),
                  ],
                ),
                MyButton(press: () {
                  if(formKey.currentState!.validate()){
                    var agedate = updateProfileController.selectDobController.value.text.toString().split('-');
                    var year = agedate[2];
                    var month = (int.parse(agedate[1]) < 10 ? '0' +
                        int.parse(agedate[1]).toString() : agedate[1]);
                    var date = (int.parse(agedate[0]) < 10 ? '0' +
                        int.parse(agedate[0]).toString() : agedate[0]);

                    // print(DateTime.parse(agedate[2]+"-"+'0'+agedate[1].padLeft(1, '0')+"-"+agedate[0].padLeft(1, '0'))); // 2020-01-02 00:00:00.000


                    int age = calculateAge(DateTime.parse(year + "-" + month + "-" + date));

                    if (age < 18) {
            CustomLoader.message("Invalid Age, Age should be greater than 18 years");
            return null;
            }
            else {

              updateProfileApi(radioButtonItem.toString());
              print("UpdateGender: "+radioButtonItem.toString());
            }
                  }
                }, buttonText: 'update'.tr),
              ],
            );
          })
        ),
      ),
    ));
  }

  showDialogPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}-${picked.toLocal().month}-${picked.toLocal().year}";
        updateProfileController.selectDobController.value.text = date;
        calculateAge(picked);
      });
    }
  }

  /*showDialogPicker(BuildContext context){
    final DateTime? picked = showDatePicker(
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
        updateProfileController.selectDobController.value.text=date;
        calculateAge();
      });
    }, onError: (error) {
      CustomLoader.message(error);
    });
  }*/

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
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
