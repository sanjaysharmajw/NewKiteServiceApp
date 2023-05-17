import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/BodyRequest/video_attend_request.dart';
import 'package:nirbhaya_service/Models/video_list_models.dart';
import 'package:nirbhaya_service/Utils/preference.dart';
import 'package:nirbhaya_service/contoller/video_attend_controller.dart';
import 'package:nirbhaya_service/video/view_video_screen.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';

class VideoItems extends StatelessWidget {
  final VideoData videoData;
  const VideoItems({Key? key, required this.videoData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        attendVideo(videoData.id.toString());
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.network(videoData.thumbnelImage.toString()),
            ),
            const SizedBox(height: 10),
            MyText(
                text: videoData.name.toString(),
                fontName: 'Gilroy',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                textColor: Colors.black),
            const SizedBox(height: 10),
            MyText(
                text: videoData.description.toString(),
                fontName: 'Gilroy',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textColor: Colors.black),
          ],
        ),
      ),
    );
  }
  void attendVideo(String videoId)async{
    final videoAttendController =Get.put(VideoAttendController());
    VideoAttendRequest request =VideoAttendRequest(
      videoId: videoId,
      userId: Preferences.getUserId().toString()
    );
   await videoAttendController.videoAttendApi(request).then((value){
      if(value!=null){
        if(value.status==true){
          Get.to(ViewVideoList(videoData: videoData));
        }
      }
    });
  }
}
