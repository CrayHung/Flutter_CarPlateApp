import 'dart:io';
import 'package:flutter/cupertino.dart';
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
      children: [
        Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Center(
                child:
                Column(
                  children: [
                    Text('圖片'),
                    ElevatedButton(
                        onPressed: (){ },
                        child: Text('選擇'),
                    ),
                  ],
                ),
              ),

            ),
        ),


        Expanded(
          flex: 4,
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.5),
              borderRadius: BorderRadius.circular(50.0),

            ),
            child: Center(
              child:
              Column(
                children: [
                  Text('影片'),
                  ElevatedButton(
                    onPressed: (){},
                    child: Text('選擇'),
                  ),
                ],
              ),
            ),

          ),
        ),


        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(20.0),
            //margin: EdgeInsets.all(20.0),
            color: Colors.red,
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: (){},
                  icon: Icon(Icons.format_list_bulleted),
                  label: Text('歷史查詢'),
                ),
                Text('顯示ID'),
              ],
            ),
          ),
        ),
      ],
    ),
    );







}

