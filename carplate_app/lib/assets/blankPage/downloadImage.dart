import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';

class Data{
  String carPlate;
  String ExpiredDate;
  Data(this.carPlate,this.ExpiredDate);
}


class BlankPage extends StatelessWidget {

  String url= 'https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?auto=compress&cs=tinysrgb&w=600';
  String url2= 'https://en.pimg.jp/058/783/297/1/58783297.jpg';

  @override
  Widget build(BuildContext context)=>Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.network(url2),
        const SizedBox(height: 30),
        ElevatedButton(
          child: const Text('download'),
          onPressed: ()async{

            await GallerySaver.saveImage(url);
          },
        ),

      ],

    ),


  );
}

