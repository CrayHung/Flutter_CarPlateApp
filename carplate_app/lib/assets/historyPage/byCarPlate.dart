import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


TextEditingController searchByCar = new TextEditingController();

class ByCarPlate extends StatefulWidget {
  const ByCarPlate({Key? key}) : super(key: key);

  @override
  State<ByCarPlate> createState() => _ByCarPlate();
}


class _ByCarPlate extends State<ByCarPlate> {


  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),

  );


  @override
  Widget build(BuildContext context) {

    final start = dateRange.start;
    final end = dateRange.end;

    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: searchByCar,
            decoration: InputDecoration(
              icon: Icon(Icons.car_rental_sharp),
              labelText: "請輸入車號",
              labelStyle: TextStyle(
                fontSize: 20,
              ),

            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text( DateFormat('yyyy/MM/dd').format(start)),
                        onPressed: PickDateRange,
                      ),
                    ),
                    const SizedBox(width: 10), //做出簡單間格
                    Expanded(
                      child: ElevatedButton(
                        child:Text(DateFormat('yyyy/MM/dd').format(end)),
                        onPressed: PickDateRange,
                      ),
                    ),
                  ],
                ),
                Text('start : '+dateRange.start.toString()),
                Text('end : '+dateRange.end.toString()),
                Text('車號: '  + searchByCar.text.toString()),
              ],
            ),
          ),
        ],
      ),

    );
  }

  Future PickDateRange() async{
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if(newDateRange==null) return;          //按下X
    setState(()=>dateRange=newDateRange);   //按下save
  }


}
