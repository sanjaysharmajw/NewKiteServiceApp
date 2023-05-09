

import 'package:flutter/material.dart';

class ImageSets extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final Color color;
  const ImageSets({Key? key, required this.imagePath, required this.width, required this.height, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath,width: width,height: height,color: color);
  }
}
