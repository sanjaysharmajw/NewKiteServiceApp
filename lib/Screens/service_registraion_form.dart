import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nirbhaya_service/BodyRequest/add_service_request_body.dart';
import 'package:nirbhaya_service/BodyRequest/service_list_body_request.dart';
import 'package:nirbhaya_service/Models/days_model.dart';
import 'package:nirbhaya_service/Utils/custom_bottom_nav.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/Utils/preference.dart';
import 'package:nirbhaya_service/contoller/add_service_controller.dart';
import 'package:nirbhaya_service/contoller/update_add_service_list.dart';
import 'package:nirbhaya_service/contoller/user_service_list_controller.dart';
import 'package:nirbhaya_service/widgets/my_button_without_padding.dart';
import '../BodyRequest/update_service_list_request_body.dart';
import '../Language/custom_text_input_formatter.dart';
import '../Utils/DataProvider.dart';
import '../Utils/custom_theme.dart';
import '../Utils/theme.dart';
import '../color_constant.dart';
import '../widgets/MyText.dart';
import '../widgets/MyTextFieldForm.dart';
import 'package:get/get.dart';
import '../widgets/button.dart';

class ServiceRegistrationForm extends StatefulWidget {
  String serviceId,action,serviceName;
  Placemark placemark;
  LatLng latLng;
  ServiceRegistrationForm(
      {Key? key,
      required this.serviceId,
      required this.placemark,
      required this.latLng,
      required this.action,
      required this.serviceName,
      })
      : super(key: key);

  @override
  State<ServiceRegistrationForm> createState() =>
      _ServiceRegistrationFormState();
}

class _ServiceRegistrationFormState extends State<ServiceRegistrationForm> {
  final addServiceController = Get.put(AddServiceController());
  final updateAddServiceController = Get.put(UpdateAddServiceController());
  final userServiceListController = Get.put(UserServiceListController());
  AddServiceRequestBody? request;
  UpdateServiceListRequestBody? updateRequest;
  TimeOfDay selectedTime = TimeOfDay.now();

  String? buttonValue;

  final formKey = GlobalKey<FormState>();

  bool sundayCheckBox = false;
  bool mondayCheckBox = false;
  bool tuesdayCheckBox = false;
  bool wednesdayCheckBox = false;
  bool thursdayCheckBox = false;
  bool fridayCheckBox = false;
  bool saturdayCheckBox = false;

  // List<DaysModel> _selectedDays = [];
  List<String> selectedDays = [];

  late ThemeData theme;
  late CustomTheme customTheme;

