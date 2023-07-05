import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:nirbhaya_service/Screens/select_location.dart';
import 'package:nirbhaya_service/Screens/upload_document.dart';
import 'package:nirbhaya_service/Utils/tools.dart';
import '../Models/search_location_model.dart';
import '../Utils/loader.dart';
import '../color_constant.dart';
import '../contoller/place_details_controller.dart';
import '../widgets/MyText.dart';
import '../widgets/MyTextFieldForm.dart';
import '../widgets/button.dart';
import '../widgets/muy_textfield_with_icon.dart';

class ServiceRegistration extends StatefulWidget {
  const ServiceRegistration({Key? key}) : super(key: key);

  @override
  State<ServiceRegistration> createState() => _ServiceRegistrationState();
}

class _ServiceRegistrationState extends State<ServiceRegistration> {
  final fullNameController=TextEditingController();
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
                        const MyText(text: 'Add Service', fontName: 'Gilroy',
                            fontSize: 20, fontWeight: FontWeight.w800, textColor: appWhiteColor),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'Shop Name', controller: fullNameController,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "Enter Shop Name";
                            }else{
                              return null;
                            }
                          }, fontSize: 16, readOnly: false, onTap: () {  },
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z\]")),
                            FilteringTextInputFormatter.deny('  '),
                          ],),
                        const SizedBox(height: 25),
                        MyTextFieldWithIcon(hintText: 'Address', controller: addressController,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "Enter Your Address";
                            }else{
                              return null;
                            }
                          }, fontSize: 16, click: () async{
                            //sendSelectLocationScreen(context);
                            // bottomSheet(context);
                          },
                        ),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'Select Service', controller: emergencyController,
                          validator: (value) {
                            if (value.toString().length!=10) {
                              return "Select Service";
                            }else{
                              return null;
                            }
                          }, fontSize: 16,readOnly: false, onTap: () {  },
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text, inputFormatters: [],),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'Registration Number', controller: emergencyController,
                          validator: (value) {
                            if (value.toString().length!=10) {
                              return "Enter Your Registration Number";
                            }else{
                              return null;
                            }
                          }, fontSize: 16,readOnly: false, onTap: () {  }, keyboardType: TextInputType.number, textCapitalization: TextCapitalization.words,
                          inputFormatters: [],),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'Work Timing (To)', controller: emergencyController,
                          validator: (value) {
                            if (value.toString().length!=10) {
                              return "Enter Your Registration Number";
                            }else{
                              return null;
                            }
                          }, fontSize: 16,readOnly: false, onTap: () {  }, keyboardType: TextInputType.text, inputFormatters: [], textCapitalization: TextCapitalization.words,),
                        const SizedBox(height: 25),
                        MyTextFieldForm(hintText: 'Work Timing (From)', controller: emergencyController,
                          validator: (value) {
                            if (value.toString().length!=10) {
                              return "Enter Your Registration Number";
                            }else{
                              return null;
                            }
                          }, fontSize: 16,readOnly: false, onTap: () {  },
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text, inputFormatters: [],),
                        const SizedBox(height: 25),

                      ],
                    ),
                  ),
                ),

                MyButton(press: () {
                  // if(formKey.currentState!.validate()){
                  Get.to(const UploadDocumentScreen());
                  // }
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

}

