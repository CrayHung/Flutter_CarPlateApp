import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'black_detail.dart';
import 'add_black.dart';




class BlackList extends StatelessWidget {
  BlackList({Key? key}) : super(key: key);




  @override
  //call _BlackList + 定義route
  Widget build(BuildContext context) {
    return new MaterialApp(

      //路由選擇器(要再MaterialApp下面實作...) , 看要跳那些頁面這邊定義
      routes: {
        //Map<String, WidgetBuilder>
        "/black_list": (context) => new _BlackList(),
        "/black_detail": (context) => new BlackDetail(),
        "/add_black": (context) => new AddBlack(),

      },
      title: 'Demo',
      home: _BlackList(),
    );
  }
}
class _BlackList extends StatefulWidget{


  @override
  State<_BlackList> createState() => _BlackListState();
}


class _BlackListState extends State<_BlackList> {


  void deleteBlack(context){
    print('要刪除的資料是');
    print(context);
    final inde=context;
    Future<http.Response> deleteBlackCarToDB() async{

      var url = 'http://twowayiot.com:8077/api/SetBlackList';
      var body =
      {
        'Token': '12345',
        "CarInfos":[
          {
            'CarPlate': inde,
            "DataStatus": "D"
          }
        ],
      };
      final response = await http.post(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body:jsonEncode(body)
      );
      if(response.statusCode==200){
        print('刪除成功');
      }else{
        print('刪除失敗');
      }

      return response;
    }
    deleteBlackCarToDB();


  }




  //fetch data in DB
  Future<List<BlackItem>> _fetchBLPost() async {
    var ip = dotenv.env['CARPLATE_SERVER_IP'];
    var url = 'http://' + ip! + '/api/CheckBlackList';
    var body = jsonEncode(
        {'ExpiredDate': '2022-08-22 00:00:00.000', 'Token': '12345'});
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      var parsed =
      json.decode(response.body)['blacklistInfos'] as List<dynamic>;
       //all_black_data = parsed;
      return parsed.map((p) => BlackItem.fromJson(p)).toList();

      // return Future.delayed(Duration(seconds: 1),
      //     ()=> parsed.map((p) => BlackItem.fromJson(p)).toList()
      // );

    } else {
      throw Exception('Failed to load blacklist');
    }
  }

  //紅色floatingButton功能( add black car )
  Widget buildAddButton(BuildContext context) =>
      FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.pushNamed(context, '/add_black');
        },
      );

  @override
  Widget build(BuildContext context)
  {
    print('列出黑名單');
    return Scaffold(
      body: FutureBuilder<List<BlackItem>>(
          future: _fetchBLPost(),
          builder: (context, AsyncSnapshot<List<BlackItem>> snapshot) {
            if (snapshot.hasData) {
              final itemList = snapshot.data as List<BlackItem>;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  itemList.isEmpty
                      ? const CircularProgressIndicator()
                      : Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: itemList.length+1,
                          itemBuilder: (context, index) {
                            if (index == itemList.length) {
                              return const SizedBox(
                                height: 85.0,
                                width: double.infinity,
                              );
                            }
                            final task = itemList[index];
                            return Slidable(
                              actionPane: SlidableDrawerActionPane(),
                              child: ListTile(
                                        // leading: CircleAvatar(
                                        //   //這邊backgroundImage: NetworkImage(要改成task.imgurl)
                                        //   backgroundImage: NetworkImage(
                                        //       'https://auto.epochtimes.com/uploaded_files/2015/1/26/87400d9ebd0c49de82ef6c7ad3fc954d.jpg'),
                                        // ),

                                        leading: Icon(Icons.zoom_in_outlined) ,
                                        title: Text(task.expiredDate),
                                        subtitle: Text(task.carPlate),

                                        onTap: () {
                                          //將task資料傳給detail.dart + 頁面route to black_detail
                                          Navigator.pushNamed(context, '/black_detail', arguments: task);
                                        }
                                    ),

                              //向右滑刪除
                              secondaryActions: <Widget>[
                                IconSlideAction(
                                  caption: 'delete',
                                  color: Colors.red,
                                  icon: Icons.delete,
                                  onTap: (){
                                    //將資料刪除
                                    deleteBlack(task.carPlate);

                                    setState(() {
                                      itemList.removeAt(index);
                                    });
                                    //因刪除要卡顯示時間 , 加入此一秒後跳轉回/ , 而右black_list接到新資料而跳回black_list
                                    Future.delayed(Duration(seconds: 1),
                                        ()=>Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false)
                                    );
                                  },

                                )

                              ],
                            );

                          }
                      )
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return CircularProgressIndicator();
            }
          }),
      //+黑名單的floating button
      floatingActionButton: buildAddButton(context),

    );
  }
}


class BlackItem {
  final String carPlate, expiredDate;
  BlackItem({required this.carPlate, required this.expiredDate});

  factory BlackItem.fromJson(Map<String, dynamic> json) {
    return BlackItem(
      carPlate: json['CarPlate'],
      expiredDate: json['ExpiredDate'],
    );
  }
}


