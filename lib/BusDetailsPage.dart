import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class BusDetailsPage extends StatefulWidget {
  final String busNumber;
   BusDetailsPage({super.key,required this.busNumber});

  @override
  State<BusDetailsPage> createState() => _BusDetailsPageState();
}

class _BusDetailsPageState extends State<BusDetailsPage> {

var finale_data;
List data =[];
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/main_background_design2.png'),fit: BoxFit.cover,
          ),
        ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('${widget.busNumber}',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        ),
        backgroundColor: Colors.transparent,
        body: getBody(),
      ),
    );
  }


  Future<void> fetchData() async {

    var url ="http://your_ip_address/sample_api/busdataRetrieve.php";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode==200){
      var items = json.decode(response.body);
        if(widget.busNumber=='Bus Number 1'){
            data=items;
            print(data);
            setState(() {
              finale_data=data[0];
            });
            print(finale_data);
        }else if(widget.busNumber=='Bus Number 2'){
          data=items;
          print(data);
          setState(() {
            finale_data=data[1];
          });
          print(finale_data);
        }else if(widget.busNumber=='Bus Number 3'){
          data=items;
          print(data);
          setState(() {
            finale_data=data[2];
          });
          print(finale_data);
        }else if(widget.busNumber=='Bus Number 4'){
          data=items;
          print(data);
          setState(() {
            finale_data=data[0];
          });
          print(finale_data);
        }else if(widget.busNumber=='Bus Number 5'){
          data=items;
          print(data);
          setState(() {
            finale_data=data[0];
          });
          print(finale_data);
        }else if(widget.busNumber=='Bus Number 6'){
        data=items;
        print(data);
        setState(() {
          finale_data=data[0];
        });
        print(finale_data);
      }else if(widget.busNumber=='Bus Number 7'){
        data=items;
        print(data);
        setState(() {
          finale_data=data[0];
        });
        print(finale_data);
      }else if(widget.busNumber=='Bus Number 8'){
        data=items;
        print(data);
        setState(() {
          finale_data=data[0];
        });
        print(finale_data);
      }else if(widget.busNumber=='Bus Number 9'){
        data=items;
        print(data);
        setState(() {
          finale_data=data[0];
        });
        print(finale_data);
      }else if(widget.busNumber=='Bus Number 10'){
        data=items;
        print(data);
        setState(() {
          finale_data=data[0];
        });
        print(finale_data);
      }else if(widget.busNumber=='Bus Number 11'){
        data=items;
        print(data);
        setState(() {
          finale_data=data[0];
        });
        print(finale_data);
      }else if(widget.busNumber=='Bus Number 12'){
        data=items;
        print(data);
        setState(() {
          finale_data=data[0];
        });
        print(finale_data);
      }else if(widget.busNumber=='Bus Number 13'){
        data=items;
        print(data);
        setState(() {
          finale_data=data[0];
        });
        print(finale_data);
      }else if(widget.busNumber=='Bus Number 14'){
        data=items;
        print(data);
        setState(() {
          finale_data=data[0];
        });
        print(finale_data);
      }else if(widget.busNumber=='Bus Number 15'){
        data=items;
        print(data);
        setState(() {
          finale_data=data[0];
        });
        print(finale_data);
      }
    }
  }


  Widget getBody() {
    fetchData();
    var driver_name = finale_data['driver_name'];
    var bus_number = finale_data['bus_number'];
    var contact = finale_data['contact'];

    return  Center(
      child: Column(
        children: [
          SizedBox(height: 30,),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/busimage.png'),
            radius: 60,
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Driver Name:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text('$driver_name',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            ],
          ),
          SizedBox(height: 20 ,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Bus Number:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text('$bus_number',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            ],
          ),
          SizedBox(height: 20 ,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Contact:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text('$contact',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            ],
          ),
        ],
      ),
    );
  }



}