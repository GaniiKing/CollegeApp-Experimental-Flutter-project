  import 'dart:convert';

  import 'package:flutter/cupertino.dart';
  import 'package:http/http.dart' as http;
  import 'package:flutter/material.dart';

  class TimeTable extends StatefulWidget {
    const TimeTable({super.key});

    @override
    State<TimeTable> createState() => _TimeTableState();
  }

  class _TimeTableState extends State<TimeTable> {

    List items = [];


    fetchItems() async {
      var url = "http://your_ip_address/sample_api/TimeTables.php";
      var res = await http.get(Uri.parse(url));

      print(res.statusCode);
      print(res.body);
      if(res.statusCode==200) {
        var data = json.decode(res.body);
        setState(() {
          items=data;
        });
      }

    }


    Widget getDesign(part) {
      var Dept = part['dept'];
      var sem = part['sem'];
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('$Dept,$sem',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ElevatedButton(onPressed: (){

                }, child: Text('Download'))
              ],
            ),
          ),
        ),
      );
    }




    @override
    Widget build(BuildContext context) {
      fetchItems();
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/TimeTableBackground.jpg'),fit: BoxFit.cover
          )
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Time Tables',style: TextStyle(fontSize: 20),),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 13),
                child: Image(image: AssetImage('assets/Time_Table.png')),
              )
            ],
          ),
          backgroundColor: Colors.transparent,
          body: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context,index){
            return getDesign(items[index]);
          }),
        ),
      );
    }
  }
