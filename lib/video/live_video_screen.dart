
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/BodyRequest/video_request.dart';
import 'package:nirbhaya_service/Utils/loader.dart';
import 'package:nirbhaya_service/contoller/video_list_controller.dart';
import 'package:nirbhaya_service/items_screen/video_items.dart';
import 'package:nirbhaya_service/utils_screens/empty_screen.dart';

class LiveVideoScreen extends StatefulWidget {
  String? status;
  LiveVideoScreen({Key? key,this.status}) : super(key: key);

  @override
  State<LiveVideoScreen> createState() => _LiveVideoScreenState();
}

class _LiveVideoScreenState extends State<LiveVideoScreen> {
  final videoController = Get.put(VideoListController());

  @override
  void initState() {
    super.initState();
    videoApi();

  }
  void videoApi()async{
    VideoRequest request=VideoRequest(
        type: widget.status,
        userType: "Rider"
    );
    await videoController.videoListApi(request);
  }

  Future<void> _refresh(){

    if (widget.status != null) {
      videoApi();
    }
    return Future.delayed(Duration(seconds: 2));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children:  [
            Expanded(
              child: Obx(() {
                return videoController.isLoading.value
                    ? CustomLoader.loader()
                    : videoController.getVideoListData.isEmpty
                    ? const Center(
                  child: EmptyScreen(text: 'Video Not Found'),
                ) :
                RefreshIndicator(
                  onRefresh: _refresh,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: (3 / 4),
                    shrinkWrap: true,
                    children: List.generate(videoController.getVideoListData.length, (index) {
                      return VideoItems(videoData: videoController.getVideoListData[index]);
                    }),
                  ),
                );
              }),
            ),

          ],
        ),
      ),
    );
  }
}
