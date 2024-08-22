import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/DeptUpdates.dart';
import 'package:untitled1/MyUpdates.dart';
import 'package:untitled1/MyYearUpdates.dart';


class UpdatesOptionsPage extends StatelessWidget {
  const UpdatesOptionsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyUpdates()));
                },
                child: Card(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('My Updates',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyYearUpdates()));
                },
                child: Card(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0,bottom: 20,right: 40,left: 40),
                    child: Text('My Year',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DeptUpdates()));
                },
                child: Card(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('Department',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
