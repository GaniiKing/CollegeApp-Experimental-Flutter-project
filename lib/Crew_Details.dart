import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class Crew_Details extends StatefulWidget {
  const Crew_Details({super.key});

  @override
  State<Crew_Details> createState() => _Crew_DetailsState();
}

class _Crew_DetailsState extends State<Crew_Details> {
  
  List users =[];
  bool isLoading = false;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUsers();
  }

  fetchUsers() async  {
    var url = "http://your_ip_address/sample_api/crewdata.php";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode==200){
      var items = json.decode(response.body);
      print(items);
      setState(() {
        users=items;
      });
    }else{
      setState(() {
        users=[];
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background-1.jpg'),fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right:30),
                  child: Image(image:AssetImage('assets/people.png'),fit: BoxFit.cover,),
                )
              ],
            ),
          ],
          elevation: 0,
          title: Text('Crew Data',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        ),
        backgroundColor: Colors.transparent,
        body:getBody(),
      ),
    );
  }
  Widget getBody() {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context,index){
        return getCard(users[index]);
    });
  }

  Widget getCard(item) {
    var name = item['name'];
    var post = item['post'];
    var contact = item['Contact'];
    return ListTile(
      contentPadding: EdgeInsets.only(left: 20,right: 20,top: 30,bottom: 30),
      title:Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight:Radius.circular(40),topLeft: Radius.circular(40),bottomRight: Radius.circular(40),bottomLeft: Radius.circular(10)),
              image: DecorationImage(
                image: AssetImage('assets/whitebackground.png'),fit: BoxFit.cover,
              ),
            ),
            height: 80,
            width: 80,
            child: Center(
              child: CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage('assets/staff_img.png'),
              ),
            ),
          ),
          Card(
            color: Colors.lightGreen.withOpacity(0.2),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 18),
              child:  Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Text('Name:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        Text('$name',style: TextStyle(fontSize: 20),)
                      ],
                    ),
                  ),
                  SizedBox(height:6,),
                  Row(
                    children: [
                      Text('Post:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text('$post',style: TextStyle(fontSize: 20),)
                    ],
                  ),
                  SizedBox(height:6,),

                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Text('Contact:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        Text('$contact',style: TextStyle(fontSize: 20),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