  @override
  void initState() {
    super.initState();
    if(widget.action=="Edit"){
      serviceDetails();
      buttonValue="update".tr;
    }else if(widget.action=="Add"){
      buttonValue="submit".tr;
    }

    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
  }
  void serviceDetails()async{
    Preferences.setPreferences();
    String? serviceId=Preferences.getServiceId();
    String? id=Preferences.getServiceListId();
    ServiceListBodyRequest request =ServiceListBodyRequest(
        userId: Preferences.getUserId().toString(),
        lat: widget.latLng.latitude,
        lng: widget.latLng.longitude,
        serviceId: serviceId.toString(),
        id: id.toString()
    );
    await userServiceListController.getUserServiceList(request);
    addServiceController.registrationNoController.value.text=userServiceListController.getUserServiceListData[0].registrationNumber.toString();
    addServiceController.shopNameController.value.text=userServiceListController.getUserServiceListData[0].title.toString();
    addServiceController.contactPersonNoController.value.text=userServiceListController.getUserServiceListData[0].contactPerson.toString();
    addServiceController.contactPersonNameController.value.text=userServiceListController.getUserServiceListData[0].contactPersonName.toString();
    addServiceController.pinCodeController.value.text=userServiceListController.getUserServiceListData[0].pincode.toString();
    addServiceController.cityController.value.text=userServiceListController.getUserServiceListData[0].city.toString();
    addServiceController.stateController.value.text=userServiceListController.getUserServiceListData[0].state.toString();
    addServiceController.addressController.value.text=userServiceListController.getUserServiceListData[0].address.toString();
    addServiceController.workingToController.value.text=userServiceListController.getUserServiceListData[0].avaibility!.availableTimeTo.toString();
    addServiceController.workingFromController.value.text=userServiceListController.getUserServiceListData[0].avaibility!.availableTimeFrom.toString();
    bool? sun=userServiceListController.getUserServiceListData[0].avaibility!.avaibilityDays!.sunday;
    bool? mon=userServiceListController.getUserServiceListData[0].avaibility!.avaibilityDays!.monday;
    bool? tues=userServiceListController.getUserServiceListData[0].avaibility!.avaibilityDays!.tuesday;
    bool? wed=userServiceListController.getUserServiceListData[0].avaibility!.avaibilityDays!.wednesday;
    bool? thur=userServiceListController.getUserServiceListData[0].avaibility!.avaibilityDays!.thursday;
    bool? fri=userServiceListController.getUserServiceListData[0].avaibility!.avaibilityDays!.friday;
    bool? sat=userServiceListController.getUserServiceListData[0].avaibility!.avaibilityDays!.saturday;
    if(sun==true){
      sundayCheckBox=true;
      selectedDays.add('Sunday');
    } if(mon==true){
      mondayCheckBox=true;
      selectedDays.add('Monday');
    } if(tues==true){
      tuesdayCheckBox=true;
      selectedDays.add('Tuesday');
    } if(wed==true){
      wednesdayCheckBox=true;
      selectedDays.add('Wednesday');
    } if(thur==true){
      thursdayCheckBox=true;
      selectedDays.add('Thursday');
    } if(fri==true){
      fridayCheckBox=true;
      selectedDays.add('Friday');
    }  if(sat==true){
      saturdayCheckBox=true;
      selectedDays.add('Saturday');
    }
    setState(() {
      addServiceController.selectWorkingDayController.value.text = selectedDays.join(', ');
    });
  }

