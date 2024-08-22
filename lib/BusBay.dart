import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/BusDetailsPage.dart';

class BusBay extends StatefulWidget {
  const BusBay({super.key});

  @override
  State<BusBay> createState() => _BusBayState();
}

class _BusBayState extends State<BusBay> {

  //List busses=['Bus 1','Bus 1','Bus 1','Bus 1','Bus 1','Bus 1',]


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/main_background_design2.png'),fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.purple.shade500,
          title: Text('BusBay',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: getBody(),
      ),
    );
  }

  Widget getBody() {
    return ListView.builder(
      itemCount: 15,
        itemBuilder: (context,index){
      return getCard(index);
    });
  }
  
  Widget getCard(index) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Bus Number ${index+1}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BusDetailsPage(busNumber:'Bus Number ${index+1}')));
              }, child: Text('View',style: TextStyle(fontSize: 15,),))
            ],
          ),
        ),
      ),
    );
  }



}
