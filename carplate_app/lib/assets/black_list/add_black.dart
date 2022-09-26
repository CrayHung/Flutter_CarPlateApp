import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';

bool set_Dialog = false;
TextEditingController newBlackCarPlate = new TextEditingController();
TextEditingController newBlackCarExpiredDate = new TextEditingController();

class AddBlack extends StatelessWidget{

  const AddBlack({Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context){
    print('增加 黑名單');
    return Scaffold(
      //appBar: AppBar(title: Text('增加黑名單車輛'),),
      body:Column(
        children: [
          Expanded(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('車號')),
                  DataColumn(label: Text('設定到期日')),
                ],
                rows: [
                  DataRow(
                      cells: [
                        DataCell(TextField(
                          controller: newBlackCarPlate,
                          decoration: InputDecoration(
                            hintText: 'ex: ABC-1234',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        )),
                        DataCell(TextField(
                          controller: newBlackCarExpiredDate,
                          decoration: InputDecoration(
                            hintText: 'ex: 2022-01-01',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        )),
                      ]),
                ],
              ),
          ),
        ],



      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_arrow,
        children: [

          //確認跳出警告視窗
          SpeedDialChild(
            child: Icon(Icons.save),
            backgroundColor: Colors.red,
            label: '儲存',
            onTap: () {
              set_Dialog=true;
              showAlertDialog(context);
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

void showAlertDialog(BuildContext context) {

  String plate = newBlackCarPlate.text.toString();
  //String date = newBlackCarExpiredDate.text.toString();
  String date = newBlackCarExpiredDate.text.toString() + ' 00:00:00.000';

  print('date');
  print(date);
  print('plate');
  print(plate);



  //Fetch DB (新增此筆黑名單)
  Future<http.Response> addBlackCarToDB() async{
    var url = 'http://twowayiot.com:8077/api/SetBlackList';
    var body =
    {
      'Token': '12345',
      "CarInfos":[
        {
          'CarPlate': plate,
          "DataStatus": "I",
          'ExpiredDate': date
        }
      ],
    };

    print("body");
    print(body);
     final response = await http.post(
        Uri.parse(url),
         headers: {"Content-Type": "application/json"},
        body:jsonEncode(body)
    );
    if(response.statusCode==200){
        print('新增成功');
      }else{
        print('新增失敗');
      }
    return response;


  }

  if (set_Dialog) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("新增此筆黑名單?"),
          content: Column(
            children: [
              Text('車號:' + newBlackCarPlate.text),
              Text('到期日:' + newBlackCarExpiredDate.text),
            ],
          ),
          actions: [
            ElevatedButton(
                child: Text("OK"),
                onPressed: () {
                  set_Dialog = false;
                  //新增資料到DB
                  addBlackCarToDB();
                  //返回root+刪除所有子分頁
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);


                  //print('ok');

                }
            ),
            ElevatedButton(
                child: Text("Cancel"),
                onPressed: () {
                  set_Dialog = false;
                  Navigator.of(context).pop();
                }
            ),
          ],
        );
      },
    );
  } else;
}
