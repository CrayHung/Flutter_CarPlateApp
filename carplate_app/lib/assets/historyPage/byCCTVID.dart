import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ByCCTVID extends StatefulWidget {
  const ByCCTVID({Key? key}) : super(key: key);

  @override
  State<ByCCTVID> createState() => _ByCCTVID();
}


class _ByCCTVID extends State<ByCCTVID> {

  String dropdownvalue = '1';


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

              DropdownButton<String>(
                hint: Text("選擇CCTVID"),
                value: dropdownvalue,
                  items: [
                    DropdownMenuItem(child: Text('1'),value: "1",),
                    DropdownMenuItem(child: Text('2'),value: "2",),
                    DropdownMenuItem(child: Text('3'),value: "3",),
                  ],
                  onChanged: (String? newvalue){
                    setState(() {
                      dropdownvalue=newvalue.toString();
                    });
                  },
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
                    Text('CCTVID : '+dropdownvalue),

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
