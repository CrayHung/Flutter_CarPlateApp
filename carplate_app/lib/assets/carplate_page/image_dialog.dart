import 'package:flutter/material.dart';
import 'zoomable.dart';

class ImageDialog extends StatelessWidget {

  final String img;
  const ImageDialog({Key? key ,required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Dialog(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            //Text('路口.日期...'),
            Zoomable(imgUrl: img),
            //Zoomable(imgUrl),
            //Text('車號...'),

          ],
        ),


      ),
    );
  }

}