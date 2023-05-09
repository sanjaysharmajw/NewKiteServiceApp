
import 'package:flutter/material.dart';
import 'package:nirbhaya_service/color_constant.dart';
class HomePageItems2 extends StatelessWidget {
  final String text;
  final String textValue;
  final VoidCallback click;
  const HomePageItems2({Key? key, required this.text, required this.textValue, required this.click}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: click,
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width/.5,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(textValue,style: const TextStyle(
                                  fontSize: 18,fontFamily: 'Gilroy',fontWeight: FontWeight.w600
                              )),
                              const SizedBox(height: 8),
                              Text(text,style: const TextStyle(
                                  fontSize: 16,fontFamily: 'Gilroy'
                              )),
                            ],
                          ),
                          Image.asset('assets/forword.png',width: 25,height: 25)
                        ],
                      ),



                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
