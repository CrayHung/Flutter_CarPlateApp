import 'package:flutter/material.dart';
import 'byCarPlate.dart';
import 'byCCTVID.dart';


class HistoryPage extends StatelessWidget {


  const HistoryPage({Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(

      //路由選擇器(要再MaterialApp下面實作...) , 看要跳那些頁面這邊定義
      routes: {
        "/history_page": (context) => new HistoryPage(),
        "/ByCarPlate": (context) => new ByCarPlate(),
        "/ByCCTVID": (context) => new ByCCTVID(),

      },
      title: 'Demo',
      home: _HistoryPage(),
    );
  }
}
class _HistoryPage extends StatelessWidget{
  const _HistoryPage({Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Column(
          children: [

            Expanded(
             child:Container(
               child: DecoratedBox(
                 decoration: BoxDecoration(
                   image: DecorationImage(image: AssetImage("images/CAR.jpg"), fit: BoxFit.cover,opacity: 0.3),
                 ),
                 child: Center(
                     child:
                       GestureDetector(
                         onTap: ()  {
                           Navigator.pushNamed(context, '/ByCarPlate');
                         },
                         child:Text(
                           '車號搜尋',
                           style: TextStyle(fontSize: 50),
                         )
                       ),

                 ),
               ),
             ),
            ),

            Expanded(
              child:Container(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("images/CCTV.jpg"), fit: BoxFit.cover,opacity: 0.3),
                  ),
                  child: Center(
                      child:
                      GestureDetector(
                          onTap: ()  {
                            Navigator.pushNamed(context, '/ByCCTVID');
                          },
                          child:Text(
                            'CCTVID搜尋',
                            style: TextStyle(fontSize: 50),
                          )
                      ),
                  ),
                ),
              ),
            ),

              ],
            ),


    );
  }
}

