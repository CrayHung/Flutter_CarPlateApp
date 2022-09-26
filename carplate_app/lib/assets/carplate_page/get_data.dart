import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as Io;


Future<List> fetchPost() async {


  final response = await http.get(Uri.parse('http://twowayiot.com:8082/api/GetCarDataListByUniqueID/21341,45555'));
  //final response = await http.get(Uri.parse('http://twowayiot.com:8082/api/GetCarDataListByUniqueID/21341,5555,11111,22222,3333,666,77777'));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    List<dynamic> post = jsonData['Details'];
    print('data in get_data');
    print(post[0]['CCTVID']);
    print(post);
    return post;}
/*
    cars = data.map((json) => Post.fromJson(json)).toList();
    print(cars);
    return cars;}
*/
  // If server returns an OK response, parse the JSON.
  //return Post.fromJson(json.decode(response.body)); }

  else { // If that response was not OK, throw an error.
    throw Exception('Failed to load post'); }
}


/*


Future GetData() async {


    var url = Uri.parse(
        'http://twowayiot.com:8082/api/GetCarDataListByUniqueID/21341');
    var response = await http.get(url);

    Map<String, dynamic> jsonData = jsonDecode(response.body);

    List<dynamic> data = jsonData['Details'];
    print(data);
    print(data[0]["ID"]);
    List<Car> cars = [];

    for (var c in data) {
      Car car = Car(c['CCTVID'], c['TxTime'] , c['ID'] , c['CarPlate']);
      cars.add(car);

    }
    print(cars);
    print(cars[0].ID);


     /*var list=[];
    map.forEach((k, v) => list.add(cars(k, v)));
    print(list);


    print(cars.length);
    print(cars.map((e) => e.ID));
    print(cars.map((e) => e.CarPlate));
    */



    return cars;



  }
*/

class Post {
  final CCTVID;
  final TxTime;
  final ID;
  final CarPlate;
  Post({this.CCTVID, this.TxTime, this.ID, this.CarPlate});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      CCTVID: json['CCTVID'] as String,
      TxTime: json['TxTime'] as String,
      ID: json['ID'] as int,
      CarPlate: json['CarPlate'] as String,
    );
  }
}

