import 'package:flutter/material.dart';
import 'package:nirbhaya_service/Models/video_list_models.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';

class VideoItems extends StatelessWidget {
  final VideoData videoData;
  const VideoItems({Key? key, required this.videoData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
