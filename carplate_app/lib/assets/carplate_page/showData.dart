import 'package:flutter/material.dart';

import 'data.dart';
import 'image_dialog.dart';

class ShowData extends StatelessWidget {

  const ShowData({Key? key }) : super(key: key);
  //final Future<List> post;
  //const ShowData({Key? key ,required this.post}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10.0,
      children: List.generate(listData.length, (index) {

        final String img='images/'+listData[index]["Image"];
        //final String img='assets/images/'+listData[index]["Image"];
        return Column(
          children: <Widget>[

            GestureDetector(
              onTap: () async {
                await showDialog(
                    context: context,
                    builder: (_) => ImageDialog(img:img)
                );
              },
              child: Image.asset(img),
            ),


            Text(listData[index]["Number"]),




            // FutureBuilder(
            //     future: post,
            //     builder: (context, snapshot) {
            //       if(snapshot.hasData) {
            //         return Text('123');
            //         //print("data in show data");
            //         //print(snapshot.data);
            //         //return Text(snapshot.data['CarPlate']);
            //       }
            //       else {
            //         return Text("Await for data");
            //       }
            //
            //     }
            // ),





          ],
        );
      }),
    );

  }
}










