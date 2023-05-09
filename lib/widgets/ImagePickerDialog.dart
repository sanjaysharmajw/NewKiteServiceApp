
import 'package:flutter/material.dart';
import 'package:nirbhaya_service/color_constant.dart';

class ImagePickDialogBox extends StatelessWidget {
  final VoidCallback cameraClick;
  final VoidCallback galleryClick;
  const ImagePickDialogBox({Key? key, required this.cameraClick, required this.galleryClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: appWhiteColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  <Widget>[
             const Text('Choose Images',style: TextStyle(
                fontFamily: 'Gilroy',color: appBlack,fontWeight: FontWeight.w600,fontSize: 20
              )),

              const SizedBox(height: 5),
              const Divider(),
              Padding(
                padding:  const EdgeInsets.only(top: 10,bottom: 20),
                child:  InkWell(
                    onTap: cameraClick, child:   const Text('Choose Images',style: TextStyle(
                    fontFamily: 'Gilroy',color: appBlack,fontWeight: FontWeight.w600,fontSize: 20
                )),
              ),
              ),

              InkWell(
                  onTap: galleryClick, child:
              const Text('Choose Images',style: TextStyle(
                  fontFamily: 'Gilroy',color: appBlack,fontWeight: FontWeight.w600,fontSize: 20
              )),
              ),


            ],
          ),
        ),
      ),
    );
  }

}
