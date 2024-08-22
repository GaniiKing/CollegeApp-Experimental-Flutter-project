import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkShops extends StatefulWidget {
  const WorkShops({super.key});

  @override
  State<WorkShops> createState() => _WorkShopsState();
}

class _WorkShopsState extends State<WorkShops> {



  Widget getCards(index) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
      child: Card(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20/2),topRight: Radius.circular(20/2),bottomRight: Radius.circular(20/2),bottomLeft: Radius.circular(20/2))
        ),
        color: Colors.red.withOpacity(0.5),
        child: const Row(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Image(
                height: 150,
                width: 150,
                image: AssetImage('assets/people.png'),fit: BoxFit.cover,),
            ),
            Text('This is about')
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/WorsHopBackGround.jpg'),fit: BoxFit.cover
          )
        ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.blue.withOpacity(0.7),
          title: Text('WorkShops',style: TextStyle(fontSize: 20),),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 13,),
              child: Image(image: AssetImage('assets/WorkshopAppBarimage.png')),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: 20,
            itemBuilder: (context,index){
          return getCards(index);
        }),
      ),
    );
  }
}
