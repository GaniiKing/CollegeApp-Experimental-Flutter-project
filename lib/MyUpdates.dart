import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyUpdates extends StatefulWidget {
  const MyUpdates({super.key});

  @override
  State<MyUpdates> createState() => _MyUpdatesState();
}

class _MyUpdatesState extends State<MyUpdates> {
  List Updates =[];
  String number="";

  @override
  void initState(){
    //TODO:implement initState
    super.initState();
    fetchUpdates();
  }


  Future<void> fetchUpdates() async {


    SharedPreferences myprefs = await SharedPreferences.getInstance();
    String? name = myprefs.getString('Number');
    print(name);

    print('fetching users...');
    var url="http://your_ip_address/sample_api/updates.php";
    var response = await http.post(Uri.parse(url),body: {
      'dept':name,
    });
    print(response.body);
    if(response.statusCode==200){
      var items = json.decode(response.body);
      print('items are $items');
      setState(() {
        Updates=items;
      });
    }else{
       Updates=[];
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/main_background_design2.png'),fit: BoxFit.cover,
        )
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text('My Updates',style: TextStyle(fontSize: 20),),
        ),
        backgroundColor: Colors.transparent,
        body: getBody(),
      ),
    );
  }


  Widget getBody() {
    print(Updates);
    var reversedUpdates = Updates.reversed.toList();
    return ListView.builder(
        itemCount: reversedUpdates.length,
        itemBuilder: (context,index){
          return getCard(reversedUpdates[index]);
        });
  }

  Widget getCard(part){
    var name = part['name'];
    var update = part['update'];
    var time = part['time'];


    return ListTile(
      title: Card(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20/2),topLeft: Radius.circular(20/2),bottomRight: Radius.circular(20/2),)
        ),
        color: Colors.yellow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0,top: 8.0),
              child: Text('$name :',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('$update',style: TextStyle(fontSize: 20),),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0,bottom: 8.0),
                  child: Text('$time'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
