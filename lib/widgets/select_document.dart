
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nirbhaya_service/Screens/home_page.dart';
import '../color_constant.dart';
import '../widgets/MyText.dart';
import '../widgets/MyTextFieldForm.dart';
import '../widgets/button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final fullNameController=TextEditingController();
  final mobileController=TextEditingController();
  final emailController=TextEditingController();
  final addressController=TextEditingController();
  final emergencyController=TextEditingController();
  final selectDobController=TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? gender;


  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      body: Container(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(25),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        InkWell(child: Image.asset('assets/back_icons.png',width: 17,height: 17)),
                        const SizedBox(height: 25),
                        const MyText(text: 'Registration', fontName: 'Gilroy',
                            fontSize: 20, fontWeight: FontWeight.w800, textColor: appWhiteColor),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'Full Name', controller: fullNameController,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Enter Full Name";
                              }else{
                                return null;
                              }
                            }, fontSize: 16,readOnly: false, onTap: () {  },
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
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
                            }, fontSize: 16,readOnly: false, onTap: () {  },
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.number,
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
                            }, fontSize: 16,readOnly: false, onTap: () {  },
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.emailAddress,
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
                            }, fontSize: 16,readOnly: false, onTap: () {  },
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text, inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[A-Za-z0-9'\.\-\s\,\ ]")),
                            FilteringTextInputFormatter.deny('  ')
                          ],),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'Emergency Number', controller: emergencyController,
                            validator: (value) {
                              if (value.toString().length!=10) {
                                return "Enter Your Emergency Contact Number";
                              }else{
                                return null;
                              }
                            }, fontSize: 16,readOnly: false, onTap: () {  },
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.number, inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                            LengthLimitingTextInputFormatter(10),
                          ],),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'Select DOB', controller: selectDobController,
                            validator: (value) {
                              if (value.toString().length!=10) {
                                return "Enter 10 digits Mobile Number";
                              }else{
                                return null;
                              }
                            }, fontSize: 16,readOnly: false, onTap: () {  },
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text, inputFormatters: [],),
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
                          fontSize: 16, fontWeight: FontWeight.w800, textColor: appWhiteColor),
                    ),
                    const SizedBox(height: 10),
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
                  // if(formKey.currentState!.validate()){
                  Get.to(const HomePage());
                  // }
                }, buttonText: 'NEXT'),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
