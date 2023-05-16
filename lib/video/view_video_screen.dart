

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/Models/video_list_models.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ViewVideoList extends StatefulWidget {
  VideoData? videoData;
  ViewVideoList({Key? key,this.videoData}) : super(key: key);

  @override
  State<ViewVideoList> createState() => _ViewVideoListState();
}

class _ViewVideoListState extends State<ViewVideoList> {
  YoutubePlayerController? playerController;
  @override
  void initState() {
    super.initState();
    youTubePlayer();
  }
  void youTubePlayer(){
    final videoId = YoutubePlayer.convertUrlToId(widget.videoData!.videoLink.toString());
    playerController = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
         // isLive: true,
          showLiveFullscreenButton: true,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Padding(
             padding: const EdgeInsets.only(left: 20,right: 20),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 const SizedBox(height: 25),
                 InkWell( onTap: (){
                   Get.back();
                 },child: Image.asset('assets/back_icons.png',width: 17,height: 17)),
                 const SizedBox(height: 25),
                 MyText(text: widget.videoData!.name.toString(), fontName: 'Gilroy',
                     fontSize: 20, fontWeight: FontWeight.w800, textColor: appBlack),
                 const SizedBox(height: 25),
               ],
             ),
           ),
            YoutubePlayer(
              controller: playerController!,
              showVideoProgressIndicator: true,
              onReady: () => debugPrint("ready"),
              bottomActions: [
                CurrentPosition(),
                const SizedBox(width: 10.0),
                ProgressBar(isExpanded: true),
                const SizedBox(width: 10.0),
                RemainingDuration(),
                FullScreenButton(),
               // PlayPauseButton(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  MyText(text: widget.videoData!.name.toString(), fontName: 'Gilroy',
                      fontSize: 16, fontWeight: FontWeight.w800, textColor: appBlack),
                  const SizedBox(
                    height: 5,
                  ),
                  MyText(text: widget.videoData!.description.toString(), fontName: 'Gilroy',
                      fontSize: 14, fontWeight: FontWeight.w500, textColor: appBlack),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
