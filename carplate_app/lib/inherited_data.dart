import 'package:flutter/material.dart';


/*
class InheritedData extends InheritedWidget{

  const InheritedData({Key? key, required this.imgUrl , required Widget child}) : super(key: key, child: child);
  final String imgUrl;
  //新增一個of方法,讓要使用inheritedData的widget更方便就能呼叫使用
  static String of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedData>()!.imgUrl;
  //return context.dependOnInheritedWidgetOfExactType<InheritedData>().imgUrl;


  @override
  //將新數據和舊數據比較,如果新資料有變動,則重繪依賴於此widget的畫面
  bool updateShouldNotify(InheritedData oldWidget) {
    return oldWidget.imgUrl != imgUrl;
  }

}

*/
class InheritedData extends InheritedWidget{

  const InheritedData({Key? key, required this.post , required Widget child}) : super(key: key, child: child);
  final Future post;
  //新增一個of方法,讓要使用inheritedData的widget更方便就能呼叫使用
  static Future of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedData>()!.post;
  //return context.dependOnInheritedWidgetOfExactType<InheritedData>().imgUrl;


  @override
  //將新數據和舊數據比較,如果新資料有變動,則重繪依賴於此widget的畫面
  bool updateShouldNotify(InheritedData oldWidget) {
    return oldWidget.post != post;
  }

}