  void requestBodyApi() {
    request = AddServiceRequestBody(
      userId: Preferences.getUserId().toString(),
      serviceId: widget.serviceId.toString(),
      serviceName: widget.serviceName.toString(),
      registrationNumber:
          addServiceController.registrationNoController.value.text.trim(),
      title: addServiceController.shopNameController.value.text.trim(),
      address: addServiceController.addressController.value.text.trim(),
      city: addServiceController.cityController.value.text.trim(),
      state: addServiceController.stateController.value.text.trim(),
      contactPersonName:
          addServiceController.contactPersonNameController.value.text.trim(),
      pincode: addServiceController.pinCodeController.value.text.trim(),
      contactPerson:
          addServiceController.contactPersonNoController.value.text.trim(),
      addressDetails: AddressDetails(
        lat: widget.latLng.latitude,
        lng: widget.latLng.longitude,
        label: widget.placemark.subAdministrativeArea,
        postalCode: widget.placemark.postalCode,
        subRegion: widget.placemark.locality,
        municipality: widget.placemark.subLocality,
        neighborhood: widget.placemark.subLocality,
      ),
      avaibility: Avaibility(
          avaibilityDays: AvaibilityDays(
            sunday: sundayCheckBox,
            monday: mondayCheckBox,
            tuesday: tuesdayCheckBox,
            wednesday: wednesdayCheckBox,
            thursday: thursdayCheckBox,
            friday: fridayCheckBox,
            saturday: saturdayCheckBox,
          ),
          availableTimeTo:
              addServiceController.workingToController.value.text.toString(),
          availableTimeFrom:
              addServiceController.workingFromController.value.text
                ..toString()),
    );
  }
  void requestUpdateBodyApi() {
    updateRequest = UpdateServiceListRequestBody(
      id: userServiceListController.getUserServiceListData[0].id.toString(),
      serviceId: widget.serviceId.toString(),
      serviceName: widget.serviceName.toString(),
      registrationNumber:
          addServiceController.registrationNoController.value.text.trim(),
      title: addServiceController.shopNameController.value.text.trim(),
      address: addServiceController.addressController.value.text.trim(),
      city: addServiceController.cityController.value.text.trim(),
      state: addServiceController.stateController.value.text.trim(),
      contactPersonName:
          addServiceController.contactPersonNameController.value.text.trim(),
      pincode: addServiceController.pinCodeController.value.text.trim(),
      contactPerson:
          addServiceController.contactPersonNoController.value.text.trim(),
      addressDetails: UpdateAddressDetails(
        lat: widget.latLng.latitude,
        lng: widget.latLng.longitude,
        label: widget.placemark.subAdministrativeArea,
        postalCode: widget.placemark.postalCode,
        subRegion: widget.placemark.locality,
        municipality: widget.placemark.subLocality,
        neighborhood: widget.placemark.subLocality,
      ),
      avaibility: AvaibilityUpdate(
          avaibilityDays: UpdateAvaibilityDays(
            sunday: sundayCheckBox,
            monday: mondayCheckBox,
            tuesday: tuesdayCheckBox,
            wednesday: wednesdayCheckBox,
            thursday: thursdayCheckBox,
            friday: fridayCheckBox,
            saturday: saturdayCheckBox,
          ),
          availableTimeTo:
              addServiceController.workingToController.value.text.toString(),
          availableTimeFrom:
              addServiceController.workingFromController.value.text
                ..toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          //resizeToAvoidBottomInset: true,
      body: Container(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Image.asset('assets/back_icons.png',
                                width: 17, height: 17)),
                        const SizedBox(height: 25),
                         MyText(
                            text: 'service_form'.tr,
                            fontName: 'Gilroy',
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            textColor: appBlack),
                        const SizedBox(height: 25),
                        MyTextFieldForm(
                            hintText: 'shop_name'.tr,
                            controller:
                                addServiceController.shopNameController.value,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "enter_shop_name".tr;
                              } else {
                                return null;
                              }
                            },
                            fontSize: 16,
                            readOnly: false,
                            onTap: () {},
                            keyboardType: TextInputType.text, inputFormatters: [
                          engHindFormatter,
                         // FilteringTextInputFormatter.allow(
                           //   RegExp("[a-zA-Z\]")),
                          FilteringTextInputFormatter.deny('  '),
                        ],),
                        const SizedBox(height: 25),
                        MyTextFieldForm(
                            hintText: 'contact_person_name'.tr,
                            controller: addServiceController
                                .contactPersonNameController.value,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "enter_contact_person_name".tr;
                              } else {
                                return null;
                              }
                            },
                            fontSize: 16,
                            readOnly: false,
                            onTap: () {},
                            keyboardType: TextInputType.text, inputFormatters: [
                          engHindFormatter,
                         // FilteringTextInputFormatter.allow(
                           //   RegExp("[a-zA-Z\]")),
                          FilteringTextInputFormatter.deny('  '),
                        ],),
                        const SizedBox(height: 25),
                        MyTextFieldForm(
                            hintText: 'contact_person_number'.tr,
                            controller: addServiceController
                                .contactPersonNoController.value,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "enter_contact_number".tr;
                              } else {
                                return null;
                              }
                            },
                            fontSize: 16,
                            readOnly: false,
                            maxLength: 10,
                            onTap: () {},
                            keyboardType: TextInputType.number, inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                          LengthLimitingTextInputFormatter(10),
                        ],),
                        const SizedBox(height: 25),
                        MyTextFieldForm(
                            hintText: 'pincode'.tr,
                            controller:
                                addServiceController.pinCodeController.value,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "enter_pincode".tr;
                              } else {
                                return null;
                              }
                            },
                            fontSize: 16,
                            readOnly: false,
                            maxLength: 6,
                            onTap: () {},
                            keyboardType: TextInputType.number, inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[0-9]")),
                          FilteringTextInputFormatter.deny(' '),
                          LengthLimitingTextInputFormatter(6),
                        ],),
                        const SizedBox(height: 25),
                        MyTextFieldForm(
                            hintText: 'city'.tr,
                            controller:
                                addServiceController.cityController.value,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "enter_city".tr;
                              } else {
                                return null;
                              }
                            },
                            fontSize: 16,
                            readOnly: false,
                            onTap: () {},
                            keyboardType: TextInputType.text, inputFormatters: [
                          engHindFormatter,
                          //FilteringTextInputFormatter.allow(
                             // RegExp("[a-zA-Z\]")),
                          FilteringTextInputFormatter.deny('  '),
                        ],),
                        const SizedBox(height: 25),
                        MyTextFieldForm(
                            hintText: 'state'.tr,
                            controller:
                                addServiceController.stateController.value,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "enter_state".tr;
                              } else {
                                return null;
                              }
                            },
                            fontSize: 16,
                            readOnly: false,
                            onTap: () {},
                            keyboardType: TextInputType.text, inputFormatters: [
                          engHindFormatter,
                         // FilteringTextInputFormatter.allow(
                           //   RegExp("[a-zA-Z\]")),
                          FilteringTextInputFormatter.deny('  '),
                        ],),
                        const SizedBox(height: 25),
                        MyTextFieldForm(
                            hintText: 'address'.tr,
                            controller:
                                addServiceController.addressController.value,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "enter_address".tr;
                              } else {
                                return null;
                              }
                            },
                            fontSize: 16,
                            readOnly: false,
                            onTap: () {},
                            keyboardType: TextInputType.text, inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[0-9a-zA-Zऀ-ॿ'\.\-\s\,\ ]")),
                          FilteringTextInputFormatter.deny('  ')

                        ],),
                        const SizedBox(height: 25),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: MyTextFieldForm(
                                  hintText: 'working_from'.tr,
                                  controller: addServiceController
                                      .workingFromController.value,
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "select_time".tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                  fontSize: 16,
                                  readOnly: true,
                                  onTap: () {
                                    selectTime(context, 1);
                                  },
                                  keyboardType: TextInputType.text, inputFormatters: [

                              ],),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: MyTextFieldForm(
                                  hintText: 'working_to'.tr,
                                  controller: addServiceController
                                      .workingToController.value,
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "select_time".tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                  fontSize: 16,
                                  readOnly: true,
                                  onTap: () {
                                    selectTime(context, 2);
                                  },
                                  keyboardType: TextInputType.text, inputFormatters: [],),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        MyTextFieldForm(
                            hintText: 'select_working_day'.tr,
                            controller: addServiceController
                                .selectWorkingDayController.value,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "select_working_day".tr;
                              } else {
                                return null;
                              }
                            },
                            fontSize: 16,
                            readOnly: true,
                            onTap: () {
                              mCornerBottomSheet(context);
                            },
                            keyboardType: TextInputType.text, inputFormatters: [],),
                        const SizedBox(height: 25),
                        MyTextFieldForm(
                            hintText: 'registration_no'.tr,
                            controller: addServiceController
                                .registrationNoController.value,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "enter_reg_num".tr;
                              } else {
                                return null;
                              }
                            },
                            fontSize: 16,
                            readOnly: false,
                            onTap: () {},
                            keyboardType: TextInputType.text, inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          FilteringTextInputFormatter.deny('  '),
                        ],),
                      ],
                    ),
                  ),
                ),
                MyButton(
                    press: () async {
                      if (formKey.currentState!.validate()) {

                        if(widget.action=="Edit"){
                          requestUpdateBodyApi();
                          await updateAddServiceController
                              .addUpdateServiceListApi(updateRequest!)
                              .then((value) {
                            if (value != null) {
                              if (value.status == true) {
                                CustomLoader.message(value.message.toString());
                                Get.to(const CustomBottomNav());
                              } else {
                                CustomLoader.message(value.message.toString());
                              }
                            }
                          });
                        }else if(widget.action=="Add"){
                          requestBodyApi();
                          await addServiceController
                              .addServiceListApi(request!)
                              .then((value) {
                            if (value != null) {
                              if (value.status == true) {
                                CustomLoader.message(value.message.toString());
                                Get.to(const CustomBottomNav());
                              } else {
                                CustomLoader.message(value.message.toString());
                              }
                            }
                          });
                        }
                      }
                    },
                    buttonText: buttonValue!),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  mCornerBottomSheet(BuildContext aContext) {
    showModalBottomSheet(
      context: aContext,
      backgroundColor: appWhiteColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
      builder: (builder) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) => Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: Column(
                      children: [
                        const MyText(
                            text: 'Select Working Days',
                            fontName: 'Gilroy',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            textColor: appBlack),
                        5.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const MyText(
                                text: 'Sunday',
                                fontName: 'Gilroy',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                textColor: appBlack),
                            Checkbox(
                              onChanged: (v) {
                                setState(() => sundayCheckBox = v!);
                                if (sundayCheckBox == true) {
                                  selectedDays.add('Sunday');
                                } else {
                                  selectedDays.remove("Sunday");
                                }
                              },
                              value: sundayCheckBox,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const MyText(
                                text: 'Monday',
                                fontName: 'Gilroy',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                textColor: appBlack),
                            Checkbox(
                              onChanged: (v) {
                                setState(() => mondayCheckBox = v!);
                                if (mondayCheckBox == true) {
                                  selectedDays.add('Monday');
                                } else {
                                  selectedDays.remove("Monday");
                                }
                              },
                              value: mondayCheckBox,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const MyText(
                                text: 'Tuesday',
                                fontName: 'Gilroy',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                textColor: appBlack),
                            Checkbox(
                              onChanged: (v) {
                                setState(() => tuesdayCheckBox = v!);
                                if (tuesdayCheckBox == true) {
                                  selectedDays.add('Tuesday');
                                } else {
                                  selectedDays.remove("Tuesday");
                                }
                              },
                              value: tuesdayCheckBox,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const MyText(
                                text: 'Wednesday',
                                fontName: 'Gilroy',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                textColor: appBlack),
                            Checkbox(
                              onChanged: (v) {
                                setState(() => wednesdayCheckBox = v!);
                                if (wednesdayCheckBox == true) {
                                  selectedDays.add('Wednesday');
                                } else {
                                  selectedDays.remove("Wednesday");
                                }
                              },
                              value: wednesdayCheckBox,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const MyText(
                                text: 'Thursday',
                                fontName: 'Gilroy',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                textColor: appBlack),
                            Checkbox(
                              onChanged: (v) {
                                setState(() => thursdayCheckBox = v!);
                                if (thursdayCheckBox == true) {
                                  selectedDays.add('Thursday');
                                } else {
                                  selectedDays.remove("Thursday");
                                }
                              },
                              value: thursdayCheckBox,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const MyText(
                                text: 'Friday',
                                fontName: 'Gilroy',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                textColor: appBlack),
                            Checkbox(
                              onChanged: (v) {
                                setState(() => fridayCheckBox = v!);
                                if (fridayCheckBox == true) {
                                  selectedDays.add('Friday');
                                } else {
                                  selectedDays.remove("Friday");
                                }
                              },
                              value: fridayCheckBox,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const MyText(
                                text: 'Saturday',
                                fontName: 'Gilroy',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                textColor: appBlack),
                            Checkbox(
                              onChanged: (v) {
                                setState(() => saturdayCheckBox = v!);
                                if (saturdayCheckBox == true) {
                                  selectedDays.add('Saturday');
                                } else {
                                  selectedDays.remove("Saturday");
                                }
                              },
                              value: saturdayCheckBox,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: MyButtonPadding(
                        press: () {
                          Get.back();
                          addServiceController.selectWorkingDayController.value
                              .text = selectedDays.join(', ');
                        },
                        buttonText: 'Submit'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> selectTime(BuildContext context, int valueTime) async {
    TimeOfDay? picked = await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        if (valueTime == 1) {
          addServiceController.workingFromController.value.text =
              "${selectedTime.hour < 10 ? "0${selectedTime.hour}" : "${selectedTime.hour}"} : "
              "${selectedTime.minute < 10 ? "0${selectedTime.minute}" : "${selectedTime.minute}"} ${selectedTime.period != DayPeriod.am ? 'PM' : 'AM'}";
        } else if (valueTime == 2) {
          addServiceController.workingToController.value.text =
              "${selectedTime.hour < 10 ? "0${selectedTime.hour}" : "${selectedTime.hour}"} : "
              "${selectedTime.minute < 10 ? "0${selectedTime.minute}" : "${selectedTime.minute}"} ${selectedTime.period != DayPeriod.am ? 'PM' : 'AM'}";
        }
      });
    }
  }
}
