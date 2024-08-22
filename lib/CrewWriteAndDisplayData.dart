import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/WriteDeptUpdates.dart';
import 'WriteClassUpdates.dart';
import 'WriteYearUpdates.dart';

class WriteAndShowUpdatesOptionsPage extends StatelessWidget {
  const WriteAndShowUpdatesOptionsPage({super.key});

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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>WriteClassUpdates()));
                },
                child: Card(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('Class Level',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>WriteYearUpdates()));
                },
                child: Card(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0,bottom: 20,right: 40,left: 40),
                    child: Text('Year Level',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>WriteDeptUpdates()));
                },
                child: Card(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('Department Level',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
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
