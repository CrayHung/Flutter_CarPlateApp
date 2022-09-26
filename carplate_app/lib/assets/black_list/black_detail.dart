import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'black_list.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;

import 'package:share_plus/share_plus.dart';
import 'dart:io';

class BlackDetail extends StatelessWidget{
  //final BlackItem blackItem;




  const BlackDetail({Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context){
    print('列出詳細資料');
    //接收black_list傳過來的參數
    final task = ModalRoute.of(context)!.settings.arguments as BlackItem;
    return Scaffold(
     //appBar: AppBar(title: Text('車號'+ task.carPlate),),
      body: Column(
        children: [
          Image.network('https://en.pimg.jp/058/783/297/1/58783297.jpg', height: 300,),
          SizedBox(
            height: 10,
          ),
          Text(task.carPlate,style: TextStyle(fontSize: 30),),
          Text(task.expiredDate),

        ],

      ),
      //floatingActionButton: buildBackButton(context),

      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_arrow,
        children: [

          //share
          SpeedDialChild(
            child: Icon(Icons.mail),
            backgroundColor: Colors.white,
            label: 'share',
            onTap: () async{
              final urlImage = 'https://en.pimg.jp/058/783/297/1/58783297.jpg';
              //Share.share(task.carPlate);
              //Share.shareFiles(['${directory.path}/1.jpg'], text: 'Great picture');

              final url = Uri.parse(urlImage);
              final response = await http.get(url);
              final bytes = response.bodyBytes;

              final temp = await getTemporaryDirectory();
              final path = '${temp.path}/${task.carPlate}.jpg';
              File(path).writeAsBytesSync(bytes);

              await Share.shareFiles([path] , text: '${task.carPlate}');

            },
          ),

          //返回black_list
          SpeedDialChild(
            child: Icon(Icons.turn_left),
            backgroundColor: Colors.green,
            onTap: () {
              Navigator.pushNamed(context, '/black_list');
            },
          ),
        ],
      ),


    );
  }
}

//floatingButton功能( 返回上一頁...如果要返回到指定頁面也可以 )
Widget buildBackButton(BuildContext context) =>
    FloatingActionButton(
      child: Icon(Icons.turn_left),
      backgroundColor: Colors.green,
      onPressed: () {
        Navigator.pop(context, '返回');
      },
    );
