import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/Screens/select_location.dart';
import 'package:nirbhaya_service/Screens/upload_document.dart';
import 'package:nirbhaya_service/Utils/preference.dart';
import 'package:nirbhaya_service/Utils/tools.dart';
import '../Language/custom_text_input_formatter.dart';
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
  final addressController=TextEditingController();
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
  int id = 1;
  String radioButtonItem = 'Female';

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
                        MyTextFieldForm(labelText: 'First Name', controller: firstNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return value.length < 3 ? 'Name must be greater than two characters' : null;
                          }, fontSize: 16, readOnly: false, onTap: () {  },
                          textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z\ ]")),
                            FilteringTextInputFormatter.deny('  '),
                          ],),
                        const SizedBox(height: 25),
                        MyTextFieldForm(labelText: 'Last Name', controller: lastNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return value.length < 3 ? 'Name must be greater than two characters' : null;
                          },fontSize: 16, readOnly: false, onTap: () {  },
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z\ ]")),
                            FilteringTextInputFormatter.deny('  '),
                          ], ),
                        const SizedBox(height: 25),
                        MyTextFieldForm(labelText: 'Mobile Number', controller: mobileController,
                            validator: (value) {
                              if (value.toString().length!=10) {
                                return "Enter 10 digits Mobile Number";
                              }else{
                                return null;
                              }
                            }, fontSize: 16,readOnly: false, onTap: () {  },
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.deny(' '),
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
                          controller: emailController,

                          // textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email Id',
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
                        MyTextFieldForm(labelText: 'Address', controller: addressController,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "Enter Your Address";
                            }else{
                              return null;
                            }
                          }, fontSize: 16,readOnly: false, onTap: () {  },
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.multiline,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[A-Za-z0-9'\.\-\s\,\ ]")),
                            FilteringTextInputFormatter.deny('  ')

                          ], ),
                        const SizedBox(height: 25),
                        MyTextFieldForm(
                          labelText: 'Emergency Contact Number', controller: emergencyController,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Enter Your Emergency Contact Number";
                              }else{
                                return null;
                              }
                            }, fontSize: 16,readOnly: false, onTap: () { }, keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                            LengthLimitingTextInputFormatter(10),

                            FilteringTextInputFormatter.deny(' '),
                          ], textCapitalization: TextCapitalization.none,

                        ),
                        const SizedBox(height: 25),
                        MyTextFieldForm(labelText: 'Select DOB', controller: selectDobController,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Enter your date of birth";
                              }else{
                                return null;
                              }
                            }, fontSize: 16,readOnly: true, onTap: () { showDialogPicker(context); }, keyboardType: TextInputType.text, inputFormatters: [], textCapitalization: TextCapitalization.none,),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            children: [
                              Radio(
                                fillColor: MaterialStateColor.resolveWith(
                                        (states) => appBlue),
                                focusColor:
                                MaterialStateColor.resolveWith(
                                        (states) => appBlue),
                                value: 1,
                                groupValue: id,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItem = 'Female';
                                    id = 1;
                                  });
                                },
                              ),
                              Text(
                                'Female',
                                style: TextStyle(fontSize: 16,fontFamily: 'Gilroy'),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                fillColor: MaterialStateColor.resolveWith(
                                        (states) => appBlue),
                                focusColor:
                                MaterialStateColor.resolveWith(
                                        (states) => appBlue),
                                value: 2,
                                groupValue: id,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItem = 'Male';
                                    id = 2;
                                  });
                                },
                              ),
                              Text(
                                'Male',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Gilroy'
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children:[
                              Radio(
                                fillColor: MaterialStateColor.resolveWith(
                                        (states) => appBlue),
                                focusColor:
                                MaterialStateColor.resolveWith(
                                        (states) => appBlue),
                                value: 3,
                                groupValue: id,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItem = 'Other';
                                    id = 3;
                                  });
                                },
                              ),
                              Text(
                                'Other',
                                style: TextStyle(fontSize: 16,fontFamily: 'Gilroy'),
                              ),
                            ],
                          )



                        ],
                      ),
                    ],
                  ),

                  MyButton(press: () {
                    if(formKey.currentState!.validate()) {
                      var agedate =
                      selectDobController.text.toString().split('-');
                      var year = agedate[2];
                      var month = (int.parse(agedate[1]) < 10
                          ? '0' + int.parse(agedate[1]).toString()
                          : agedate[1]);
                      var date = (int.parse(agedate[0]) < 10
                          ? '0' + int.parse(agedate[0]).toString()
                          : agedate[0]);
                      int age = calculateAge(DateTime.parse(
                          year + "-" + month + "-" + date));
                      if (age < 18) {
                        Get.snackbar("Invalid Age",
                            "Age should be greater than 18 years");
                        return null;
                      } else {
                        registrationOtp(
                            firstNameController.text,
                            lastNameController.text,
                            mobileController.text,
                            emailController.text,
                            addressController.text,
                            emergencyController.text,
                            selectDobController.text,
                            radioButtonItem.toString());
                      }
                    }
                  }, buttonText: 'NEXT'),
                ],
              ),
            ),
          ),
        ),
    ));
  }

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    var age = currentDate.year - birthDate.year;
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
    //print("age cal: $age");
    //Preferences.setAge(age);
    return age;
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
      firstDate: DateTime(1947),
      lastDate: DateTime.now(),
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
          Preferences.setToken(value.data![0].logintoken.toString());
          Preferences.setFirstName(value.data![0].firstName.toString());

          Get.to(const UploadDocumentScreen());
        }else{
          CustomLoader.showToast('Error');
        }
      }
    });
  }
}

