
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nirbhaya_service/Screens/home_page.dart';
import 'package:nirbhaya_service/Utils/preference.dart';
import 'package:nirbhaya_service/api_constant.dart';
import 'package:nirbhaya_service/contoller/aws_controller.dart';
import 'package:nirbhaya_service/widgets/images_set.dart';
import '../Utils/loader.dart';
import '../color_constant.dart';
import '../widgets/MyText.dart';
import '../widgets/MyTextFieldForm.dart';
import '../widgets/button.dart';

class ServiceRegDocumentScreen extends StatefulWidget {
  const ServiceRegDocumentScreen({Key? key}) : super(key: key);

  @override
  State<ServiceRegDocumentScreen> createState() => _ServiceRegDocumentScreenState();
}

class _ServiceRegDocumentScreenState extends State<ServiceRegDocumentScreen> with SingleTickerProviderStateMixin{
  final uploadDocController=TextEditingController();
  final formKey = GlobalKey<FormState>();
  final controllerAws = Get.put(AwsController());
  late AnimationController loadingController;

  File? _file;
  PlatformFile? _platformFile;
  String? stringRandomNumber;
  bool? visibleButton=false;
  String? userId,token;

  selectFile() async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom,

        allowedExtensions: ['png', 'jpg', 'jpeg']
    );

    if (file != null) {
      visibleButton=true;
      setState(() {
        _file = File(file.files.single.path!);
        _platformFile = file.files.first;
      });
    }else{
      visibleButton=false;
    }

    loadingController.forward();
  }

  @override
  void initState() {
    sharePreferences();
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() { setState(() {
    }); });

    Random random = Random();
    int randomNumber = random.nextInt(1000000);
    stringRandomNumber = randomNumber.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: Image.asset('assets/back_icons.png',width: 17,height: 17)),
                    const SizedBox(height: 25),
                    const MyText(text: 'Service Upload Document', fontName: 'Gilroy',
                        fontSize: 20, fontWeight: FontWeight.w800, textColor: appBlack),
                  ],
                ),
              ),

              GestureDetector(
                onTap: selectFile,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: const [10, 4],
                      strokeCap: StrokeCap.round,
                      color: appBlue,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                            color: appLightBlue,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            ImageSets(imagePath: 'assets/upload_icons.png', width: 30, height: 50, color: appBlack),
                            Text('Upload your file here', style: TextStyle(fontSize: 14, color: appBlack,fontFamily: 'Gilroy')),
                            SizedBox(height: 10),
                            Text('Browse', style: TextStyle(fontSize: 15, color: appBlack,fontFamily: 'Gilroy',fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    )
                ),
              ),
              _platformFile != null
                  ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Selected File',style: TextStyle(fontSize: 16, color: appBlack,fontFamily: 'Gilroy')),
                      const SizedBox(height: 10,),
                      Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  offset: const Offset(0, 1),
                                  blurRadius: 3,
                                  spreadRadius: 2,
                                )
                              ]
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(_file!, width: 70,)
                              ),
                              const SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_platformFile!.name,style: const TextStyle(fontSize: 14, color: appBlack,fontFamily: 'Gilroy')),
                                    const SizedBox(height: 5,),
                                    Text('${(_platformFile!.size / 1024).ceil()} KB',
                                      style: const TextStyle(fontSize: 14, color: appBlack,fontFamily: 'Gilroy'),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                        height: 5,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.blue.shade50,
                                        ),
                                        child: LinearProgressIndicator(
                                          color: appBlue,
                                          value: loadingController.value,
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10,),
                            ],
                          )
                      ),
                      const SizedBox(height: 20,),
                    ],
                  ))
                  : Container(),
              Visibility(
                visible: visibleButton!,
                child: MyButton(press: () {
                  if(formKey.currentState!.validate()){
                    awsImageApi(stringRandomNumber! +_platformFile!.name);
                  }
                }, buttonText: 'Submit'),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void awsImageApi(String imagePath)async{
    await controllerAws.awsUpload(imagePath).then((value) async {
      if (value != null) {
        if (value.status == true) {
          CustomLoader.showToast('Successful');
          awsUploadFinal(value.data.toString());
        }
      }
    });
  }

  Future<http.Response?> awsUploadFinal(path) async {
    try {
      CustomLoader.showLoader("Please wait");
      final response = await http.put(
        Uri.parse(path),
        body: await _file!.readAsBytes(),
      );
      if (response.statusCode == 200) {
        CustomLoader.closeLoader();
        String? imageFilePath = APIConstant.awsImagePathUrl + stringRandomNumber! +_platformFile!.name;
        updateDocument(imageFilePath);
      }
    } on TimeoutException catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.message.toString());
    }  catch (e) {
      CustomLoader.closeLoader();
      CustomLoader.showToast(e.toString());
    }
    return null;
  }

  void updateDocument(String imagePath)async{
    await controllerAws.updateDocument(userId!,uploadDocController.text.toString(),imagePath,token.toString()).then((value) async {
      if (value != null) {
        if (value.status == true) {
          CustomLoader.showToast('Upload Successful');
          Get.to(const HomePage());
        }
      }
    });
  }

  void sharePreferences()async{
    await Preferences.setPreferences();
    userId=Preferences.getUserId();
    token=Preferences.getToken();
  }

}
