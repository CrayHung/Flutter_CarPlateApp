import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'image_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

Future<AllCars> fetchCars() async {
  final response =
  await http.get(Uri.parse('http://twowayiot.com:8082/api/GetCarDataListByUniqueID/11111,88888,111111,444555,578888,7777,12455'));


  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    //print(json.decode(response.body));
    return AllCars.fromJson(json.decode(response.body));

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}


class AllCars {

  final List<Car> Details;

  AllCars({required this.Details});

  factory AllCars.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['Details'] as List;
    //print(list);
    //print('list length = ${list.length}');

    List<Car> carList = list.map((i) => Car.fromJson(i)).toList();
    print('carList');
    print(carList[0].CCTVID);   //CAM_018

    return AllCars(
        Details: carList

    );
  }
}


class Car {

  final String CCTVID;
  final String CarPlate;
  final String TxTime;
  final int ID;

  Car({required this.CCTVID,required this.CarPlate,required this.TxTime,required this.ID});
  factory Car.fromJson(Map<String, dynamic> parsedJson){
    return Car(
      CCTVID:parsedJson['CCTVID'],
      CarPlate:parsedJson['CarPlate'],
      TxTime:parsedJson['TxTime'],
      ID: parsedJson['ID'],
    );
  }
}



// Future<http.Response> fetchBase64(){
//   return http.get(Uri.parse('http://twowayiot.com:8082/api/GetSingleImageByUniqueID/240/2320391'));
// }
//
// class base64Str{
//   final String base64String;
//
//   const base64Str({
//     required this.base64String,
//   });
//
// }




class CarPlatePage extends StatefulWidget {
  @override
  _CarPlatePageState createState() => _CarPlatePageState();
}

class _CarPlatePageState extends State<CarPlatePage> {
  late Future<AllCars> futureCars;

  final Image noImage = Image.asset("images/1.jpg");
  String imgBase64Str = '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';
  String imgBase64Str2 ='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';
  String? _base64;
  //String nonNullbase64 = _base64 ?? '';

  // http.Response base64response = http.get(Uri.parse('http://twowayiot.com:8082/api/GetSingleImageByUniqueID/240/2320391'));

  // String _base64 = BASE64.encode(base64response.bodyBytes);
  //
  //
  // Uint8List bytes = BASE64.decode(_base64);


  void getBase64() async{
    http.Response response = await http.get(Uri.parse(
      'http://twowayiot.com:8082/api/GetSingleImageByUniqueID/240/2320391',
    ));

    print('response in getBase64()');
    print(response);
    //return base64.encode(response.bodyBytes);
    // return response;
    // if (mounted) {
      setState(() {
        //_base64 = base64.encode(response.bodyBytes);

        // List<int> bytes = Converter(base64Decode(response)) as List<int>;
        // String result = Converter(utf8.decode(bytes)) as String;
        // _base64 = result;


      });
      print('_base64 in getBase64()');
       print(_base64);
    //   return _base64;
    // }
  }

  @override
  void initState() {
    super.initState();


    // (() async {
    //   http.Response response = await http.get(Uri.parse(
    //     'http://twowayiot.com:8082/api/GetSingleImageByUniqueID/240/2320391',
    //   ));
    //   if (mounted) {
    //     setState(() {
    //       _base64 = base64.encode(response.bodyBytes);
    //     });
    //     print(_base64);
    //   }
    // })();
    getBase64();
    //_base64 = getBase64();
    futureCars =  fetchCars();

  }


  @override
  Widget build(BuildContext context) {
    //print(_base64);

    return MaterialApp(
      home: Scaffold(

        body: Center(
          child: FutureBuilder<AllCars>(
            future: futureCars,
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {


                  return GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(
                        snapshot.data.Details.length, (index) {
                      return Card(child:
                      Container(
                          alignment: Alignment.topCenter,
                          //color:Colors.lightGreen,
                          //child:Text('${snapshot.data?.Details[index].CarPlate}'.toString()),
                          child: Column(
                            children: [

                              GestureDetector(
                                onTap: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (_) =>
                                          ImageDialog(img: imgBase64Str)
                                  );
                                },

                                child:Image.memory(base64Decode(imgBase64Str)),
                                //child:Image.memory(base64Decode(_base64!)),

                                // child:
                                // Container(
                                //   child: (_base64 != null)
                                //     ? Image.memory(base64Decode(_base64.toString()))
                                //     :noImage
                                // //child:Image.network('http://twowayiot.com:8082/api/image/320/${snapshot.data?.Details[index].ID}.jpg'),
                                //
                                //   ),


                              ),
                              Text('${snapshot.data?.Details[index].CarPlate}'
                                  .toString()),
                              Text('ID : ${snapshot.data?.Details[index].ID}')
                            ],
                          )
                        //Image.network('http://twowayiot.com:8082/api/image/640/21341.jpg'),
                      )
                      );
                    }),
                  );

                  // return GridView.builder(
                  //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  //       maxCrossAxisExtent: 100,
                  //       //如果要調整長寬比 , 調整以下childAspectRatio
                  //         //childAspectRatio: 2/3
                  //     ),
                  //     itemBuilder: (context,idx){
                  //       return Card(
                  //         child:Container(
                  //           child:Text('index:$idx'),
                  //         ),
                  //       );
                  //     });
                  //return Text('${snapshot.data?.Details[0].CarPlate}');

              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
