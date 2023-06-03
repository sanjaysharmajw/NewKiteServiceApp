import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/Screens/select_location.dart';
import 'package:nirbhaya_service/Screens/upload_document.dart';
import 'package:nirbhaya_service/Utils/preference.dart';
import 'package:nirbhaya_service/Utils/tools.dart';
import '../Models/search_location_model.dart';
import '../Utils/loader.dart';
import '../color_constant.dart';
import '../contoller/loginController.dart';
import '../contoller/place_details_controller.dart';
import '../widgets/MyText.dart';
import '../widgets/MyTextFieldForm.dart';
import '../widgets/button.dart';
import '../widgets/muy_textfield_with_icon.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final firstNameController=TextEditingController();
  final lastNameController=TextEditingController();
  final mobileController=TextEditingController();
  final emailController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  final emergencyController=TextEditingController();
  final selectDobController=TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? gender;
  String? address;
  List<SearchLocationModel> searchLocation = [];
  final controller = Get.put(PlaceDetailsController());
  String resultData="";
  late Future<DateTime?> selectedDate;
  String date = "-";
  final apiController = Get.put(SendOtpController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
        body: Container(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(padding: const EdgeInsets.all(25),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        InkWell( onTap: (){
                          Get.back();
                        },child: Image.asset('assets/back_icons.png',width: 17,height: 17)),
                        const SizedBox(height: 25),
                        const MyText(text: 'Registration', fontName: 'Gilroy',
                            fontSize: 20, fontWeight: FontWeight.w800, textColor: appBlack),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'First Name', controller: firstNameController,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Enter your first name";
                              }else{
                                return null;
                              }
                            }, fontSize: 16, readOnly: false, onTap: () {  },
                            keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z\]")),
                            FilteringTextInputFormatter.deny('  '),
                          ],),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'Last Name', controller: lastNameController,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "Enter your last name";
                            }else{
                              return null;
                            }
                          }, fontSize: 16, readOnly: false, onTap: () {  }, keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z\]")),
                            FilteringTextInputFormatter.deny('  '),
                          ],),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'Mobile Number', controller: mobileController,
                            validator: (value) {
                              if (value.toString().length!=10) {
                                return "Enter 10 digits Mobile Number";
                              }else{
                                return null;
                              }
                            }, fontSize: 16,readOnly: false, onTap: () {  }, keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                            LengthLimitingTextInputFormatter(10),
                          ],),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'Email ID', controller: emailController,
                            validator: (value) {
                              Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                              RegExp regex = RegExp(pattern as String);
                              if (!regex.hasMatch(value)) {
                                return 'Please enter a valid email address.';
                              } else {
                                return null;
                              }
                            }, fontSize: 16,readOnly: false, onTap: () {  }, keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny('  '),

                          ],),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'Address', controller: addressController,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "Enter Your Address";
                            }else{
                              return null;
                            }
                          }, fontSize: 16,readOnly: false, onTap: () {  }, keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[A-Za-z0-9'\.\-\s\,\ ]")),
                            FilteringTextInputFormatter.deny('  ')

                          ],),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'Emergency Contact Number', controller: emergencyController,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Enter Your Emergency Contact Number";
                              }else{
                                return null;
                              }
                            }, fontSize: 16,readOnly: false, onTap: () { }, keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                            LengthLimitingTextInputFormatter(10),
                          ],),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'Select DOB', controller: selectDobController,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Enter your date of birth";
                              }else{
                                return null;
                              }
                            }, fontSize: 16,readOnly: true, onTap: () { showDialogPicker(context); }, keyboardType: TextInputType.text, inputFormatters: [],),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                  ),

              Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     const Padding(
                        padding:  EdgeInsets.only(left: 20),
                        child:  MyText(text: 'Select Gender', fontName: 'Gilroy',
                            fontSize: 16, fontWeight: FontWeight.w800, textColor: Colors.black87),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(child: RadioListTile(
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
                          Flexible(child: RadioListTile(
                            contentPadding: EdgeInsets.only(right: 5),
                            visualDensity: VisualDensity(horizontal: -4),
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
                          Flexible(child: RadioListTile(
                            contentPadding: EdgeInsets.only(right: 5),
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
                    ],
                  ),

                  MyButton(press: () {
                    if(formKey.currentState!.validate()){
                     registrationOtp(firstNameController.text, lastNameController.text, mobileController.text,
                         emailController.text, addressController.text, emergencyController.text, selectDobController.text, gender.toString());
                    }
                  }, buttonText: 'NEXT'),
                ],
              ),
            ),
          ),
        ),
    ));
  }

  void placeDetailsApi(String placeId)async{
    await controller.placeDetailsApi(placeId).then((value) async {
      if (value != null) {
        if (value.status == true) {
          addressController.text = value.result![0].label.toString();
        }
      }
    });
  }
  // void sendSelectLocationScreen(BuildContext context) async {
  //   final result = await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const SelectLocationScreen(),
  //       ));
  //   setState(() {
  //     resultData = result;
  //     placeDetailsApi(resultData);
  //   });
  // }

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
        selectDobController.text=date;
      });
    }, onError: (error) {
      CustomLoader.message(error);
    });
  }
  void registrationOtp(String firstName,String lastName,String mobile,String email,String address,
      String emergencyNo,String dob,String gender)async{
    await apiController.registration(firstName, lastName, mobile, email,
        address, emergencyNo, dob, gender).then((value) async {
      if (value != null) {
        if (value.status == true) {
          CustomLoader.showToast('Registration Successful');
          await Preferences.setPreferences();
          Preferences.setUserId(value.data![0].id.toString());
          Preferences.setMobileNo(value.data![0].mobileNumber.toString());
          Get.to(const UploadDocumentScreen());
        }else{
          CustomLoader.showToast('Error');
        }
      }
    });
  }
}

