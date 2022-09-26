import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path/path.dart';

import 'black_detail.dart';
import 'add_black.dart';

class BlackList extends StatelessWidget {
  BlackList({Key? key}) : super(key: key);

  List all_black_data=[];



//fetch data
  Future<List<BlackItem>> _fetchBLPost() async {
    var ip = dotenv.env['CARPLATE_SERVER_IP'];
    var url = 'http://' + ip! + '/api/CheckBlackList';
    var body = jsonEncode(
        {'ExpiredDate': '2021-02-18 00:00:00.000', 'Token': '12345'});
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      var parsed =
      json.decode(response.body)['blacklistInfos'] as List<dynamic>;
      // all_black_data = parsed;
      return parsed.map((p) => BlackItem.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load blacklist');
    }
  }

  //add black car
  Widget buildAddButton(BuildContext context)=>FloatingActionButton(
    child: Icon(Icons.add),
    backgroundColor: Colors.red,
    onPressed: (){
      // print(all_black_data);
      Navigator.of(context)
          .push(
          MaterialPageRoute(
            builder: (context) => AddBlack(),

          )
      );

    },
  );




  @override
  Widget build(BuildContext context) {

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
                          itemCount: itemList.length + 1,
                          itemBuilder: (context, index) {
                            if (index == itemList.length) {
                              return const SizedBox(
                                height: 85.0,
                                width: double.infinity,
                              );
                            }
                            final task = itemList[index];
                            return Card(
                              child: ListTile(
                                  leading: CircleAvatar(
                                    //這邊backgroundImage: NetworkImage(要改成task.imgurl)
                                    backgroundImage: NetworkImage(
                                        'https://auto.epochtimes.com/uploaded_files/2015/1/26/87400d9ebd0c49de82ef6c7ad3fc954d.jpg'),
                                  ),
                                  title: Text(task.carPlate),
                                  subtitle: Text(task.expiredDate),
                                  trailing: Icon(Icons.arrow_forward),
                                  onTap: () {

                                    //將task資料傳給detail.dart + 頁面route to black_detail
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (BuildContext context)=>BlackDetail(),
                                          settings: RouteSettings(
                                              name: "/black_list",
                                              arguments: task
                                          )
                                      ),);
                                  }),
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


