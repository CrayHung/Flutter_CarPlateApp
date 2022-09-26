import 'package:flut_camera_pages/assets/black_list/black_list.dart';
import 'package:flut_camera_pages/assets/carplate_page/carplate_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'assets/blankPage/blankPage.dart';
import 'assets/cameraPage/cameraPage.dart';
import 'assets/historyPage/historyPage.dart';

import 'assets/carplate_page/get_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp(post: fetchPost()));
  //runApp(const MyApp(post:fetchPost()));
}

class MyApp extends StatefulWidget {
  final Future<List> post;
  const MyApp({Key? key, required this.post}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyAppExt());
  }
} // 本體呼叫內部 MyAppExt 並去除 debug

class MyAppExt extends StatefulWidget {
  MyAppExt({Key? key}) : super(key: key);

  @override
  State<MyAppExt> createState() => _MyAppExtState();
}

class _MyAppExtState extends State<MyAppExt> {
  int currentIndex = 0; // Index 初始值
  String appbarTitleString = "APP TEST01";
  var appBarTitleText = new Text("APP TEST HOMEPAGE");

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: appBarTitleText
      ),
      body: Center(
          child: currentIndex == 0
              ? CarPlatePage()
              : currentIndex == 1
                  ?  CameraPage()
                  : currentIndex == 2
                      ? const HistoryPage()
                      : currentIndex == 3
                          ? BlackList()
                          : BlankPage()),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.car_rental,
              ),
              label: '車牌辨識'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.camera_alt,
              ),
              label: '拍照辨識'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: '歷史搜尋'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.map,
              ),
              label: '黑名單'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: '設定'),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
            if (index == 0) {
              appbarTitleString = "車牌辨識";
              appBarTitleText = Text(appbarTitleString);
            } else if (index == 1) {
              appbarTitleString = "拍照辨識";
              appBarTitleText = Text(appbarTitleString);
            } else if (index == 2) {
              appbarTitleString = "歷史搜尋";
              appBarTitleText = Text(appbarTitleString);
            } else if (index == 3) {
              appbarTitleString = "黑名單";
              appBarTitleText = Text(appbarTitleString);

              //     return TextField(
              //   cursorColor: Colors.white,
              //   decoration: InputDecoration(
              //       hintText: " Search...",
              //       border: InputBorder.none,
              //       suffixIcon: IconButton(
              //         icon: Icon(Icons.search),
              //         color: Color.fromRGBO(93, 25, 72, 1),
              //         onPressed: () {},
              //       )),
              //   style: TextStyle(color: Colors.white, fontSize: 15.0),
              // ),

            } else if (index == 4) {
              appbarTitleString = "設定";
              appBarTitleText = Text(appbarTitleString);
            }
          });
        },
      ),
    );
  }
}
