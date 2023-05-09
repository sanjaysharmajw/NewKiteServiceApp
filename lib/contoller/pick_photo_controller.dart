import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PickPhotoController extends GetxController{

  RxString imagePath="".obs;
  File? imageFile;

  Future<void> pickImageGallery() async {
    final XFile? images = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (images != null) {
      imageFile = File(images.path);
      imagePath.value = imageFile!.path.split(Platform.pathSeparator).last;
    }
  }

  Future<void> pickImageCamera() async {
    final XFile? images = await ImagePicker().pickImage(source: ImageSource.camera);
    if (images != null) {
      imageFile = File(images.path);
      imagePath.value = imageFile!.path.split(Platform.pathSeparator).last;
    }
  }

}
