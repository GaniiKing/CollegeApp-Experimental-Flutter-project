import 'package:flutter/material.dart';
import 'package:untitled1/BusBay.dart';
import 'package:untitled1/ComplaintsPafe.dart';
import 'package:untitled1/Coursers_and_branches.dart';
import 'package:untitled1/Crew_Details.dart';
import 'package:untitled1/TimeTable.dart';
import 'package:untitled1/WorkShops.dart';

import 'AttendClass.dart';

class ShowHomePage extends StatelessWidget {
  const ShowHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50,left: 30,right: 30),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AttendClass()));
                },
                child: Card(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40)
                  ),
                  color: Colors.red.shade400,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text('Attendance',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),),
                      SizedBox(height: 30,),
                      Image(image: AssetImage('assets/borderless_image.png'),width: 70,height: 90,)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BusBay()));
                  },
                  child: Card(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)
                    ),
                    color: Colors.purple.shade500,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text('College Bus',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                        SizedBox(height: 30,),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image(image: AssetImage('assets/bus-stop.png'),width: 50,height: 70,),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>OptionsAndDataScreen()));
                  },
                  child: Card(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)
                    ),
                    color: Colors.yellowAccent.shade400,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Text('Courses &\nBranches',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image(image: AssetImage('assets/mind-mapping.png'),width: 50,height: 70,),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Crew_Details()));
                  },
                  child: Card(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)
                    ),
                    color: Colors.lightGreen.shade400,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: Center(child: Text('Crew',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),),
                        SizedBox(height: 30,),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image(image: AssetImage('assets/staff_img.png'),width: 50,height: 70,),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TimeTable()));
                  },
                  child: Card(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)
                    ),
                    color: Colors.cyan.shade400,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20,),
                          child: Text('Time Table',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                        SizedBox(height: 30,),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image(image: AssetImage('assets/Time_Table.png'),width: 50,height: 70,),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkShops()));
                  },
                  child: Card(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)
                    ),
                    color: Colors.red.shade100,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('WorkShops',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                        SizedBox(height: 30,),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image(image: AssetImage('assets/Work_shop.png'),width: 50,height: 70,),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ComplaintsPage()));
                  },
                  child: Card(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)
                    ),
                    color: Colors.orangeAccent.shade400,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: Text('Enquiery',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                        SizedBox(height: 30,),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image(image: AssetImage('assets/Enq_img.png'),width: 50,height: 70,),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
