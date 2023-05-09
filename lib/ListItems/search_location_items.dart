
import 'package:flutter/material.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';
import 'package:nirbhaya_service/widgets/images_set.dart';

import '../Models/search_location_model.dart';

class SearchLocationItems extends StatelessWidget {
  final SearchLocationModel searchLocationModel;
  final VoidCallback click;
  const SearchLocationItems({Key? key, required this.searchLocationModel, required this.click}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 15,right: 15),
      child: InkWell(
        onTap: click,
        child: Column(
          children: [
            const SizedBox(
                height: 10
            ),
            Row(
              children:  [
                const ImageSets(imagePath: 'assets/location_pin.png', width: 30, height: 30, color: appWhiteColor),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/1.5,
                        child: Text(searchLocationModel.text.toString(),
                          style: const TextStyle(fontFamily: 'Gilroy',fontSize: 16,fontWeight: FontWeight.w700,color: appWhiteColor)),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
                height: 10
            ),
            const Divider(
              color: appLightGrey,
            ),
          ],
        ),
      ),
    );
  }
}
