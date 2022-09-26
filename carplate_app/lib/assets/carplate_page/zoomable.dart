import 'dart:io' as Io;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Zoomable extends StatelessWidget {

  final String imgUrl;

  const Zoomable({Key? key ,required this.imgUrl}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    //print('$imgUrl');


    return Container(

        child: SingleChildScrollView(

          child: SizedBox(
              width: 500.0,
              height: 500.0,
              child: PhotoView(
                //imageProvider: NetworkImage('http://twowayiot.com:8082/api/image/640/21341.jpg'),
                imageProvider: MemoryImage(base64Decode(imgUrl)),
              )
          ),
        )
    );

  }
}
